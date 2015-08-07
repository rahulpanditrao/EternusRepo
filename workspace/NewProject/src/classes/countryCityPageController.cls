public with sharing class countryCityPageController {
	public String selectedCountryValue{get;set;}
	public List<SelectOption> availableCountryValues{get;set;}
	public String selectedCityValue{get;set;}
	public List<SelectOption> availableCityValues{get;set;}
	
	
	public countryCityPageController(){
		populateCountry();
	}

	
	public void populateCountry(){
		//system.debug('+++++++++++++++++++'+Country__c.getAll().keyset());
		availableCountryValues = new List<SelectOption>();
		for(Country__c country : Country__c.getAll().values()){
			availableCountryValues.add(new SelectOption(country.Name,country.Name));  
		}		
	}
	
	public void populateCity(){
		//system.debug('++++++++************++++++'+City__c.getAll().keyset());
		availableCityValues = new List<SelectOption>();
		for(City__c city : [SELECT Name 
							FROM City__c 
							WHERE Country__c = :selectedCountryValue]){
			availableCityValues.add(new SelectOption(city.Name,city.Name));  
		}
			
	}
	
	
}