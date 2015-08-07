/*Description : A class which will contain the methods corresponding to the questions in Day_10 Assignment
 * Revision History:
 *
 *  Version          Author              Date                Description
 *  1.0              Rahul Panditrao   07/15/2015           Initial Draft
 *   

*/
	public class Day_10_assignment {
		List<Contact> conList =[SELECT Id, 
		  								Name 
		  						FROM Contact Limit 50];
    public List<Contact> question1(){
        System.debug(conList);
        return conlist;
    } 
    
    public Map<Id, User> question2(){
		List<User> userList =[ SELECT Id, 
									  Name 
							   FROM User 
							   WHERE IsActive = TRUE ];
							   
		System.debug(userList);
		Map<Id, User> userMap= new Map<Id, User>([SELECT Id, 
													     Name 
												  FROM User 
												  WHERE IsActive = TRUE ]);
	    return userMap;
    }
    
    
    public Map<Id, Account> question3(){
		Map<Id, Account> accountMap= new Map<Id, Account>([SELECT Id, 
																  Name 
												  		   FROM Account]);
		//system.debug(accountMap);
		
		Map<Account, Id> accountMap2= new Map<Account, Id>();
		for(Account a : [SELECT Id, 
								Name 
						  FROM Account]){
			accountMap2.put(a,a.Id);				  				  	
		 }
		 
		 system.debug(accountMap2);
												  		   
        return accountMap;
     }
			
    
    
	public List<Account> question4(){
		List<Account> 	accountList1 = [SELECT Id,
								  			   Name 	
								 		FROM Account 
								 		WHERE Enrollment_Year__c includes ('2010') ];
		System.debug(accountList1);
		List<Account> accountList2 = [SELECT Id, 
								   			 Name 
								   	  FROM Account 
								      WHERE Enrollment_Year__c includes ('2013;2014') ];
		System.debug(accountList2);
		return accountList1;
	}
	
    public List<Account> question5(){
		List<Account> accountList3 = [SELECT Name ,
								   			 Billing_State__c 
								   	  FROM Account  
								  	  WHERE Billing_State__c  not in ('Maharashtra','Kerala') 
								  	  ORDER by Billing_State__c DESC nulls last limit 1000];
		System.debug(accountList3);
		return accountList3;
	}
	
    public List<Opportunity> question6(){
		List<Opportunity> opportunityList4= [SELECT Name,
										            id, 
										            amount  
											 FROM Opportunity  
											 WHERE amount > 10000 ORDER by  CreatedDate 
											 limit 100 offset 2 all rows];
		System.debug(opportunityList4);  
		return opportunityList4;
	}
	
    public Map<Integer,Double> AggregateQno1(){
		List<AggregateResult> arResult = [SELECT SUM(o.Amount)s,
												 CloseDate 
                                          FROM Opportunity o 
                                          WHERE CloseDate = THIS_FISCAL_YEAR group by CloseDate];
        Map<Integer,Double> mapYear2Sum = new Map <Integer,Double>();
     
		for(AggregateResult a : arResult){
				system.debug('*********'+a);
				Date d=Date.valueOf(a.get('CloseDate'));
				Integer year=d.year();
				Double amount = Double.valueOf(a.get('s'));
				mapYear2Sum.put(year,amount);
				}
        
		system.debug(mapYear2Sum); 
		return mapYear2Sum;
 	}
 	
	public AggregateResult[] AggregateQno2(){
		AggregateResult[] leadresults = [SELECT COUNT_DISTINCT(Name) , LeadSource
                                      		 FROM Lead
                                     		 Group By LeadSource
                                     		 Having COUNT_DISTINCT(Name) > 10]; 
		for(AggregateResult ar1 : leadresults){
				System.debug(ar1);
			}
			
		return leadresults;
	}
	
	public Map<String,Map<String,Integer>> AggregateQno3(){
		Map<String,Map<String,Integer>> mLeadMap = new Map<String,Map<String,Integer>>();
         
		List <AggregateResult> ar2 = [Select COUNT_DISTINCT(Id) CountLead, LeadSource, Status
                                      From Lead
                                      Group By LeadSource, Status];
        
		for (AggregateResult ar : ar2) {
				if(!mLeadMap.containsKey(String.valueOf(ar.get('LeadSource')))){
					mLeadMap.put(String.valueOf(ar.get('LeadSource')),new Map<String,Integer>{String.valueOf(ar.get('Status')) => Integer.valueOf(ar.get('CountLead'))});
				}
				else{
					mLeadMap.get(String.valueOf(ar.get('LeadSource'))).put(String.valueOf(ar.get('Status')),Integer.valueOf(ar.get('CountLead')));
				}      
       	}
        System.debug(' mLeadMap' + mLeadMap);
        return mLeadMap;           
	}
     
   
    
	public List<contact> questionChild_ParentRelationship_1(){
		List<contact> lscontact= [SELECT Name,
										 Account.Name 
								  FROM contact 
								  WHERE account.Industry='media' and account.Active__c='yes']; 
		System.debug(lscontact);
		return lscontact;
	}
    
    public List<C_juncAB__c> questionChild_ParentRelationship_2(){
		List<C_juncAB__c> lst_c= [SELECT Name__c,id,
										on_A__r.Name__c,
										on_B__r.SirName__c 
										FROM C_juncAB__c 
										WHERE Name__c like 'john'];
		System.debug(lst_c);
		return lst_c;
    }
    
	public List<account> questionParent_ChildRelationship_1(){
    
		//List<account> lsaccount= [SELECT Name,id FROM account WHERE id in( SELECT AccountId FROM Contact WHERE FirstName like 'john'  )]; 
		List<account> lsaccount= [SELECT Name,(SELECT contact.Name 
									FROM contacts 
									WHERE Name like 'john') 
									FROM account ];
		for(account a :lsaccount )  {
				System.debug(a); 
			}
		return lsaccount;
	}
    
    public List<account> questionParent_ChildRelationship_2(){
        
        
		List<account> lstAccount= [SELECT Name FROM account 
									WHERE id in(SELECT AccountId 
									FROM Opportunity 
									WHERE StageName in('closed won'))]; 
		System.debug(lstAccount);  
		return lstAccount;
 	}
    
   public List<A__c> questionParent_ChildRelationship_3(){

		List<A__c> lst_c =[SELECT Name__c 
						   FROM A__c 
						   WHERE id in(SELECT On_A__c 
						               FROM C_juncAB__c 
						               WHERE Name__c LIKE 'john')];
		System.debug(lst_c);
		return lst_c; 
        
	}
	public List<List<sObject>> question_Sosl(){
		List<List<sObject>> sobj = [FIND 'john' in all fields returning 
									Account(Id,Name),
									Contact(Id,Name),
									lead(Id,Name),
									User(Id,Name)];
		system.debug(sobj);
		return sobj;
	}
    
    public Integer question1_DML(){
		List <lead> l1=new List <lead>();
		for(integer i=0; i<100;i++){
				lead ld=new lead(Company = 'eternus',status ='Status changed',Unique_Name__c ='abc'+i, LastName='test'+i);
				l1.add(ld); 
		}
		try{
			insert l1;
		}
		catch(Exception e){
			Log__c log1=new Log__c(error__c=e.getMessage());
			insert log1; 
        } 
        return 1; 
    }
    
	public void question2_DML(){
		List <account> AccntList_Inactive=new List <account> ();
		Datetime d1=Datetime.now() ;
		//system.debug(d1);
		d1=d1-90;
		// system.debug(d1);
		for(account a : [SELECT Name,Active__c 
								FROM account 
								WHERE CreatedDate >=: d1]){
			if(a.Active__c=='no'){   
				AccntList_Inactive.add(a);
			}
		}
		system.debug(AccntList_Inactive);
        delete AccntList_Inactive;
	}
	
	public void question3_DML(){
  		List<asset> ListOfAssets= new List<asset>();
		for(integer i=0;i< 5;i++){
			Asset a=new Asset(Name='Rock'+i,Line_Item_Id__c= 'bottle'+ i ,accountid='00128000004VJY7'); 
			ListOfAssets.add(a);
		}
		Asset a=new Asset(Name='Rock',Line_Item_Id__c= 'bottle0' ,accountid='00128000004VJY7'); 
		ListOfAssets.add(a);
		try{
			upsert ListOfAssets Line_Item_Id__c ;
		}
		catch(exception e){
			System.debug(e.getMessage());
		}
    }
}