@isTest
private class BatchClassEventsTest {
    static testMethod void testBatch() {
    	
    	Event__c testEvent = new Event__c(Processed__c = false , Json__c = '{"Name" : "Eternus Solutions"}', ObjectRecordToCreate__c = 'Account');
    	insert testEvent;
        system.debug ('------------after Insert test ------- testEvent : ' + testEvent);
    	
    	test.startTest();
    	system.debug ('------------before execute------- testEvent : ' + testEvent);
    	Database.executeBatch(new BatchClassEvents());
    	system.debug ('------------after execute------- testEvent : ' + testEvent);
        test.stopTest();
        system.debug ('------------after stop test------- testEvent : ' + testEvent);
        
        Event__c eventObject = [
        	SELECT Id
        	     , Name
        	     , Processed__c
        	     , Succeded_inserts__c
        	     , UnSucceeded_results__c
        	 FROM Event__c
        ];
        
        System.assertEquals(true, eventObject.Processed__c, '-------------------------------------- eventObject ' + eventObject);

    }
}