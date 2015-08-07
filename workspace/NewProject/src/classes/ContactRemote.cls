global with sharing class ContactRemote {
	
	@RemoteAction
	global static void deleteContact(String contactId){
		system.debug('-------'+contactId);
		
	}
}