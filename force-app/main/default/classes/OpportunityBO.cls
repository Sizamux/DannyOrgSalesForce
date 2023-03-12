public with sharing class OpportunityBO {

    public static void aoCriarOp(List<Opportunity> oppys){
        Map<Id, Id> accIdOppId = new Map<Id, Id>();
        for(Opportunity itemOpp : oppys){
            accIdOppId.put(itemOpp.AccountId, itemOpp.id);
        }
        if(!accIdOppId.isEmpty()){
            List<Account> listaContaUltimaOP = [SELECT Id, LastOpportunity__c 
                                                FROM Account 
                                                WHERE Id = :accIdOppId.keySet() 
                                                ORDER BY CreatedDate ASC];

            System.debug('OpportunityBO >> AoCriarOp >> Map<Id,Id> accIdOppId =' + accIdOppId);
            System.debug('OpportunityBO >> AoCriarOp >> List<Account> AccList =' + listaContaUltimaOP);
            
            for(Account itemAcc : listaContaUltimaOP){
                itemAcc.LastOpportunity__c = accIdOppId.get(itemAcc.Id);
            }

            update listaContaUltimaOP;
        }
    }

    //v1
    public static void aoVincularOppy(List<Opportunity> oppys){
        Set<Id> oppSet = new Set<Id>();
        Set<Id> accSet = new Set<Id>();

        for(Opportunity itemOpp : oppys){
            //if(itemOpp.ContactId != NULL){
                oppSet.add(itemOpp.id);
                accSet.add(itemOpp.AccountId);
            //}
        }
        if(!accSet.isEmpty()){
            aoVincularOppyFuture(accSet);
        }
        System.debug(oppSet);
        System.debug(accSet);
    }

    //v2
    /*public static void aoVincularOppy(List<Opportunity> oppys){
        //Set<Id> oppSet = new Set<Id>();
        Set<Id> accSet = new Set<Id>();
        Set<Id> ctcSet = new Set<Id>();
        //Map<Id, List<Id>> accIdOpts  = new Map<Id, List<Id>>();
        //Map<Id, List<Id>> accIdCtcts = new Map<Id, List<Id>>();
        
        for(Opportunity itemOpp : oppys){
            accSet.add(itemOpp.AccountId);
        }
        List<Contact> ctcs = [SELECT Id,  AccountId FROM Contact WHERE AccountId IN :accSet];
        List<OpportunityContactRole> tempOCR = [SELECT id,ContactId,OpportunityId 
                                                    FROM OpportunityContactRoles 
                                                    WHERE AccountId IN :accSet];
        
        for (Opportunity itemOppy : oppys) {
            for(Contact itemctc : ctcs){
                if(tempOCR.isEmpty()){
                    
                }
                for(OpportunityContactRole itemOCR : tempOCR){
                    if(itemOCR.ContactId == itemctc && itemOCR.ContactId == itemOppy){
                        
                
                    }
                }
            }
        }                      

        for(Id accItemSet : accSet){
            List<Opportunity> tempOCRinACC = new List<Opportunity>();
            List<Contact> tempOCRinACC = new List<Contact>();
            for(OpportunityContactRole itemOCR : tempOCR){
                tempOCRinACC.add(itemOCR.OpportunityId);
                tempOCRinACC.add(itemOCR.OpportunityId
            }
            accIdOpts.put(accItemSet, tempOCRinACC);
        }
        List<OpportunityContactRole> ocrParaJson = new List<OpportunityContactRole>();
        

        for(Id itemAccSet : accSet){
            ctcSet
        }
       

        for(OpportunityContactRole itemOCR : tempOCR){
            accIdOppId.put(itemOCR.AccountId, itemOCR);
        }

        //Insert
        if(ocrParaJson.isEmpty()){

        }else{                      //Update

        }
        System.debug('OpportunityBO >> AoCriarOp >> Map<Id,Id> accIdOppId =' + accIdOppId);
        System.debug('OpportunityBO >> AoCriarOp >> List<Account> AccList =' + listaContaUltimaOP);



        for(Opportunity itemOpp : oppys){
            if(itemOpp.ContactId != NULL){
                oppSet.add(itemOpp.id);
                accSet.add(itemOpp.AccountId);
            }
        }
        if(!accSet.isEmpty()){
            aoVincularOppyFuture(accSet);
        }
        System.debug(oppSet);
        System.debug(accSet);
    }*/
    
    @future
    public static void aoVincularOppyFuture(Set<Id> accSet){
        List<Opportunity> oppys = new List<Opportunity>();
        List<Contact> ctcs = new List<Contact>();
        oppys = [SELECT Id,  AccountId FROM Opportunity WHERE AccountId IN :accSet];
        ctcs  = [SELECT Id,  AccountId FROM Contact WHERE AccountId IN :accSet];

        System.debug(oppys);
        System.debug(ctcs);
        List<OpportunityContactRole> oppysCR = new List<OpportunityContactRole>();
        OpportunityContactRole newOpCR = new OpportunityContactRole();
        //List<OpportunityContactRole> tempCR = [SELECT id,ContactId,OpportunityId 
        //                                        FROM OpportunityContactRoles 
        //                                        WHERE AccountId IN :accSet AND ContactId IN :ctcsSet)];
        
        if(!oppys.isEmpty()){
            for(Opportunity itemOpp : oppys){
                for(Contact itemctcts : ctcs){
                        newOpCR = new OpportunityContactRole(       ContactId = itemctcts.Id, 
                                                                    OpportunityId = itemOpp.Id);
                    oppysCR.add(newOpCR);
                }
            }
        }
        if(!oppysCR.isEmpty()){
            upsert oppysCR;
        }
    }

    //v2
    //@future
    /*public static void aoVincularOppyFuture(String json){
        List<Account> accountList = (List<Account>) JSON.deserialize(json, List<Account>.class);
        upsert accountUpdateList;
        /*List<Opportunity> oppys = new List<Opportunity>();
        List<Contact> ctcs = new List<Contact>();
        oppys = [SELECT Id,  AccountId FROM Opportunity WHERE AccountId IN :accSet];
        ctcs  = [SELECT Id,  AccountId FROM Contact WHERE AccountId IN :accSet];

        System.debug(oppys);
        System.debug(ctcs);
        List<OpportunityContactRole> oppysCR = new List<OpportunityContactRole>();
        OpportunityContactRole newOpCR = new OpportunityContactRole();
        //List<OpportunityContactRole> tempCR = [SELECT id,ContactId,OpportunityId 
        //                                        FROM OpportunityContactRoles 
        //                                        WHERE AccountId IN :accSet AND ContactId IN :ctcsSet)];
        
        if(!oppys.isEmpty()){
            for(Opportunity itemOpp : oppys){
                for(Contact itemctcts : ctcs){
                        newOpCR = new OpportunityContactRole(       ContactId = itemctcts.Id, 
                                                                    OpportunityId = itemOpp.Id);
                    oppysCR.add(newOpCR);
                }
            }
        }
        if(!oppysCR.isEmpty()){
            upsert oppysCR;
        }
    }*/

    //Do Willian
    /*public static void preencherUltimaOportunidade(List<Opportunity> oportunidadeList) {
        // Crio o set de id e add os ids da conta no set        
        Set<Id> idContaSet = new Set<Id>();
        for (Opportunity oportunidade : oportunidadeList) {
            idContaSet.add(oportunidade.AccountId);
        }
        // Busco as Contas relacionadas a oportunidade e add ela em um Map de Conta.        
        List<Account> contaList = AccountDAO.buscarPorId(idContaSet);
        Map<Id, Account> contaMap = new Map<Id, Account>();
        for (Account conta : contaList) {
            contaMap.put(conta.Id, conta);
        }
        List<Account> contaAtualizarList = new List<Account>();
        for (Opportunity oportunidade : oportunidadeList) {
            Account conta = contaMap.get(oportunidade.AccountId);
            // Verifico se o objeto.            if (conta != null) {
                conta.LastOpportunity__c = oportunidade.Id;
                // Add a conta na lista                
                contaAtualizarList.add(conta);
            }
        }
        // Chamo o método futuro se a lista estiver preenchida.        
        if (!contaAtualizarList.isEmpty()) {
            executarFuture(JSON.serialize(contaAtualizarList));
        }
    }

    public static void preencherContatosOportunidade(List<Opportunity> opportunityList) {
        //Crio o set de id e add os ids da conta        
        Set<Id> idContaSet = new Set<Id>();
        for (Opportunity oportunidade : opportunityList) {
            idContaSet.add(oportunidade.AccountId);
        }
        // Busco os contatos relacionados a conta e add eles em um Map de lista de contatos        
        List<Contact> contatoList = ContactDAO.buscarPorConta(idContaSet);
        Map<Id, List<Contact>> contatoMap = new Map<Id, List<Contact>>();
        for (Contact contato : contatoList) {
            List<Contact> contatos = contatoMap.get(contato.AccountId);
            if (contatos == null) {
                contatoMap.put(contato.AccountId, contatos = new List<Contact>());
            }
            contatos.add(contato);
        }
        List<OpportunityContactRole> contatoOportunidadeList = new List<OpportunityContactRole>();
        for (Opportunity oportunidade : opportunityList) {
            List<Contact> contatos = contatoMap.get(oportunidade.AccountId);
            //Verifico a lista vazia            
            if (contatos.isEmpty()) {
                continue;
            }
            // Em cada contato eu crio o contato da oportunidade            
            for (Contact contato : contatos) {
                OpportunityContactRole opportunityContactRole = new OpportunityContactRole();
                opportunityContactRole.OpportunityId = oportunidade.Id;
                opportunityContactRole.ContactId = contato.Id;
                contatoOportunidadeList.add(opportunityContactRole);
            }
        }
        // Chamo o método futuro        
        if (!contatoOportunidadeList.isEmpty()) {
            executarFuture(JSON.serialize(contatoOportunidadeList));
        }
    }

    @future    
    private static void executarFuture(String jsonObjeto) {
        List<SObject> objetoList = (List<SObject>) JSON.deserialize(jsonObjeto, List<SObject>.class);
        // Inseri ou Atualizo os registros da lista        upsert objetoList;
    }

    public static void gerarContrato(List<Opportunity> opportunityList) {
        List<Contract> contratoList = new List<Contract>();
        for (Opportunity oportunidade : opportunityList) {
            Contract contrato = new Contract();
            contrato.AccountId = oportunidade.AccountId;
            contratoList.add(contrato);
        }
        insert contratoList;
        Map<Id, Contract> contratoMap = new Map<Id, Contract>();
        for (Contract contrato : contratoList) {
            contratoMap.put(contrato.AccountId, contrato);
        }
    }
    */

    // Sche Exe 1
    public static void criarContratoSched(){

        String CRON = '0 23 15 * * ?';
        // Schedule the test job
        String jobId = System.schedule('Criar Contratos para Opportunities',
                                         CRON, new OpportunityCaseWonSchee());
    }

    // Queaueble Exe 1
    //Call
    public static void oppSemContatosQueueable(List<Opportunity> opportunities){

        oppSemContatosQueueable opSCQueue = new oppSemContatosQueueable(opportunities);
        // enqueue the job for processing
        ID jobID = System.enqueueJob(opSCQueue);
    }

    // Queaueble Exe 2
    //Call
    public static void oppComDataFechQueable(){

        oppComDataFechamento opSCQueue = new oppComDataFechamento();
        // enqueue the job for processing
        ID jobID = System.enqueueJob(opSCQueue); //call queue exe2
    }
}