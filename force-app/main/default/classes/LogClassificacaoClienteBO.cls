public with sharing class LogClassificacaoClienteBO {

    public static LogClassificaoCliente__c gerarLogParaBatch(){

        LogClassificaoCliente__c newLog = new LogClassificaoCliente__c(Finalizado__c=false, DataExecucao__c = Date.today());
        //system.debug('after '+newLog.Id);
        insert newLog;
        //system.debug('before '+newLog.Id);
        return newLog;
    }

    public static void alterarLogFinalizado(LogClassificaoCliente__c log){
        
        log.Finalizado__c = true;
        update log;
    }
}