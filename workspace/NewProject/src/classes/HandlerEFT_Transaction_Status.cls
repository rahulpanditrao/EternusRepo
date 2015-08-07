/*Description :Handler class for EFT trigger.
 * Revision History:
 *
 *  Version          Author              Date                Description
 *  1.0              Rahul Panditrao    07/28/2015           Initial Draft
 *   

*/
public with sharing class HandlerEFT_Transaction_Status {
		
	public static void insertCase(List <EFT_Transaction_Status__c>ListEFT){
			
		system.debug('+++++++++++++++++++++into handler++++++++++++++++++++');
		List<SalesHeader_c__c> salesList=new List<SalesHeader_c__c>();
		Set<ID> salesheaderID=new Set<ID>();
			
		for(EFT_Transaction_Status__c eftList:ListEFT ){
			salesheaderID.add(eftList.salesheader__c);
		}
		for(SalesHeader_c__c sH: [SELECT status__c,
												  id
										  FROM SalesHeader_c__c
										  WHERE id IN:salesheaderID ]){
			salesList.add(sh);
		}
		Map<id,SalesHeader_c__c> salesHeaderIDMap=new Map<id,SalesHeader_c__c>();
				
		for(SalesHeader_c__c salesRecord : [SELECT status__c, 
															id, 
															Account_Type__c, 
															Contact__c 
													FROM SalesHeader_c__c 
													WHERE id IN:salesheaderID]){
			salesHeaderIDMap.put(salesRecord.id,salesRecord);
		}
		List<case>ListCases=new List<case>();
		system.debug('+++++++++++++++++++++++++++++++++++++++++');
				
		for(EFT_Transaction_Status__c eTransaction   :   ListEFT ){
					
			SalesHeader_c__c Salesheaderobj=salesHeaderIDMap.get(eTransaction.SalesHeader__c);
						
			if(eTransaction.method__c == 'Credit Card Address Verify'  
						&& eTransaction.Transaction_Status__c =='Declined' 
						&& Salesheaderobj.status__c=='open'   ){					
				Case tempCase= new Case();					
				tempCase.AccountId = Salesheaderobj.Account_Type__c;						
				tempCase.ContactId = Salesheaderobj.Contact__c;     						
				//id recordTypeInternal='012280000000mjA';//ASK AMIT WITHOUT FAIL!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!						
				tempCase.RecordTypeId  = Schema.SObjectType.Case.getRecordTypeInfosByName().get('assignment').getRecordTypeId();						
				tempCase.Origin = 'Internal';
				list<QueueSobject> queueId = [SELECT QueueId
										  	  FROM QueueSobject q 
											  WHERE q.Queue.Name ='My first queue'];				
			    tempCase.OwnerId =queueId[0].QueueId;
			   // system.debug('11111111111111'+queueId[0].Id  );
				tempCase.Reason = 'Address Did Not Verify'; 						
				tempCase.Priority = 'High';						
				tempCase.Status = 'New'; 				
				tempCase.Subject=account.name +''+ tempCase.Type ;						
				tempCase.Open_Sales_Order__c= Salesheaderobj.id;			
				tempCase.Transaction_Status__c=eTransaction.Transaction_Status__c;		
				ListCases.add(tempCase); 	
			}	
		}
			insert ListCases;	
	}
}