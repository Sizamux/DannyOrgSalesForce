public with sharing class AccountClassificacaoBatch implements Database.Batchable<sObject>, Database.Stateful{
   
    private LogClassificaoCliente__c logsCriado;

    public Database.QueryLocator start(Database.BatchableContext bc) {
        logsCriado = LogClassificacaoClienteBO.gerarLogParaBatch();
        system.debug('start '+logsCriado);
        // collect the batches of records or objects to be passed to execute
        return Database.getQueryLocator( [  SELECT Id, Classificao__c, AnnualRevenue
                                            FROM Account ]);
    }
    
    public void execute(Database.BatchableContext bc, List<Account> accountList){
        // process each batch of records
        if(!accountList.isEmpty()){
            AccountBO.verificarClassificacao(accountList); 
        }
    }
   
    public void finish(Database.BatchableContext bc){
        system.debug('finish '+logsCriado);
        LogClassificacaoClienteBO.alterarLogFinalizado(logsCriado);
        //LogClassificacaoClienteBO.alterarLogFinalizado();
    }
}