/*Description :Test class for Contact trigger.
 * Revision History:
 *
 *  Version          Author              Date                Description
 *  1.0              Rahul Panditrao    07/28/2015           Initial Draft
 *   

*/
@isTest
private class HandlerEFT_Transaction_StatusTest {
	
	static testMethod void validCaseCreation() {
		SalesHeader_c__c objSalesHeader = new SalesHeader_c__c();
		objSalesHeader.Name = 'Sales3';
		objSalesHeader.Status__c = 'Open';
		insert objSalesHeader;
		EFT_Transaction_Status__c  objEFT = new EFT_Transaction_Status__c();
		objEFT.Name='TestEFT';
		objEFT.Method__c='Credit Card Address Verify';
		objEFT.Transaction_Status__c ='Declined';
		objEFT.SalesHeader__c = objSalesHeader.id;
		Integer counterCasesB4=0;
		Integer counterCasesAfter=0;
		for(case c : [select id from case]){    
			counterCasesB4 ++;
		}    
		
		Test.startTest();
		insert objEFT;   
		Test.stopTest();
		
		for(case c : [select id from case]){
			counterCasesAfter ++;
		}
		System.assertEquals(1,counterCasesAfter);       
	}

	static testMethod void transactionStatusDoesNotMatch() {
		SalesHeader_c__c objSalesHeader = new SalesHeader_c__c();
		objSalesHeader.Name = 'Sales3';
		objSalesHeader.Status__c = 'Open';
		insert objSalesHeader; 
		EFT_Transaction_Status__c  objEFT = new EFT_Transaction_Status__c();
		objEFT.Name='TestEFT';
		objEFT.Method__c='Credit Card Address Verify';
		objEFT.Transaction_Status__c ='Accepted';
		objEFT.SalesHeader__c = objSalesHeader.id;	   
		Test.startTest();
		Integer counterCasesB4=0;
		Integer counterCasesAfter=0;
		for(case c : [select id from case]){    
			counterCasesB4 ++;
		}
		insert objEFT; 
		for(case c : [select id from case]){
			counterCasesAfter ++;
		}
		Test.stopTest();
		System.assertEquals(counterCasesB4,counterCasesAfter);       
		}
				
	static testMethod void transactionMethodDoesNotMatch() {
		SalesHeader_c__c objSalesHeader = new SalesHeader_c__c();
		objSalesHeader.Name = 'Sales3';
		objSalesHeader.Status__c = 'Open';
		insert objSalesHeader;	 
		EFT_Transaction_Status__c  objEFT = new EFT_Transaction_Status__c();
		objEFT.Name='TestEFT';
		objEFT.Method__c='Credit Card';
		objEFT.Transaction_Status__c ='Declined';
		objEFT.SalesHeader__c = objSalesHeader.id;   
		Test.startTest();
		Integer counterCasesB4=0;
		Integer counterCasesAfter=0;
		for(case c : [select id from case]){    
			counterCasesB4 ++;
		}
		insert objEFT; 
		for(case c : [select id from case]){
			counterCasesAfter ++;
		}
		Test.stopTest();
		System.assertEquals(counterCasesB4,counterCasesAfter);       
	}
			
	static testMethod void SalesHeaderStatusDoesNotMatch() {
		SalesHeader_c__c objSalesHeader = new SalesHeader_c__c();
		objSalesHeader.Name = 'Sales3';
		objSalesHeader.Status__c = 'Closed';
		insert objSalesHeader; 
		EFT_Transaction_Status__c  objEFT = new EFT_Transaction_Status__c();
		objEFT.Name='TestEFT';
		objEFT.Method__c='Credit Card Address Verify';
		objEFT.Transaction_Status__c ='Declined';
		objEFT.SalesHeader__c = objSalesHeader.id;   
		Test.startTest();
		Integer counterCasesB4=0;
		Integer counterCasesAfter=0;
		for(case c : [select id from case]){    
			counterCasesB4 ++;
		}
		insert objEFT; 
		for(case c : [select id from case]){
			counterCasesAfter ++;
		}
		Test.stopTest();
		System.assertEquals(counterCasesB4,counterCasesAfter);       
	}
	
	static testMethod void NoConditionsMatch() {
		SalesHeader_c__c objSalesHeader = new SalesHeader_c__c();
		objSalesHeader.Name = 'Sales3';
		objSalesHeader.Status__c = 'Closed';
		insert objSalesHeader;
		EFT_Transaction_Status__c  objEFT = new EFT_Transaction_Status__c();
		objEFT.Name='TestEFT';
		objEFT.Method__c='Credit Card';
		objEFT.Transaction_Status__c ='Accept';
		objEFT.SalesHeader__c = objSalesHeader.id;   
		Test.startTest();
		Integer counterCasesB4=0;
		Integer counterCasesAfter=0;
		for(case c : [select id from case]){    
			counterCasesB4 ++;
		}
		insert objEFT; 
		for(case c : [select id from case]){
			counterCasesAfter ++;
		}
		Test.stopTest();
		System.assertEquals(counterCasesB4,counterCasesAfter);       
	}
	
	static testMethod void BulkInsert() {
		SalesHeader_c__c objSalesHeader = new SalesHeader_c__c();
		objSalesHeader.Name = 'Sales3';
		objSalesHeader.Status__c = 'Closed';
		insert objSalesHeader; 
		List<EFT_Transaction_Status__c> ListEFT = new List<EFT_Transaction_Status__c>();
		for(Integer i=0; i<100; i++){
			ListEFT.add( new EFT_Transaction_Status__c(Name='TestEFT' +i,
			Method__c='Credit Card', Transaction_Status__c ='Accept',SalesHeader__c = objSalesHeader.id));
		}
		Test.startTest();
		Integer counterCasesB4=0;
		Integer counterCasesAfter=0;
		for(case c : [select id from case]){    
			counterCasesB4 ++;
		}
		insert ListEFT; 
		for(case c : [select id from case]){
			counterCasesAfter ++;
		}
		Test.stopTest();
		System.assertEquals(counterCasesB4,counterCasesAfter);       
	}
}