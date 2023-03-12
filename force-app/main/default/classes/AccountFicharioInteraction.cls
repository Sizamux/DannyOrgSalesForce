public with sharing class AccountFicharioInteraction {
    //After Insert
    public void insertAfter(List<Account> accNew){
        List<Fichario__c> listaFish = new List<Fichario__c>();
        for(Account item : accNew){
                Fichario__c newFish = new Fichario__c();
                newFish.Account__c = item.Id;
                listaFish.add(newFish);
        } 
        if(!listaFish.isEmpty()){
            insert listaFish;
        }
    }
    public void deleteBefore(List<Account> accOld){
        List<Fichario__c> fishExistentes = new List<Fichario__c>();
        Set<Id> setIdConta = new Set<Id>();
        for(Account item : accOld){
            setIdConta.add(item.Id);
        }
        if(!setIdConta.isEmpty()){
            fishExistentes = [SELECT Account__c FROM Fichario__c WHERE Account__c IN :setIdConta];
        }
        System.debug(fishExistentes);
        if(!fishExistentes.isEmpty()){
            delete fishExistentes;
        }
    }
    //Before Delete
    public void deleteBefore(Map<Id,Account> accOld){
       // FicharioDAO chamaDao = new FicharioDAO();
        List<Fichario__c> fishExistentes = new List<Fichario__c>();
        Set<Id> setIdConta = new Set<Id>();
        for(Id item : accOld.keySet()){
            setIdConta.add(item);
        }
        if(!setIdConta.isEmpty()){
            fishExistentes = FicharioDAO.getInstance().buscaFichariosPorConta(setIdConta);
        }
        System.debug(fishExistentes);
        if(!fishExistentes.isEmpty()){
            delete fishExistentes;
        }
    }
    //After Delete
    public void deleteAfter(List<Account> accOld){
        List<Case> listaCase = new List<Case>();
        for(Account item : accOld){
                Case newCase = new Case(Status = 'New', Origin = 'Deleção');
                newCase.Description = 'Conta Deletada '+ item.Name +' id:'+ item.Id;
                newCase.Subject ='Conta Deletada '+ item.Name +' id:'+ item.Id;
                listaCase.add(newCase);
        } 
        if(!listaCase.isEmpty()){
            insert listaCase;
        }
    }
    public void undeleteAfter(List<Account> accNew){
        List<Case> listaCase = new List<Case>();
        for(Account item : accNew){
            System.debug(listaCase);
            Case newCase = new Case(Status = 'New', Origin = 'Deleção');
            newCase.Description = 'Conta Recuperada'+ item.Name +' id:'+ item.Id;
            newCase.Subject ='Conta Recuperada '+ item.Name +' id:'+ item.Id;
            listaCase.add(newCase);
        }
        update listaCase;
    }
}