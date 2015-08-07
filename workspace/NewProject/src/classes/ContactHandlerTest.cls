/*Description :Test class for Contact trigger handler.
 * Revision History:
 *
 *  Version          Author              Date                Description
 *  1.0              Rahul Panditrao    07/28/2015           Initial Draft
 *   

*/
@isTest
private class ContactHandlerTest {
	public static testMethod void checkAssociation(){
		Account ac=new Account();
		ac.Name='dummyAccount'; 
		ac.Domain_Name__c = 'yahuno.com';
		insert ac;
		system.debug('================='+ac.id);
		List<Contact> conList=new List<Contact>();
		for(Integer i=0;i<1;i++){ 
			Contact con=new Contact();
			con.Email='dummy1'+i+'@yahoo.com';
			con.LastName='dummyContact'+i;
		 	conList.add(con);
		}
		
	   Test.StartTest();
	   insert conList;
	   //system.debug('conList===='+conList);
	   Test.StopTest();
	   List<Contact> con1=[SELECT AccountId 
	   					   FROM Contact 
	   					   WHERE Id IN :conList];
	   for(Contact c : con1)
		{
		   //system.debug('c===='+c);
		   system.debug('================='+c.AccountId);
		   system.assert(c.AccountId != ac.id);
		}
	}
 
	 
	 public static testMethod void checkAssociationNoEmail(){
	   Account ac=new Account();
	   ac.Name='dummyAccount';
	   ac.Domain_Name__c = 'yahoo.com';
	   insert ac;
	   List<Contact> conList=new List<Contact>();
		for(Integer i=0;i<5;i++)
		{ 
			Contact con=new Contact();
		 	//con.Email='';
		 	con.LastName='dummyContact'+i;
		 	con.Accountid='00128000003vQ7X';
		 	conList.add(con);
		}
		
		Test.StartTest();
		//System.debug('con1:'+con);
		insert conList;
		Test.StopTest();
		List<Contact> con1=[SELECT AccountId 
							FROM Contact 
							WHERE Id IN :conList];
		for(Contact c : con1)
		{
		   system.assertNotEquals(ac.id,c.AccountId);
		}
	  }
	 
	
	 public static testMethod void checkAssociationNoDomain(){
		Account ac=new Account();
		ac.Name='dummyAccount';
		insert ac;	
		List<Contact> conList=new List<Contact>();
		for(Integer i=0;i<5;i++){ 
			Contact con=new Contact();
			//con.Email='';
			con.LastName='dummyContact'+i;
			con.Accountid='00128000003vQ7X';
			conList.add(con);
		}
	   Test.StartTest();
	   //System.debug('con1:'+con);
	   insert conList;
	   Test.StopTest();
	   List<Contact> con1=[SELECT AccountId 
	   					   FROM Contact 
	   					   WHERE Id IN :conList];
	   for(Contact c : con1){
			system.assertNotEquals(ac.id,c.AccountId);
		}
	  }
	  
	 public static testMethod void checkAssociationWrongEmail(){
	   Account ac=new Account();
	   ac.Name='dummyAccount';
	   ac.Domain_Name__c = 'yahoo.com';
	   insert ac; 
	   List<Contact> conList=new List<Contact>();
	   for(Integer i=0;i<5;i++) { 
			Contact con=new Contact();
			con.Email='dummy@google.com';
			con.LastName='dummyContact'+i;
			conList.add(con);
		}
	   Test.StartTest();
	   //System.debug('con1:'+con);
	   insert conList;
	   Test.StopTest();
	   List<Contact> con1=[SELECT AccountId 
	   					   FROM Contact 
	   					   WHERE Id IN :conList];
	   for(Contact c : con1)
		{
		   system.assertNotEquals(ac.id,c.AccountId);
		}
	} 
	//---------------------------------------------------------
	static testMethod void duplicateEmailAndPhone() {
		Contact c = new Contact();
		c.LastName='xyz';
		c.Email ='abc1@def.com'; 
		c.Phone = '12314564383';
		insert c;
		Contact c1 = new Contact();
		c1.LastName='qwqw';
		c1.Email ='abc1@def.com';
		c1.Phone = '12314564383';
		Test.StartTest();
        try{  
            insert c1;
        }
        catch(exception ex)
        {
            System.assert(ex<>NULL, 'True');
        }
        Test.StopTest();   
    }
    
     static testMethod void duplicateEmail() {
		Contact c = new Contact();
		c.LastName='wwwe';
		c.Email ='abc1@def.com';
		c.Phone = '12314564383';
		insert c;
		Contact c1 = new Contact();
		c1.LastName='www';
		c1.Email ='abc1@def.com';
		c1.Phone = '12676953';
        Test.StartTest();
        try{  
            insert c1;
        }
        catch(exception ex)
        {
            System.assert(ex<>NULL, 'True');
        }
        Test.StopTest();       
    }
    
    static testMethod void duplicatePhone() {
		Contact c = new Contact();
		c.LastName='qqq';
		c.Email ='abc1@def.com';
		c.Phone = '12314564383';
		insert c;
		Contact c1 = new Contact();
		c1.LastName='qqq';
		c1.Email ='abcxyz@def.com';
		c1.Phone = '12314564383';
        Test.StartTest();
        try{  
            insert c1;
        }
        catch(exception ex)
        {
            System.assert(ex<>NULL, 'True');
        }
        Test.StopTest();       
    }
    
    static testMethod void differentEmailAndPhone() {
		Contact c = new Contact();
		c.LastName='qqq';
		c.Email ='abc1@def.com';
		c.Phone = '12314564383';
		insert c;
		Contact c1 = new Contact();
		c1.LastName='qqq';
		c1.Email ='abcxyz@def.com';
		c1.Phone = '12314564383';
        Test.StartTest();
        try{  
			insert c1;
        }
        catch(exception ex)
        {
			System.assert(ex<>NULL, 'True');
        }
        Test.StopTest();       
    }
}