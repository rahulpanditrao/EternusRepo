global class BatchClassEvents implements Database.batchable<sObject>{    
    public List<Sobject> genericList; 
    public List<Event__C> eventList; 
    
    public BatchClassEvents(){
        genericList = new List<Sobject>();
        eventList = new List<Event__C>();  
    } 
    
      
    global Database.QueryLocator start(Database.BatchableContext BC) {
        String query = 'SELECT Processed__c, ObjectRecordToCreate__c, Name, Json__c FROM Event__c WHERE Processed__c = False';
        system.debug ('---------START----------');
        return Database.getQueryLocator(query);
    }
    
    
    global void execute(Database.BatchableContext BC , List<Event__c> scope) {
		system.debug ('---------EXECUTE----------');
        for(Event__c event : scope){  
            Map<String, Object> mJson = (Map<String, Object>) JSON.deserializeUntyped(event.Json__c);
            system.debug('**************MAP DESRIALIZE*******'+ mJson.get('Name'));

            Schema.SObjectType convertType = Schema.getGlobalDescribe().get(event.ObjectRecordToCreate__c);
            Sobject genericObject = convertType.newSObject();

            system.debug('********++++++++***************'+ genericObject);
        
            for(String fieldName : mJson.keyset()){
                genericObject.put(fieldName,mJson.get(fieldName));
            }
        system.debug('********++++++++***************'+ genericObject);
        genericList.add(genericObject);
        event.Processed__c = true; 
        eventList.add(event); 
        }
        
        system.debug ('---------database.execute----------');
          
        Database.SaveResult[] sr =Database.insert(genericList, false); 
         
        for(integer i=0;i<sr.Size();i++){
            if(sr[i].isSuccess()){
                system.debug ('---------inserted records----------'+ sr[i]);    
                eventList[i].Succeded_inserts__c = sr[i].getId();                
            }
            else{
                system.debug ('---------error records----------'+ sr[i]);
                eventList[i].UnSucceeded_results__c = sr[i].getId();       
            }
        } 
        system.debug ('------------before update------- eventList : ' + eventList);
		update eventList;
		system.debug ('------------after update------- eventList : ' + eventList);
       	

        //system.debug ('-------------------'+accList);
    }
    
    global void finish(Database.BatchableContext BC) {

                 
        system.debug ('---------finish----------');
        
                 
    } 

}