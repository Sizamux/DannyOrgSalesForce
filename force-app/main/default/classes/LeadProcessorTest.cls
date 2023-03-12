@IsTest
private class LeadProcessorTest {
	
    @IsTest
    private static void LeadProcessorTest(){
        
     //Carregar dados para test
        List<Account> accounts = new List<Account>();
        for (Integer i=0; i<300; i++){
            accounts.add(new Account(Name = 'Test Account' + i));
        }
        insert accounts;
        
        List<Contact> contacts = new List<Contact>();
        List<Id> accountIds = new List<Id>();
        for(Account acc : accounts){
            contacts.add(new Contact(FirstName=acc.Name, LastName='TestContact', AccountId=acc.id));
            accountIds.add(acc.Id);
        }
        insert contacts;

        //Fazer o teste
        Test.startTest();
        accountProcessor.countContacts(accountIds);
        Test.stopTest();
        
        //Checar resultados
    	List<Account> accs = [SELECT Id, Number_Of_Contacts__c FROM Account];
        for(Account acc : accs){
            system.assertEquals(1, acc.Number_Of_Contacts__c, 'Erro');
        }
    }
}