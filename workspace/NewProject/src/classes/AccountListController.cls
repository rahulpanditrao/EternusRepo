global with sharing class AccountListController { 
    List<Account> listAccount;
    Integer count = 0;
    public String searchText{get;set;}
    public Integer accountCount{get;set;}
    public Integer contactsCount {get;set;} 
    public Id idOfAccount {get;set;}
    public String nameOfAccount {get;set;}
    public Integer countOfContacts{get;set;}
    public Boolean flagForSearchBox{get;set;}
    public List<String> filterChar{get;set;}
    public Boolean flagForContactPageBlock{get;set;}
    public List<Contact> RelatedContactsList;
    public String characterSelected{get;set;}
    
    public PageReference incrementCounter() {
    count++;
    return null;
    
    }
    
    public Integer getCount() {
      return count;
    }
    public AccountListController(){
        filterChar = new List<String>{'A','B','C','D','E','F','G','H','I','J','K','L','M','N','O','P','Q','R','S','T','U','V','W','X','Y','Z'};
    flagForSearchBox = false;
    flagForContactPageBlock=false;    
    }
    
    public List<Account> getListAccount() { 
        if(flagForSearchBox == false){
      listAccount = [SELECT Id,
                              Name,
                              Phone,
                              Website
                       FROM Account
                       ORDER BY Name
                       LIMIT 30];
      accountCount=listAccount.size(); 
        }
        else{
          
          listAccount = [SELECT Id,
                              Name,
                              Phone,
                              Website
                       FROM Account 
                       WHERE Name LIKE :searchText+'%'
                       ORDER BY Name
                       LIMIT 30];
      accountCount=listAccount.size();   
        }
        return(listAccount);
    }
    
    public PageReference RedirectToContacts() {
        idOfAccount = ApexPages.currentPage().getParameters().get('AccountId');
        nameOfAccount = ApexPages.currentPage().getParameters().get('AccountName'); 
        PageReference pageRef = Page.RelatedContacts;
        pageRef.getParameters().put('Account', idOfAccount);
        pageRef.getParameters().put('AccountName1', nameOfAccount);
        system.debug('pageRef===='+pageRef);
        pageRef.setRedirect(true);
        return pageRef;
    }

  public void searchAccounts(){
    if(searchText.length() < 3){
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Please enter atleast three alphabets in search text')); 
    }
    else{
    
      if(searchText == NULL || String.Isblank(searchText)==true){
        system.debug('++++++++++++++++++++++++++++++++++++++++++++++++');
        
        
        
        ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Please enter search text'));
        
      }
      else{
        flagForSearchBox=true;
        getListAccount();  
      }
    }
  }

  public void setContactsFlag(){
     flagForContactPageBlock=true;
     getRelatedContactsList();
     
  }
    public List<Contact> getRelatedContactsList() {
    
    idOfAccount = ApexPages.currentPage().getParameters().get('Account');
        
        nameOfAccount = ApexPages.currentPage().getParameters().get('AccountName');
       
        characterSelected=ApexPages.currentPage().getParameters().get('charSelected');
        
        if(flagForContactPageBlock==false){
          RelatedContactsList = [SELECT Id,
                                                Name,
                                                Phone,
                                                MobilePhone
                                         FROM Contact 
                                         WHERE AccountId =: idOfAccount];
      contactsCount = RelatedContactsList.size();
      if(!RelatedContactsList.isEmpty()) {
            return RelatedContactsList;
          }
          else {
            return NULL;
      } 
        }
        
        else{
           RelatedContactsList.clear();
           RelatedContactsList = [SELECT Id,
                                                Name,
                                                Phone,
                                                MobilePhone
                                         FROM Contact 
                                         WHERE AccountId =: idOfAccount AND Name LIKE :characterSelected.toLowerCase()+'%'];
       contactsCount = RelatedContactsList.size(); 
       if(!RelatedContactsList.isEmpty()) {
             return RelatedContactsList;
           }
           else {
             return NULL;
       } 
          
        }
    }
    public PageReference returnToAccount() {
        return Page.AccountList;
    }
    
  @RemoteAction
  global static void deleteContact(Id contactId){
    system.debug('++++++++++++++++++++++++++++++++++++'+contactId);
    Contact conToDel=new Contact(id=contactId);  
    
    
    
    List<Case> casesAssociated = new List<Case>();
    casesAssociated = [SELECT Id FROM Case WHERE contactId = :conToDel.Id];
    system.debug('+++++++++++++++++++Cases+++++++++++++++++'+casesAssociated);
    if(casesAssociated != NULL){
      for(Case associatedCase : casesAssociated){
        associatedCase.contactId=NULL;
      }
      UPDATE casesAssociated;
    }
    delete conToDel; 
    system.debug('+++++++++++++++++++Deleted+++++++++++++++++');
    
  }
  
}