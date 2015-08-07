/*Description :Handler class for Contact trigger.
 * Revision History:
 *
 *  Version          Author              Date                Description
 *  1.0              Rahul Panditrao    07/28/2015           Initial Draft
 *   

*/
public with sharing class ContactHandler {
	public static String errorMessage='Duplicate Contact Error!!!!!!!';	
	
	public static void DuplicateContactBeforeInsert(list<Contact> ContactList){
		Map<String,Boolean> mEmail=new map<String,Boolean>();
		Map<String,Boolean> mPhone=new map<String,Boolean>();
		for(Contact contct: ContactList){
			mEmail.put(contct.email,false);
			mPhone.put(contct.phone,false);
		}
		
		for(Contact ContactOld : [SELECT Email,Phone 
									  FROM Contact 
									  WHERE Email IN: mEmail.keySet() OR Phone IN: mPhone.keySet()]){
			if(mEmail.containsKey(ContactOld.Email)){
				mEmail.put(ContactOld.Email,true);
			}
			if(mPhone.containskey(ContactOld.phone)){
				mPhone.put(ContactOld.Phone,true);
			}
		}
		for(Contact contactNew:ContactList){
			if((mEmail.containsKey(contactNew.Email) && mEmail.get(contactNew.Email))==TRUE){
				contactNew.addError(errorMessage);	
			}
			if((mPhone.containsKey(contactNew.Phone) && mPhone.get(contactNew.Phone))==TRUE){
				contactNew.addError(errorMessage);	
			}
		}
	}
	
	//Associating created contact to the account matching to domain name of contact email
	
	public static void assignAccountId(List<Contact> listOfContact){
	  Map<String, Id> mapOfDomainAndAccountId = new Map<String, Id>();
      Set<String> contactDomains=new Set<String>();
      
      for(Contact cntct:listOfContact){
          if(cntct.AccountId==Null){	
          		contactDomains.add(cntct.Email.substringafter('@'));
          }
           
	}
      
	for(Account acc:[SELECT Id,Domain_name__c
                         FROM Account 
                         WHERE Domain_name__c IN :contactDomains]){
		mapOfDomainAndAccountId.put(acc.Domain_name__c,acc.id);
	}   
	for(Contact cntct :listOfContact){
		if(cntct.AccountId == NULL){
          cntct.AccountId=mapOfDomainAndAccountId.get(cntct.Domain_name__c);
		}
	}   
  }
	
}