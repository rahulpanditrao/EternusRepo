public class tp   {
    public void method1(){
        list<Account> acc1=new LIST<Account>([select Name,Id from Account limit 10]);
        
    	  // for(Integer i=0;i<=acc1.size();i++)
           //{
          //     System.debug(acc1[i]);
          // }
          // for(Account x : [select Name,Id from Account limit 10]){
          //  system.debug(x);
          // }
         // Integer i =0;
        	//while(i < acc1.size())
           // {
             //   System.debug(acc1[i]);
            //    i++;
            }
        public void question_2 ()
        {
            set<id> ID_set=new set<id>();
            //////list<lead> Lead_List=new list<lead>([select Id from lead]);
            for(lead l1 :[select Id from lead] ){
               ID_set.add(l1.Id) ; 
            }
            System.debug(ID_set);
        }
    public void Ques_4(){
        list <Lead> lead_1 = new list<Lead>([select Name, Id from lead where status = 'Closed - Not Converted']);
        for(lead x : lead_1 )
        {
           x.Status= 'Closed - Converted'; 
        }
        
       update lead_1;
        
    	}
    
    }