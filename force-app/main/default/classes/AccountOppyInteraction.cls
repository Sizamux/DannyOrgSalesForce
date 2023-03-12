public with sharing class AccountOppyInteraction {
    public AccountOppyInteraction() {

    }
    public void insertBefore(List<Account> accNew){
        for(Account item : accNew){
            item.Type = 'Prospect';
        } 
    }

    // public void insertBefore(List<Account> accNew){} 
    public void insertAfter(List<Account> accNew){
        List<Opportunity> listaOppy = new List<Opportunity>();
        for(Account item : accNew){
            if(item.Type == 'Prospect'){
                Opportunity newOppy = new Opportunity(AccountId = item.Id, 
                                                        Name = item.Name,
                                                        StageName ='Prospecting',
                                                        CloseDate = date.parse('08/08/2088'));
                system.debug(item.Id);
                system.debug(newOppy);
                listaOppy.add(newOppy);
            }
        } 
        if(!listaOppy.isEmpty()){
            insert listaOppy;
        }
    }

    public void updateAfter(List<Account> accNew,Map<Id,Account> accOld){
        List<Opportunity> newOppysExistentes = new List<Opportunity>();
        Set<Id> setIdConta = new Set<Id>();
        for(Account item : accNew){
            If(item.Type != 'Prospect'){
                setIdConta.add(item.Id);
            }
        }
        if(!setIdConta.isEmpty()){
            newOppysExistentes = [SELECT Name,StageName, AccountId FROM Opportunity WHERE AccountId IN :setIdConta];
        }
        if(!newOppysExistentes.isEmpty()){
            for(Opportunity oppyItem : newOppysExistentes){
                oppyItem.StageName ='Closed Won';
            }
            update newOppysExistentes;
        }
    }
}