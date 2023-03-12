trigger ContactTrigger on Contact (after insert) {
    if(Trigger.isInsert){
        if(Trigger.isAfter){
            //Batch Exe 2 
            ContactBO.vincularCaseAoContactViaBatch(trigger.new);
        }
    }
}