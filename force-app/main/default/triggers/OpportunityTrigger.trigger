trigger OpportunityTrigger on Opportunity (after insert, after update) {
    if(Trigger.isInsert){
        if(Trigger.isAfter){
            //OpportunityBO.aoCriarOp(trigger.new);
            //OpportunityBO.aoVincularOppy(trigger.new);
            //OpportunityBO.oppSemContatosQueueable(trigger.new);
        }
    }
    if(Trigger.isUpdate){
        if(Trigger.isAfter){
            //OpportunityBO.aoVincularOppy(trigger.new);
            //OpportunityBO.oppSemContatosQueueable(trigger.new);
        }
    }
}