@isTest
private class countryCityPageControllerTest {

    static testMethod void populateCountryTest() {
        
        countryCityPageController controllerInstance = new countryCityPageController();
        
        List<SelectOption> testAvailableCountryValues;
        
        controllerInstance.populateCountry();
        for(Country__c country : Country__c.getAll().values()){
            testAvailableCountryValues.add(new SelectOption(country.Name,country.Name));  
        }   
        system.assert(controllerInstance.availableCountryValues == testAvailableCountryValues);
    }  
}