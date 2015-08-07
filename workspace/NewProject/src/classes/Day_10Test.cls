@isTest
private class Day_10Test {

    static testMethod void printContactsTest() {
    	List<Contact> testContacts =[SELECT Id, 
		  								    Name 
		  						     FROM Contact Limit 50];
		 Test.startTest();
		 
		 Day_10_assignment dayObj = new Day_10_assignment();
		 system.assertequals(testContacts,dayObj.question1()); 
		 Test.stopTest();    
    }
    
    static testMethod void mapActiveUsersTest() {
    	Map<Id, User> testMapUsers= new Map<Id, User>([SELECT Id, 
															  Name 
												 	   FROM User 
												       WHERE IsActive = TRUE ]);
		 Test.startTest();
		 
		 Day_10_assignment dayObj = new Day_10_assignment();
		 system.assertequals(testMapUsers,dayObj.question2()); 
		 Test.stopTest();
		 
		      
    }
    
    static testMethod void mapAccountAndIdTest() {
    	Map<Id, Account> accountMap= new Map<Id, Account>([SELECT Id, 
																  Name 
												  		   FROM Account]);
		Test.startTest();
		 
		Day_10_assignment dayObj = new Day_10_assignment();
		system.assertequals(accountMap,dayObj.question3()); 
		Test.stopTest();      
    }
    
    static testMethod void accountPicklistYearTest() {
    	List<Account> 	accountList1 = [SELECT Id,
								  			   Name 	
								 		FROM Account 
								 		WHERE Enrollment_Year__c includes ('2010') ];
		system.debug('7777777'+accountList1);
		Test.startTest();
		 
		Day_10_assignment dayObj = new Day_10_assignment();
		system.assertequals(accountList1,dayObj.question4()); 
		Test.stopTest();      
    }
    
    static testMethod void accountBillingStateTest() {
    	List<Account> accountList3 = [SELECT Name ,
								   Billing_State__c 
								   FROM Account  
								   WHERE Billing_State__c  not in ('Maharashtra','Kerala') 
								   ORDER by Billing_State__c DESC nulls last limit 1000];
		Test.startTest();
		 
		Day_10_assignment dayObj = new Day_10_assignment();
		system.assertequals(accountList3,dayObj.question5()); 
		Test.stopTest();      
    }
    
    
    static testMethod void opportunitySkipRecordsTest() {
    	List<Opportunity> opportunityList4= [SELECT Name,
										            id, 
										            amount  
											 FROM Opportunity  
											 WHERE amount > 10000 ORDER by  CreatedDate 
											 limit 100 offset 2 all rows];
		Test.startTest();
		 
		Day_10_assignment dayObj = new Day_10_assignment();
		system.assertequals(opportunityList4,dayObj.question6()); 
		Test.stopTest();      
    }
    
    static testMethod void aggregateResultsQ1Test() {
    	List<AggregateResult> arResult = [SELECT SUM(o.Amount)s,
												 CloseDate 
                                          FROM Opportunity o 
                                          WHERE CloseDate = THIS_FISCAL_YEAR group by CloseDate];
        Map<Integer,Double> testMap = new Map <Integer,Double>();
     
		for(AggregateResult a : arResult){
				system.debug('*********'+a);
				Date d=Date.valueOf(a.get('CloseDate'));
				Integer year=d.year();
				Double amount = Double.valueOf(a.get('s'));
				testMap.put(year,amount);
				}
		Test.startTest();
		 
		Day_10_assignment dayObj = new Day_10_assignment();
		system.assertequals(testMap,dayObj.AggregateQno1()); 
		Test.stopTest();      
    }
    
    static testMethod void aggregrateResultsQ2Test() {
    	AggregateResult[] tempAggr = [SELECT COUNT_DISTINCT(Name) , LeadSource
                                      		 FROM Lead
                                     		 Group By LeadSource
                                     		 Having COUNT_DISTINCT(Name) > 10]; 
		Test.startTest();
		 
		Day_10_assignment dayObj = new Day_10_assignment();
		system.assertequals(tempAggr,dayObj.AggregateQno2()); 
		Test.stopTest();      
    }
    
     static testMethod void aggregrateResultsQ3Test() {
    	Map<String,Map<String,Integer>> testMap = new Map<String,Map<String,Integer>>();
         
		List <AggregateResult> ar2 = [Select COUNT_DISTINCT(Id) CountLead, LeadSource, Status
                                      From Lead
                                      Group By LeadSource, Status];
        
		for (AggregateResult ar : ar2) {
				if(!testMap.containsKey(String.valueOf(ar.get('LeadSource')))){
					testMap.put(String.valueOf(ar.get('LeadSource')),new Map<String,Integer>{String.valueOf(ar.get('Status')) => Integer.valueOf(ar.get('CountLead'))});
				}
				else{
					testMap.get(String.valueOf(ar.get('LeadSource'))).put(String.valueOf(ar.get('Status')),Integer.valueOf(ar.get('CountLead')));
				}      
       	}
		Test.startTest();
		 
		Day_10_assignment dayObj = new Day_10_assignment();
		system.assertequals(testMap,dayObj.AggregateQno3()); 
		Test.stopTest();      
    }
    
    static testMethod void childParentQ1Test() {
    	List<contact> testList= [SELECT Name,
										 Account.Name 
								  FROM contact 
								  WHERE account.Industry='media' and account.Active__c='yes'];
		Test.startTest();
		 
		Day_10_assignment dayObj = new Day_10_assignment();
		system.assertequals(testList,dayObj.questionChild_ParentRelationship_1()); 
		Test.stopTest();      
    }
    
     static testMethod void childParentQ2Test() {
    	List<C_juncAB__c> testList= [SELECT Name__c,id,
										on_A__r.Name__c,
										on_B__r.SirName__c 
										FROM C_juncAB__c 
										WHERE Name__c like 'john'];
		Test.startTest();
		Day_10_assignment dayObj = new Day_10_assignment();
		system.assertequals(testList,dayObj.questionChild_ParentRelationship_2()); 
		Test.stopTest();      
    }
    
    static testMethod void parentChildQ1Test() {
    	List<account> testList= [SELECT Name,(SELECT contact.Name 
									FROM contacts 
									WHERE Name like 'john') 
									FROM account ];
		Test.startTest();
		Day_10_assignment dayObj = new Day_10_assignment();
		system.assertequals(testList,dayObj.questionParent_ChildRelationship_1()); 
		Test.stopTest();      
    }
    
    static testMethod void parentChildQ2Test() {
    	List<account> testList= [SELECT Name 
    							 FROM account 
								 WHERE id IN(SELECT AccountId 
									            FROM Opportunity 
									            WHERE StageName in('closed won'))]; 
		Test.startTest();
		Day_10_assignment dayObj = new Day_10_assignment();
		system.assertequals(testList,dayObj.questionParent_ChildRelationship_2()); 
		Test.stopTest();      
    } 
    
    static testMethod void parentChildQ3Test() {
    	List<A__c> testList= [SELECT Name__c  
    							 FROM A__c 
								 WHERE id IN(SELECT On_A__c 
								 			 FROM C_juncAB__c 
				 				 			 WHERE Name__c LIKE 'john')];
		Test.startTest();
		Day_10_assignment dayObj = new Day_10_assignment();
		system.assertEquals(testList,dayObj.questionParent_ChildRelationship_3()); 
		Test.stopTest();      
    }
      
    static testMethod void question_SoslTest() {
    	List<List<sObject>> testSobj = [FIND 'john' in all fields returning 
									Account(Id,Name),
									Contact(Id,Name),
									lead(Id,Name),
									User(Id,Name)];
		Test.startTest();
		Day_10_assignment dayObj = new Day_10_assignment();
		system.assertEquals(testSobj,dayObj.question_Sosl()); 
		Test.stopTest();        
    }
    
    static testMethod void question1_DMLTest() {
		Test.startTest();
		Day_10_assignment dayObj = new Day_10_assignment();
		system.assertEquals(1,dayObj.question1_DML()); 
		Test.stopTest();        
    }
    
    
    
    
    
    
    
}