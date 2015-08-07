public class Day_9_assignment {
   
	public List<Integer> L1 = new List<Integer> {7,9,4,1,6,2,5,3};
   
    public void basicProgrammingEvenOdd_Q_1 (Integer parameter){
         	 
	    if(Math.mod(Parameter,2) == 0)
	    {
	    	System.debug('The entered number'+'  '+Parameter +'  '+'is an even number');
	    }
	    else{
	    	System.debug('The entered number'+'  '+Parameter+' '+'is an odd number....');
	    }
             
    }
    
    public List<Integer> createAndPrintAnArrayOfGivenParameterSize(integer Parameter){
		Integer[] Array1 = new List<Integer>();
		
		for(integer i=0;i<Parameter;i++){
         	Array1.add(i+1);
         }
		
		System.debug(Array1);  
		 return Array1;           
	} 
    
    public List<Integer> sortNumberDec(List<Integer> L1){
       // L1.sort();
       //System.debug(L1); 
      Integer i, j;
       for(i=0;i<L1.size();i++){
       for(j=1;j<L1.size();j++){
       if(L1[j-1] < L1[j]){
       Integer temp= L1[j-1];
        L1[j-1]=L1[j];
        L1[j]=temp;
         }
         }
        }
       System.debug(L1);
       List<Integer> Result= New List<Integer>();
       Result=L1;
       return Result;
    }
    
    public List<Integer> sortNumberAsc(List<Integer> L1){
       // L1.sort();
       //System.debug(L1); 
      Integer i, j;
        for(i=0;i<L1.size();i++){
        for(j=1;j<L1.size();j++){
        if(L1[j-1] > L1[j]){
        Integer temp= L1[j-1];
        L1[j-1]=L1[j];
        L1[j]=temp;
       }
        }
        }
       System.debug(L1);
       List<Integer> Result= New List<Integer>();
       Result=L1;
       return Result;
    }
    
    
    
     public Integer MinNumber(List<Integer> integerList){
      Integer min=99, i;
        for(i=0;i<integerList.size();i++){
            if(min>integerList[i]) 
                min=integerList[i];
            
        }
       System.debug('Minimum number in the list is:' +min);
       return min;
    }
    
    
    
    
    public Integer MaxNumber(List<Integer> integerList){
      Integer max=0, i;
        for(i=0;i< integerList.size();i++){
        if(max<integerList[i])
        max=integerList[i];
            
        }
       System.debug('Maximum number in the list is:' +max);
       return max;
    }
    
    
    public void dupOccuranceInArray(List<Integer> testArray){
        //List <Integer> testArray = new List <Integer> {2,2,3,4,4,5};
        //testArray={2,2,3,4,4,5};
        List <Integer> temp = testArray;
        Integer i, j, count = 0;
        for(i=0;i<testArray.size();i++){
			if(temp[i] == -1)
				continue;
			for(j = i; j<testArray.size();j++){
        		 if(j != -1){
         			if(temp[i] == temp[j]){
         				count++;
         				if(i != j)
         					temp[j]=-1;
       					  }
        			 }
        	 }
         System.debug('Array Element '+temp[i]+' occured '+count+' times.');
          count = 0;
         	}
       }
         
         
    public Integer summationOfNumbers(Integer Parameter){
        integer Sum =0;
        for(integer i=0;i <= Parameter;i++){
            Sum+=i;
        }
      System.debug('Sum is'+ ' ' + Sum);
      
      return Sum;
    }
    
    public Integer simpleInterest(decimal Principle,decimal Rate_of_interest,decimal duration){
        decimal Simple_Interest= Principle * Rate_of_interest *duration;
        System.debug('Simple interest is : '+ Simple_Interest);
        return 1;
    }

}