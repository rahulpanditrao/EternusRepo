trigger ContactTrigger on Contact (before insert) {
	
	if(Trigger__c.getInstance(UserInfo.getUserId()).contactDisableTrigger__c == false){
	
	
		if(trigger.isBefore)
		{
			if(trigger.isInsert){
	              system.debug('_____into trigger___');
				//ContactHandler.DuplicateContactBeforeInsert(trigger.new);
				//ContactHandler.assignAccountId(trigger.new);
			}
			
		}
	}
	
}