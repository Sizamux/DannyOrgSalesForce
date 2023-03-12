@isTest
public class AccountBOTest {
	@TestSetup	//popula Test
    private static void getData(){
        List<Account> accounts = new List<Account>();
        for (Integer i=0; i<20; i++){
            Account acc = new Account(Name = 'Test Account' + i);
            accounts.add(acc);
        }
        insert accounts;
    }
    
    @isTest
    private static void criaTaskParaAccount(){
        //List<Account> accounts = new List<Account>();
        //Set<Id> accId = new Set<Id>();
        
        //Popula Test

        //for (Integer i=0; i<20; i++){
        //    Account acc = new Account(Name = 'Test Account' + i);
        //    accounts.add(acc);
        //}
        
        //Realiza o Test
		//Test.startTest();
        //insert accounts;
        //Test.stopTest();
        
        /*//Get Id de acc Adicionadas
        for(Account acc : accounts){
			accId.add(acc.Id);
        }*/
        
        //system.debug(accounts.size());

        //Get dados
        list<Account> accsTest = [SELECT id, (SELECT id, whatId FROM Tasks) FROM Account ];//WHERE Id IN :accId];
        
        //Resultado do Test
        system.debug('size Acc = '+accsTest.size()); 
        for(Account accTItem : accsTest){
            system.debug('AccId [' + accTItem.Id + '] size Tasks em accItem = ' + accTItem.Tasks.size());
            Integer TaskCount = accTItem.Tasks.size();
            System.assertEquals(true,TaskCount>0, 'Erro, Não foi inserido tasks para está account');
            System.assertEquals(true,accTItem.Tasks[0].whatId != null, 'Erro, whatId Nulo');
        }
        System.assertEquals(true,accsTest.size()>0, 'Erro, Não foram adicionados contas ou accIds são invalidos');
    }
}