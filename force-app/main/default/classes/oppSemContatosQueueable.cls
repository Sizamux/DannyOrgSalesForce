//Queuable Exe 1
public with sharing class oppSemContatosQueueable implements Queueable{
    private List<Opportunity> oppysList;

    public oppSemContatosQueueable(List<Opportunity> rOppys){
        oppysList = rOppys;
    }

    public void execute(QueueableContext context) {
        set<Id> seTappId = new Set<Id>();
        set<Id> seToppId = new Set<Id>();
        for(Opportunity oppyFset : oppysList){
            seTappId.add(oppyFset.AccountId);
            seToppId.add(oppyFset.Id);
        }
        List<Opportunity> oppysWOCR = [ SELECT Id, AccountId, (SELECT Id, ContactId
                                                            FROM OpportunityContactRoles)
                                        FROM Opportunity 
                                        WHERE id IN :seToppId 
                                        AND AccountId != null];   
        List<Account> acctWContactOfOppys = [   SELECT Id, (SELECT Id
                                                            FROM Contacts
                                                            LIMIT 1)
                                                FROM Account
                                                WHERE id IN :seTappId];
        if(!oppysWOCR.isEmpty()){
            List<OpportunityContactRole> ctctRoles = new List<OpportunityContactRole>();
            for(Opportunity itemOppy : oppysWOCR){
                Contact ctctsTemp = new Contact();
                for(Account accItem : acctWContactOfOppys){
                    if(itemOppy.AccountId == accItem.Id &&
                        itemOppy.OpportunityContactRoles.size()==0){
                        ctctsTemp = accItem.Contacts.get(0);
                        OpportunityContactRole ctctRole = new OpportunityContactRole(   ContactId = ctctsTemp.Id,
                                                                                        OpportunityId = itemOppy.Id);
                        ctctRoles.add(ctctRole);
                    }
                }
            }
            if(!ctctRoles.isEmpty()){
                insert ctctRoles;
            }
        }
    }
}