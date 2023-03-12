trigger AccountTrigger on Account (after insert,  before insert,before update/*,before delete, after delete,after undelete*/) {
    // AccountFicharioInteraction afi = new AccountFicharioInteraction();
    //AccountBO accBo = new AccountBO();
    // AccountOppyInteraction aoi = new AccountOppyInteraction();

    if(Trigger.isInsert){
        if(Trigger.isBefore){
            //aoi.insertBefore(trigger.new);
            //regrasDeNegocioAccount a = new regrasDeNegocioAccount(Trigger.new);
            AccountBO.matchBillingAccInsert(trigger.new);
        }
        if(Trigger.isAfter){
            //accBo.aoPreencherMatriz(trigger.new);
            //afi.insertAfter(trigger.new);
            //aoi.insertAfter(trigger.new);
            AccountBO.criarTaskAposAccInsert(trigger.new);  
        }
    }
    if(Trigger.isUpdate){
        if(Trigger.isBefore){
            AccountBO.matchBillingAccUpdate(trigger.new); 
            //regrasDeNegocioAccount b = new regrasDeNegocioAccount(Trigger.new, Trigger.oldMap);
        }
        //if(Trigger.isAfter){
            //accBo.aoPreencherMatriz(trigger.new);
            //accBo.verificaDeEmpresasAfiliadas(trigger.new);
            //aoi.updateAfter(trigger.new, trigger.oldMap);
        //}
    }
    /*if(Trigger.isDelete){
        if(Trigger.isBefore){
            //afi.deleteBefore(trigger.oldMap);
        }
        if(Trigger.isAfter){
            //afi.deleteAfter(trigger.old);
        }
    }
    if(Trigger.isUndelete){
        //afi.undeleteAfter(trigger.new);
    }*/
}