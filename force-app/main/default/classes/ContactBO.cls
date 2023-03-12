public with sharing class ContactBO {
     //Batch exe 2 para Unico Contato
     public static void vincularCaseAoContactViaBatch(Contact cctc){
        ContactsCaseBatch CtcsBatch = new ContactsCaseBatch(cctc.id);
        Id batchId = Database.executeBatch(CtcsBatch, 10);
        System.debug('batch id -'+ batchId);
    }

    //Batch exe 2 para Lista de Contatos
    public static void vincularCaseAoContactViaBatch(List<Contact> ctcts){
        Id lastContact;

        for(Contact itemCtcts : ctcts){
            lastContact = itemCtcts.id;
        }
        ContactsCaseBatch CtcsBatch = new ContactsCaseBatch(lastContact);
        Id batchId = Database.executeBatch(CtcsBatch, 10);
        System.debug('batch id -'+ batchId);
    }

    //Sched exe 2
    
    public static void callSchedForCtctCaseBatch(){
        String CRON = '0 20 15 * * ?';
        // Schedule the test job
        String jobId = System.schedule('Vincula cases sem contato com o contato criado + novo', CRON, new ContactsCaseCallBatchSched());
    }
}