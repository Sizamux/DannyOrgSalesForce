public with sharing class OpportunityDAO {
    private static OpportunityDAO instance = new OpportunityDAO();
    public static OpportunityDAO getInstance(){
        return instance;
    }

    public List<Opportunity> getOpportunityInSet(Set<Id> oppSet){
        return [SELECT Id, ContactId FROM Opportunity WHERE Id IN :oppSet];
    }
}