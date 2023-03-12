@IsTest
public class AddPrimaryContactTest {
    @IsTest
    private static void testQueuableClass(){
       //Carregar dados para test
        List<Account> accounts = new List<Account>();
        for (Integer i=0; i<500; i++){
            account acc = new Account(Name = 'Test Account' + i);
            if(i<250){
                acc.BillingState = 'NY';
            } else {
                acc.BillingState = 'CA';
            }
            accounts.add(acc);
        }
        insert accounts;
        
        Contact ctc = new Contact(LastName ='Marini');
        insert ctc;

        //Fazer o teste
        Test.startTest();
        Id JobId = System.enqueueJob(new AddPrimaryContact(ctc, 'CA'));
        Test.stopTest();
        
        //Checar resultados
    	List<Contact> ctcs = [SELECT Id FROM Contact WHERE Contact.Account.BillingState = 'CA'];
        system.assertEquals(200, ctcs.size(), 'Erro');
   
    }
}