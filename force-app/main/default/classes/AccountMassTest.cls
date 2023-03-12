@isTest
public class AccountMassTest {
	@TestSetup	//popula Test
    private static void getData(){
        List<Account> accounts = new List<Account>();
        List<Task> tasks = new List<Task>();
        for (Integer i=0; i<500; i++){
            Account acc = new Account(Name = 'Test Account' + i);
            accounts.add(acc);
        }
        insert accounts;
        
        for(Account itemAcc : accounts){
            Task newTask = new Task(WhatId = itemAcc.Id,
                                   	Status = 'Not Started',
                                    Subject = 'Teste '+itemAcc.Name,
                                    Priority = 'Normal'
                                    );
            tasks.add(newTask);
        }
        system.debug(tasks);
        insert tasks;
        //insere erro na DB
        //Task newTaskErro1 = new Task(Status = 'Not Started',
        //                            Subject = 'Teste erro',
        //                            Priority = 'Normal'
        //                            );
        //insert newTaskErro1;
    }
    
    @isTest
    private static void criaTaskParaAccount(){
        //get dados
        Integer taskFotTestcount = [SELECT count() FROM Task WHERE WhatId = null];
        system.debug(taskFotTestcount);
        //Faz Teste
        //try{
            system.assertEquals(0, taskFotTestcount, 'Erro, Existem Tasks que possuem WhatId nulo');
        //}catch(Exception e){
        //    system.debug('Erro, Existem Tasks que possuem WhatId nulo' + e);
        //}

    }
}