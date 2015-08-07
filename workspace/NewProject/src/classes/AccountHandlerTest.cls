/*Description :Test class for account trigger handler.
 * Revision History:
 *
 *  Version          Author              Date                Description
 *  1.0              Rahul Panditrao    07/28/2015           Initial Draft
 *   

*/
@isTest
private class AccountHandlerTest {

    static testMethod void checkingClone() {
    
        List<Account> accList=new List<Account>();
        integer i=0;
        while(i < 15){
            Account objacc = new Account();
            objacc.Name = 'zest'+ i;
            objacc.Email__c = 'a@b.c';
            accList.add(objacc);
            i++;
        }   
        Test.startTest();
            insert accList; 
            System.debug('*******************************************'+ accList);
        Test.stopTest();
        List<Account> accListNew=new List<Account>();
       
        for(Account acc : [SELECT ID FROM Account]){
            System.debug('*******************************************');
            accListNew.add(acc);
        }
        system.assert(accListNew.size()== 2* accList.size() );
    }  
    
}