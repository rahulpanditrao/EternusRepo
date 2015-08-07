public virtual class  Example_class 

{
 
    string Variable_to_be_initialised_by_constructor;   
    
    public  Example_class(){
        this.Variable_to_be_initialised_by_constructor='I GOT INITIALISED...';
        System.debug('From constructor: '+ this.Variable_to_be_initialised_by_constructor);
    }            
     
    
    public virtual double calci(string Operation,integer Operand_1,integer Operand_2){
        double Result=0;
        if(Operation.equalsIgnoreCase('sum')){
            Result=(Operand_1+Operand_2);
        }
        else{
            	if(Operation.equalsIgnoreCase('mul'))
           			 Result=(Operand_1*Operand_2);
                else
                
                    if(Operation.equalsIgnoreCase('div'))
            Result=(Operand_1/Operand_2);
           	   else
                
                    if(Operation.equalsIgnoreCase('sub'))
            		if(Operand_2>Operand_1) 
                      Result=(Operand_2-Operand_1);
                      Result=(Operand_1-Operand_2);
        }
                
        return Result;
        
    }

  }