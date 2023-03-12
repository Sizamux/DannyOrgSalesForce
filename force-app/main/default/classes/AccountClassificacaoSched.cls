public with sharing class AccountClassificacaoSched implements Schedulable {
    public void execute(SchedulableContext ctx) {
        AccountClassificacaoBatch accClassBatch = new AccountClassificacaoBatch();
        Id batchId = Database.executeBatch(accClassBatch);
        System.debug('batch id -'+ batchId);
    }
}