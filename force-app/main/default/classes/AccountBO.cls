public with sharing class AccountBO {
    /* private static AccountBO instance = new AccountBO();
        // public static AccountBO getInstance(){
        //     return instance;
        // }

        // public static void verificaDeEmpresasAfiliadas( List<Account> contas ){
        //     Set<Id> setIdParent = new Set<Id>();

        //     for (Account accItem : contas) {
        //         if( accItem.Faturamento__c != null &&
        //             accItem.ParentId != null &&
        //             accItem.Faturamento__c >= 1000000 ){

        //                 setIdParent.add(accItem.ParentId);
        //         }
        //     }
        //     if( !setIdParent.isEmpty() ){
        //         List<Account> contaPai = new List<Account>();
        //         contaPai =   AccountDAO.getInstance().buscarContas(setIdParent);
        //         if( !contaPai.isEmpty() ){
        //             List<Account> accList = new List<Account>();
        //             for( Account itemPai : contaPai ) {
        //                 Account accTemp = new Account();
        //                 for( Account itemFilho : itemPai.ChildAccounts ){
        //                     if(itemFilho.Faturamento__c > accTemp.Faturamento__c || accTemp.Faturamento__c == NULL){
        //                         accTemp = itemFilho;
        //                     }
        //                 }
        //                 itemPai.ContaDeMaiorFaturamento__c = accTemp.Id;
        //                 if(itemPai.ContaDeMaiorFaturamento__c != NULL){
        //                     accList.add(itemPai);
        //                 }
        //             }
        //             if(!accList.isEmpty()){
        //                 update accList;
        //             }
        //         }
        //     }
        // }

        // //After INSERT
        // public static void aoPreencherMatriz( List<Account> accNew ){
        //     Set<Id> setIdParent = new Set<Id>();
        //     List<Account> contasPai = new List<Account>();
        //     Id filialRT = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Filial').getRecordTypeId();
        //     Id matrizRT = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Matriz').getRecordTypeId();
            
        //     System.debug('RT Matriz= ' + matrizRT);

        //     for( Account itemNeW : accNew ){

        //         System.debug('itPID' + itemNeW.ParentId);

        //         if( itemNeW.RecordTypeId == filialRT){
        //             setIdParent.add(itemNeW.ParentId);
                    
        //         }
        //     }

        //     System.debug('Set Matriz =' + setIdParent);

        //     if(!setIdParent.isEmpty()){
        //         // contasPai = [SELECT Id, QuantidadeContas__c, ( SELECT Id 
        //         //                                                 FROM ChildAccounts   
        //         //                                                 WHERE RecordTypeId = :filialRT ) 
        //         //             FROM Account 
        //         //             WHERE Id IN :setIdParent AND RecordTypeId = :matrizRT];
        //         contasPai = AccountDAO.getInstance().buscarContasMatrizComFilhos(setIdParent, filialRT, matrizRT);
        //     }
        //     for( Account itemPai : contasPai ){
        //         itemPai.QuantidadeContas__c = itemPai.ChildAccounts.size();
        //     }
        //     update contasPai;
            
        //     System.debug('Account Pais = ' + contasPai);
        // }

        // public static void atualizarNomeCota(List<Account> accountList){
        //     Set<Id> idAccountSet = new Set<Id>();
        //     for(Account conta : accountList){
        //         idAccountSet.add(conta.id);
        //     }

        //     atualizarNomeContaFuture(idAccountSet, 'Empresa - ');
        // }

        // @future
        // public static void atualizarNomeContaFuture(Set<Id> idAccountSet, String nomePadrao){
        //     List<Account> accountList = new List<Account>();
        //     accountList = [SELECT Id,Name FROM Account WHERE Id IN :idAccountSet];

        //     List<Account> accountUpdateList = new List<Account>();
        //     for (Account conta : accountList) {
                
        //         conta.Name = nomePadrao + conta.Name;
        //         accountUpdateList.add(conta);
        //     }
        //     Update accountUpdateList;
        // }

        // @future
        // public static void integrarConta(Set<Id> idAccountSet, String nomePadrao){
        //     List<Account> accountList = new List<Account>();
        //     accountList = [SELECT Id,Name FROM Account WHERE Id IN :idAccountSet];

        //     List<Account> accountUpdateList = new List<Account>();
        //     for (Account conta : accountList) {
                
        //         //conta.IntegrarConta__c = true;
        //         accountUpdateList.add(conta);
        //     }
        //     Update accountUpdateList;
        // }
        // @future
        // public static void integrarConta(String jsonConta){
        //     List<Account> accountList =  (List<Account>) JSON.deserialize(jsonConta, List<Account>.class);

        //     List<Account> accountUpdateList = new List<Account>();
        //     for (Account conta : accountList) {
                
        //         //conta.IntegrarConta__c = true;
        //         accountUpdateList.add(conta);
        //     }
        //     Update accountUpdateList;
        // }

        // public static void marcarContaInegracao(List<Account> contaList){
        //     String jsonConta = JSON.serialize(contaList);

        //     integrarConta(jsonConta);

        // }
    
        public static void chamandoBatchEnderecoAccConta(){
            AccountContactsBatch accCtcsBatch = new AccountContactsBatch();
            Id batchId = Database.executeBatch(accCtcsBatch, 10);
            System.debug('batch id -'+ batchId);
        }
    */
    public static void criarTaskAposAccInsert(List<Account> accNew){
        
        if(!accNew.isEmpty()){
            List<Task> tasks = new List<Task>();
            for(Account itemAcc : accNew){
                Task newTask = new Task(WhatId = itemAcc.Id,
                                        Status = 'Not Started',
                                        Subject = 'Teste '+itemAcc.Name,
                                        Priority = 'Normal'
                                        );
                tasks.add(newTask);
            }
            if(!tasks.isEmpty()){
                insert tasks;
            }
        }
    }

    public static void matchBillingAccInsert(List<Account> accNew){
        if(!accNew.isEmpty()){
            for (Account accItem : accNew){
                if(accItem.Match_Billing_Address__c == true &&
                    accItem.BillingPostalCode != null ){
                    accItem.ShippingPostalCode = accItem.BillingPostalCode;
                }                    
            }
        }
    }

    public static void matchBillingAccUpdate(List<Account> accNew){
        if(!accNew.isEmpty()){
            for (Account accItem : accNew){
                if(accItem.Match_Billing_Address__c == true &&
                    accItem.BillingPostalCode != null ){
                    accItem.ShippingPostalCode = accItem.BillingPostalCode;
                }                    
            }
        }
    }

    public static void verificarClassificacao(List<Account> accNew){
        List<Account> contasReclassificada = new List<Account>();
        //classifica
        if(!accNew.isEmpty()){
            for (Account accItem : accNew){
                if(accItem.AnnualRevenue < 0 || accItem.AnnualRevenue == null){
                    system.debug('Valor Invalido');
                    continue; //Vai para o proximo se possuir valor invalido
                } else if(accItem.AnnualRevenue < 5001){
                    accItem.Classificao__c = 'Prata';
                } else if(accItem.AnnualRevenue < 500001){
                    accItem.Classificao__c = 'Ouro';
                } else {
                    accItem.Classificao__c = 'Diamante';
                }   
                contasReclassificada.add(accItem);      
            }
        }
        if(!contasReclassificada.isEmpty()){
            update contasReclassificada;
        }
    }
}