@istest 
public with sharing class Day_9_assignmentTestClass {
	
	static testMethod void EvenTest() {
		
		Integer testInput = 4;
		Day_9_assignment d1 = new Day_9_assignment();
		d1.basicProgrammingEvenOdd_Q_1(testInput);
	}	
	
	static testMethod void OddTest() {
		
		Integer testInput = 3; 
		Day_9_assignment d1 = new Day_9_assignment();
		d1.basicProgrammingEvenOdd_Q_1(testInput);
	}	
	
	
	static testMethod void arrayTillParameter() {
		
		Integer testInput = 3;
		Day_9_assignment d1 = new Day_9_assignment();
		list<integer> expected = new list<integer>{1,2,3};
	 
		system.assert(expected == d1.createAndPrintAnArrayOfGivenParameterSize(testInput));
	}	
	
	static testMethod void sortNumberDec() {
		Day_9_assignment d1 = new Day_9_assignment();
		list<integer> testInput = new list<integer>{1,3,2};
	 	list<integer> expected = new list<integer>{3,2,1};
		system.assert(expected == d1.sortNumberDec(testInput));
	}	
	
	static testMethod void sortNumberAsc() {
		Day_9_assignment d1 = new Day_9_assignment();
		list<integer> testInput = new list<integer>{1,3,2}; 
	 	list<integer> expected = new list<integer>{1,2,3};
		system.assert(expected == d1.sortNumberAsc(testInput)); 
	}	    
	
	static testMethod void minimumNumber() {
		Day_9_assignment d1 = new Day_9_assignment();
		list<integer> testInput = new list<integer>{1,3,2}; 
		system.assert(1 == d1.MinNumber(testInput)); 
	}	
	
	 	static testMethod void MaximumNumber() {
		Day_9_assignment d1 = new Day_9_assignment();
		list<integer> testInput = new list<integer>{1,3,2}; 
		system.assert(3 == d1.MaxNumber(testInput)); 
	}	
	
	 	static testMethod void dupOccuranceInArray() {
		Day_9_assignment d1 = new Day_9_assignment();
		list<integer> testInput = new list<integer>{1,3,4,3,1,8,2}; 
		d1.MaxNumber(testInput);
	}	
	
	static testMethod void simpleInterest() {
		Day_9_assignment d1 = new Day_9_assignment();
		Integer principle=2;
		Integer rateOfInterest=8; 
		Integer duration=1;
		system.assertEquals(1,d1.simpleInterest(principle,rateOfInterest,duration));   
	}	  
	
	static testMethod void summationOfNumbers() {
		Day_9_assignment d1 = new Day_9_assignment();
		Integer parameter=3;
		system.assertEquals(6,d1.summationOfNumbers(parameter));
	}	
	
	
}