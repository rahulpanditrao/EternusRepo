public with sharing class Student_RegistrationController {
	//public Apexpages.standardController stud;
	public Student__c studInstance{get;set;}
	public String selectedLang{get;set;}
	
	public Student_RegistrationController(Apexpages.standardController stud){
		//this.stud=stud;
		studInstance = new Student__C();	
		selectedLang='French';	
	}
	
	public void saveStud(){
		system.debug('********************************');
		
		
		
		if(studInstance.Name != NULL){
			insert(studInstance);
			ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.INFO,'Saved'));	
		}
		else{
			ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Enter Atleast The Name'));
		}
		
		
	}
	

}