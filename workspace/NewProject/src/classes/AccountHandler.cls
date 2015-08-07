/*Description : Handler class for account trigger.
 * Revision History:
 *
 *  Version          Author              Date                Description
 *  1.0              Rahul Panditrao   07/28/2015           Initial Draft
 *   

*/
public with sharing class AccountHandler {
    
    public static boolean toInsert=true;
    public AccountHandler(){
       
    }
    
    public static void cloneTheRecordOfAccount(List<Account> ListOfAccounts){
        
        //system.debug('into handler object');
        List<Account> ListOfNewAccounts=new List<Account>();
        //account newAccount=new account();
        for(Account acc : ListOfAccounts){
            ListOfNewAccounts.add(acc.clone());         
        }
        
        if(toInsert == true){
            toInsert=false;
            insert ListOfNewAccounts;
            system.debug('----------');
            system.debug('----------');
        }   
    }
}