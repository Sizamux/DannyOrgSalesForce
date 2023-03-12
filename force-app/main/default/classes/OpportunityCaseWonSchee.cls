public with sharing class OpportunityCaseWonSchee implements Schedulable {
    public void execute(SchedulableContext ctx) {
        List<Account> accts = [ SELECT Id, (SELECT Id, StageName, Amount
                                            FROM Opportunities 
                                            WHERE StageName = 'Closed Won'
                                            Or Amount >= 100000)
                                FROM Account ];

        List<Contract> newContractList = new List<Contract>();

        for (Account itemAcc : accts) {
            if(itemAcc.Opportunities.size()>0){
                for(Opportunity itemOppy: itemAcc.Opportunities){
                    Contract newContract = new Contract(    AccountId = itemAcc.Id,
                                                            Status    = 'Draft',
                                                            StartDate = Date.today(),
                                                            ContractTerm = 3
                                                        );
                    newContractList.add(newContract);
                }
            }
        }
        if(!newContractList.isEmpty()){
            insert newContractList;
        }
    }
}