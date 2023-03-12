public with sharing class ConsultaSQL {
    
    //1 system.debug( testeQuery.todosOsContratos() );
    public List<Contract> TodosOsContratos(){
        string query = 'select id from Contract';
        return (List<Contract>)Database.query(query);
    }
    //2 system.debug( testeQuery.contratosAtivados() );
    public List<Contract> ContratosAtivados(){
        return [select id, Status from contract where Status = 'Activated'];
    }
    //3 system.debug( testeQuery.listaContratoDe( '001Dn00000GFq3kIAD' ) );
    public List<Contract> ListaContratoDe(String contaId){
        return [SELECT Contract.id from Contract where AccountId = :contaId ];
    }
    //5 system.debug (testeQuery.quatidadeDeDraft() );
    public List<AggregateResult> QuatidadeDeDraft(){
        return [select count(id) quantidade from contract where Status = 'Draft' ];
    }
    //6 system.debug( testeQuery.quantidadeDeParcela( '800Dn000000Q6I8IAK' ) );
    public List<AggregateResult> QuantidadeDeParcela(String contractId){
        return [select sum(ContractTerm) somaContractTerm from contract where id = :contractId ];
    }
    
    public void ListaToString(List<Object> listaTeste){
        String names = string.join(listaTeste,',');
        System.debug(names);
    }
}