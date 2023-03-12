public with sharing class ExeSQL2 {


    public void ListarContaDe(){
        List<Account> query = [ SELECT Id, Name FROM Account WHERE Name LIKE '%teste%' ];
        system.debug(query);
    }
    //1
    public void AtualizarOportunidade(String oppId, Decimal valor){
        Opportunity oppEditar = [ SELECT Id, Amount FROM Opportunity WHERE Id = :oppId] ;
        oppEditar.Amount = valor;
        insert oppEditar;
        System.debug('Posterior: '+oppEditar.Amount);
    }
    //2
    public void DesativarAccount(String accId){
        Account accEditar = [ SELECT Id, Active__c FROM Account WHERE Id = :accId] ;
        accEditar.Active__c = 'No';
        update accEditar;
        System.debug('Teste: '+accEditar.Active__c);
    }
    //3
    public Boolean CriarContato(Id accId, String nomeC, String cargo, Date dataNasc, String nEmail){
       
        String[] namefull = nomeC.split(' ', 2);

        Contact contact = new Contact(  AccountId=accId,
                                        FirstName=namefull[0],
                                        LastName=namefull[1],
                                        Title=cargo,
                                        Birthdate=dataNasc,
                                        Email = nEmail
                                     );
        
        try{
            insert contact;
            return true;
        }catch(DmlException e){
            System.debug('DmlException: ' + e.getMessage());
            return false;
        }
    }


    //4
    public void casoSinistro(String accId){
        Account acc = [ SELECT Id, Active__c, OwnerId,CNPJ__c  FROM Account WHERE Id = :accId] ;
        try{
            //É Pj?
            if(!((acc.CNPJ__c == null)||(acc.CNPJ__c == ''))){
                CriarCaso(acc);
            }else{
                //system.debug('não é pj');
                throw new CaseException('não é pj');
            }
        }catch(Exception e){
            System.debug('Erro: ' + e.getMessage());
        }
    }

    //5
    public void CriarCaso(Account acc){
        try{
            Contact contact = [ SELECT Id,Name,AccountId FROM Contact WHERE AccountId = :acc.Id] ;
            //Testa se Conta possui contato
            if(!(contact == null)){
                //Cria Caso Sinistro
                Case newCase = new Case (   ContactId= contact.id,
                                            AccountId= contact.AccountId,
                                            Subject  = contact.Name +' - Sinistro',
                                            OwnerId  = acc.OwnerId
                                        );
                insert newCase;
            }else{
                //system.debug('Conta não possui contato');
                throw new CaseException('Conta não possui contato');
            }
        }catch(Exception e){
            System.debug('Erro: ' + e.getMessage());
        }
    }

    //Lista
    public void getByRecordType(){
        Id devRecordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Teste').getRecordTypeId();
        List<Account> acc = [ SELECT Id, Name,RecordType.Id  FROM Account WHERE RecordType.Id = :devRecordTypeId] ;
        //Listar 1 por 1
        for(Account item : acc){
            system.debug(item);
        }    
    }
    
    //7
    public void AtualizaRecordTypeTeste(){
        Id devRecordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Teste').getRecordTypeId();
        List<Account> acc = [ SELECT Id, Name,RecordType.Id  FROM Account WHERE RecordType.Id = :devRecordTypeId] ;
        //Assign 1 por 1
        for(Account item : acc){
            try{
                item.Name = ' ';
                update item;
            }catch(DmlException e){
                System.debug('Erro: ' + e.getMessage());
            }
        }
    }

    public void AtualizaRecordTypeParaConsEVogal(){
        //Get RecordType,Id do RecordType 'Teste'
        Id devRecordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Teste').getRecordTypeId();
        //Get Account by RecordType.Id
        List<Account> acc = [ SELECT Id, Name,RecordType.Id  FROM Account WHERE RecordType.Id = :devRecordTypeId];
        //Chama Lista Vazia  
        List<Contact> cont = new List<Contact>();
        //Para cada item de conta Verifica todos os contatos e adiciona na lista cont
        for(Account item : acc){
            List<Contact> temp = [ SELECT Id, FirstName  FROM Contact WHERE AccountId = :item.Id ] ;
            for(Contact item2 : temp){
                cont.add(item2);
            }
        }
        //contador para identificar posicao
        Integer contador=0;
        //Para cada item da lista contato faz:
        for(Contact item : cont){
            try{
                //Se o contato tiver na posição menor que a metade da lista faz:
                if(contador<(acc.size())/2){
                    String newName = 'O'+(item.FirstName).mid(1, 20); //Substitui vogal a primeira posição da String
                    item.FirstName = newName;
                    update item;
                //senão faz:
                }else{
                    String newName = 'D'+(item.FirstName).mid(1, 20); //Adiciona Consoante a primeira posição da String
                    item.FirstName = newName;
                    update item;
                }
            }catch(DmlException e){
                System.debug('Erro: ' + e.getMessage());
            }
            contador++;
        }
    }


}