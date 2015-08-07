trigger EFT_Transaction_Status on EFT_Transaction_Status__c (after insert) {
	
	//system.debug('+++++++++++++++++++++++++++++++++++++++++');
    
	if(trigger.isAfter && trigger.isInsert)
	{
		//system.debug('+++++++++++++++++++++++++++++++++++++++++');
		HandlerEFT_Transaction_Status.insertCase(trigger.new);
		
	}
}