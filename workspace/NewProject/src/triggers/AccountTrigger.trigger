trigger AccountTrigger on Account (after insert) {
    
    if(trigger.isAfter){
        if(trigger.isInsert){
            //AccountCloneHandler.cloneTheRecordOfAccount=new AccountCloneHandler();
            // system.debug('creating handler object');
            //AccountHandler.cloneTheRecordOfAccount(trigger.new); 
              
        }
    }

}