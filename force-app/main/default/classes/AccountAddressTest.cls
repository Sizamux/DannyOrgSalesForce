@isTest
public class AccountAddressTest {
    //2
	@TestSetup	//popula Test
    private static void getData(){
        List<Account> accounts = new List<Account>();
        for (Integer i=0; i<2; i++){
            Account acc = new Account(Name = 'Test Account' + i,
                                     Match_Billing_Address__c= true,
                                     BillingPostalCode = '04802-120');
            accounts.add(acc);
        }
        insert accounts;
    }
    //1
    @isTest
    private static void contasAdicionadas(){
        List<Account> accs = [SELECT id from Account];
        system.assert(accs.size()>0, 'Não possui Accounts');
    }
    //3
    @isTest
    private static void possuiMatchingAdressAssinalado(){
        List<Account> accs = [SELECT Id, Match_Billing_Address__c from Account];
        for(Account accItem : accs){
            system.assert(accItem.Match_Billing_Address__c == true, 'Não esta com match billing adress marcado');
        }
    }
    //4
    @isTest
    private static void BillingEShippingAdressSaoIguais(){
        List<Account> accs = [SELECT Id, BillingPostalCode, ShippingPostalCode from Account];
        for(Account accItem : accs){
            system.assert(accItem.BillingPostalCode != null, 'billing é nulo');
            system.assert(accItem.BillingPostalCode == accItem.ShippingPostalCode, 'Não são iguais');
        }
    }
    //4
    @isTest
    private static void testUpdate(){
        List<Account> accs = [SELECT Id, BillingPostalCode, ShippingPostalCode from Account]; 
        for(Account accItem : accs){
            accItem.BillingPostalCode = 'teste';
        }
        update accs;
    }
}