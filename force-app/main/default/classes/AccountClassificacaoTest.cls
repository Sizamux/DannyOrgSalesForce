@isTest
public class AccountClassificacaoTest {
	@TestSetup	//popula Test
    private static void getData(){
        List<Account> accounts = new List<Account>();
        for (Integer i=0; i<10; i++){
            Account acc = new Account(Name = 'Test Account' + i,
                                     AnnualRevenue = 1000*(i*i*i*i) );
            accounts.add(acc);
        }
        Account testFalha = new Account(Name = 'Test Account falha 1',
                                     AnnualRevenue = -1000);
        accounts.add(testFalha);
        Account testFalha2 = new Account(Name = 'Test Account falha 2',
                                     AnnualRevenue = null);
        accounts.add(testFalha2);
        insert accounts;
        
    }
    
    @isTest
    private static void contasAdicionadas(){
        List<Account> accs = [SELECT id from Account];
        system.assert(accs.size()>0, 'Não possui Accounts');
    }
    
    @isTest
    private static void testaBatch(){
        
        AccountClassificacaoBatch accClassBatch = new AccountClassificacaoBatch();
		
        Test.startTest();
        
        Id batchId = Database.executeBatch(accClassBatch); 
        
        Test.StopTest();
        
        List<LogClassificaoCliente__c> logsDepois = [SELECT Id,Finalizado__c FROM LogClassificaoCliente__c WHERE Finalizado__c = true];

        system.assertEquals(1,logsDepois.size(), 'Depois Não Foi Criado um Log');
    }
    @isTest
    private static void batchViaSched(){
        String CRON = '0 0 12 * * ?';
        Test.startTest();
		String jobId = System.schedule('Agenda classificação Teste', 
											CRON, new AccountClassificacaoSched());
        Test.stopTest();
        
        List<AsyncApexJob> AssyncJobs = [SELECT Id FROM AsyncApexJob];
        
        system.debug('Assync Jobs on Test'+AssyncJobs);
        system.assertEquals(true,AssyncJobs.size()>0, 'Não Foi Agendado');
    }
    
}