public class Day9_Advanced {
	
	public void Question1(){
		list<Account> acc1=new LIST<Account>([SELECT Name,
													Id 
											  FROM Account limit 10]);
        
		for(Integer i=0;i<=acc1.size();i++)
		{
           System.debug(acc1[i]);
		}
		
		for(Account x : [SELECT Name,
       							 Id 
       				      FROM Account 
       				      limit 10]){
			system.debug(x);
       }
		INteger i =0;
		while(i < acc1.size())
		{
			System.debug(acc1[i]);
			i++;
		}
	}
	public void question_2 (){
		set<id> ID_set=new set<id>();
		//////list<lead> Lead_List=new list<lead>([SELECT Id FROM lead]);
			for(lead l1 :[SELECT Id 
						  FROM lead] ){
				ID_set.add(l1.Id) ; 
			}
		System.debug(ID_set);
	}
	
	public void Ques_3(){
        list<contact> Contact_list_associated_to_eternus=new list<contact>([SELECT name 
        																	FROM contact 
        																	WHERE Account.name LIKE 'eternus%']);
        Integer count=0;
        	for(contact c : Contact_list_associated_to_eternus ){
            	count++;   
       		}
		list<account> Account_list=new list<account>([SELECT contact_count__c 
													  FROM account 
													  WHERE Account.name = 'eternus']);  
        	for(account a :Account_list ){
	            a.contact_count__c = count;
	            a.Email__c='a@b.c';
        	}
		update Account_list;   
	}
        
	public void Ques_4(){
		list <Lead> lead_1 = new list<Lead>([SELECT Name, 
													Id 
											 FROM lead 
											 WHERE status = 'Closed - Not Converted']);
			for(lead x : lead_1 )
			{
				x.Status= 'Closed - Converted'; 
			}
		update lead_1;
	}
    
	public void Ques_6(){
		list<account>Accounts_having_created_date_as_today = new list <account>([SELECT Name 
																				 FROM account 
																				 WHERE createddate =: System.now()]);
		System.debug(Accounts_having_created_date_as_today);
	}
     
}