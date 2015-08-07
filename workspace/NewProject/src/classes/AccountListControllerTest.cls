@isTest
private class AccountListControllerTest {

    static testMethod void displayingAccounts() {
    	
    	 List<Account> accList = AccountListControllerTest.createAccountRecords();
    	 insert accList;
                            
     	Contact contactobject1 = new Contact(LastName='Contact1',
                                          AccountId=accList[0].Id);
     
     	Contact contactobject2 = new Contact(LastName='Contact2', 
                                          AccountId=accList[1].Id);
        insert contactobject1;
        insert contactobject2;
       
        AccountListController controlerInstance = new AccountListController();
        controlerInstance.flagForSearchBox= false;
    	
    	List<Account> lacc = new List<Account>();
    	lacc=controlerInstance.getListAccount();
    	system.assertequals(2,lacc.size());
    	 
    	
    	
    	controlerInstance.searchText= 'tud';
        controlerInstance.flagForSearchBox= false;
        controlerInstance.searchAccounts();
        system.assert(controlerInstance.flagForSearchBox == true);
    	
    	
    	controlerInstance.searchText= 'tu';
        controlerInstance.flagForSearchBox= false;
        controlerInstance.searchAccounts();
        system.assert(controlerInstance.flagForSearchBox == False);
        
        controlerInstance.searchText= ''; 
        controlerInstance.flagForSearchBox= false;
        controlerInstance.searchAccounts();
        system.assert(controlerInstance.flagForSearchBox == False);
        
        
        controlerInstance.incrementCounter();
        controlerInstance.getCount();
        
        
        pagereference pgrfAcc = page.AccountList;
        pgrfAcc.getParameters().put('AccountId',accList[0].Id);
        pgrfAcc.getParameters().put('AccountName',accList[0].Name);
      //  test.setCurrentPage(pgrfAcc);
        system.debug('-------------------------------------'+ApexPages.currentPage().getParameters().get('AccountId'));
        controlerInstance.RedirectToContacts();
        //system.debug('-------------------------------------'+controlerInstance.RedirectToContacts());
        //system.debug('-------------------------------------'+accList[0].id);
        
        system.debug('---------------------AccountName----------------'+ApexPages.currentPage().getParameters().get('AccountName1'));
        system.debug('---------------------ApexPages.currentPage()----------------'+ApexPages.currentPage());
        system.debug('-------------------Account------------------'+ApexPages.currentPage().getParameters().get('Account'));
        system.debug('===================ApexPages.currentPage().getParameters()=='+ApexPages.currentPage().getParameters());
        //system.assert(ApexPages.currentPage().getParameters().get('Account') == accList[0].id); 
        
        AccountListController.deleteContact(contactobject2.id);
        
        List<Contact> conDelList = new List<Contact>();  
        conDelList.add(new Contact(LastName = 'Rahul')); 
        conDelList=[SELECT Id
                    FROM Contact 
                    WHERE Id = :contactobject2.id]; 
        system.assertEquals(0,conDelList.Size()); 
        
        controlerInstance.flagForContactPageBlock = true; 
        controlerInstance.characterSelected = 'R';
        controlerInstance.getRelatedContactsList();
        system.assertEquals(conDelList[0].Id,controlerInstance.RelatedContactsList[0].id); 
         
        
        
        
    }
    
    
    static testMethod List<Account> createAccountRecords(){
        List<Account> accList = new List<Account>();  
        Account accObj1 = new Account(Name='tudip');
        Account accObj2 = new Account(Name='pascal');
        accList.add(accObj1);
        accList.add(accObj2);
        return accList;
    } 
    
    static testMethod List<Contact> createContactRecords(){
        List<Contact> conList = new List<Contact>();  
        Contact conObj1 = new Contact(LastName='tudip');
        Contact conObj2 = new Contact(LastName='pascal');
        conList.add(conObj1);
        conList.add(conObj2);
        return conList;
    } 
     
}    
    
    /*
    static testMethod void searchButtonTest(){
        List<Account> accList = AccountListControllerTest.createAccountRecords();
        insert accList;
        AccountListController controlerInstance = new AccountListController();
        controlerInstance.searchText= 'tud';
        controlerInstance.flagForSearchBox= false;
        controlerInstance.searchAccounts();
        system.assert(controlerInstance.flagForSearchBox == true);
        
        controlerInstance.searchText= 'tu';
        controlerInstance.flagForSearchBox= false;
        controlerInstance.searchAccounts();
        system.assert(controlerInstance.flagForSearchBox == False);
        
        controlerInstance.searchText= ''; 
        controlerInstance.flagForSearchBox= false;
        controlerInstance.searchAccounts();
        system.assert(controlerInstance.flagForSearchBox == False);
        
        
    }
    
    
    
    
    
    static testMethod void redirectToContactsTest(){
        List<Account> accList = AccountListControllerTest.createAccountRecords();
        pagereference pgrfAcc = page.AccountList;
        pgrfAcc.getParameters().put('id',accList[0].Id);
        pgrfAcc.getParameters().put('Name',accList[0].Name);
        AccountListController AccountListController= new AccountListController();
        AccountListController.RedirectToContacts();
        system.assert(ApexPages.currentPage().getParameters().get('Account') == accList[0].id); 
 
    }
    
    static testMethod void getRelatedContactsTest(){
        List<Account> accList = AccountListControllerTest.createAccountRecords();
        Contact contactobject1 = new Contact(LastName='Contact1',
                                          AccountId=accList[0].Id);
     
        Contact contactobject2 = new Contact(LastName='Contact2', 
                                          AccountId=accList[1].Id);                                                                 
        pagereference pgrfAcc = page.RelatedContacts;
        //pgrfAcc.getParameters().put('id',accList[0].Id);
        //pgrfAcc.getParameters().put('Name',accList[0].Name);
        //AccountListController AccountListController= new AccountListController();
        //AccountListController.RedirectToContacts();
       // AccountListController.flagForContactPageBlock = false;
        //AccountListController.getRelatedContactsList();
        //system.assertEquals(1,AccountListController.contactsCount);

    } */