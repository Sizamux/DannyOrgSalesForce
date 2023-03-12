//Queable Exe 2
public with sharing class  oppComDataFechamento  implements Queueable{
    
    public void execute(QueueableContext context) {
        List<Opportunity> oppysUpdated =    [ SELECT Id, Description,CloseDate,AccountId
                                                FROM Opportunity 
                                                WHERE CloseDate > :Date.today()
                                            ];
        System.debug(Date.today());                      
        System.debug(oppysUpdated);
        if(!oppysUpdated.isEmpty()){
            for(Opportunity itemOptn : oppysUpdated){
                itemOptn.Description = 'Oportunidades com contato associado' ;
                system.debug(itemOptn.CloseDate);
            }
            update oppysUpdated;
            // Chain this job to next job by submitting the next job
            oppSemContatosQueueable opSCQueue = new oppSemContatosQueueable(oppysUpdated);
            // enqueue the job for processing
            ID jobID = System.enqueueJob(opSCQueue); //encadeia queue exe1
        }
    }
}