public with sharing class ContactBatchJob implements Database.Batchable<sObject>,Database.stateful,Schedulable {
 
 map<String, wrappList> mapAccountOpportunity ; 
   
    public class wrappList {
        List<Opportunity> oppList;
        Decimal sum ; 
        
        
        wrappList(){
            oppList = new List<Opportunity>();
            sum = 0;     
        }
    } 
    public ContactBatchJob(){
         mapAccountOpportunity  = new Map<String, wrappList>();
    }
    public Database.QueryLocator start(Database.BatchableContext batchCon) {
        String query = 'SELECT Id, Name, amount, AccountId , Account.Primary_Contact__c FROM Opportunity WHERE StageName = \'Closed Won\' AND account.Primary_Contact__c != NULL';
        return Database.getQueryLocator(query);
    }
    
    public void execute(SchedulableContext SC){
        ContactBatchJob conveyClosedWonOpportunityToContact = new ContactBatchJob();
        Database.executeBatch(conveyClosedWonOpportunityToContact, 2);
    }
    
    public void execute(Database.BatchableContext batchCon, List<Opportunity> scope) {
        system.debug('^^^^^^^^^^^^^^^^++++++++^^^^^^^^^^'+scope );
        
        for(Opportunity oppInstance : scope){
            
            if(mapAccountOpportunity.containsKey(oppInstance.Account.Primary_Contact__c)){
                wrappList wrapInstance = mapAccountOpportunity.get(oppInstance.Account.Primary_Contact__c);
                wrapInstance.oppList.add(oppInstance);
                wrapInstance.sum += oppInstance.Amount;
                mapAccountOpportunity.put(oppInstance.Account.Primary_Contact__c, wrapInstance);
            }
            else{
                wrappList wrapInstance = new wrappList();
                wrapInstance.oppList.add(oppInstance);
                wrapInstance.sum += oppInstance.Amount;
                
                mapAccountOpportunity.put(oppInstance.Account.Primary_Contact__c, wrapInstance);
             }
        }
     system.debug('^^^^^^^^^^^^^^^^++++()()(643536378653()()+++^^^^^^^^^^'+mapAccountOpportunity);
    }
    
    public void finish(Database.BatchableContext batchCon) {
        system.debug('^^^^^^^^^^^^^^^^++++()()()()()+++^^^^^^^^^^'+mapAccountOpportunity);
        
        
        
        List<Messaging.SingleEmailMessage> mails = new List<Messaging.SingleEmailMessage>();
        Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage(); 
        List<String> to = new List<String>();
        to.add('rahul.panditrao@eternussolutions.com');
        mail.setToAddresses(to);
        mail.setSenderDisplayName('Salesforce');
        mail.setSubject('URGENT!!!!!!!!!!');
        String body = 'Hi,' ;
        body += 'mapAccountOpportunity........'+mapAccountOpportunity;
        
        mail.setHtmlBody(body);
        mails.add(mail);
        Messaging.sendEmail(mails);
    }
}