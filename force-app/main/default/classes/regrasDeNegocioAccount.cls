public with sharing class regrasDeNegocioAccount {
    //Insert
    public regrasDeNegocioAccount(List<Account> acc) {
        for (Account item : acc) {
            if((item.Match_Billing_Address__c) &&                           //está marcado?
              (item.ShippingPostalCode != null) &&                          //está nulo?
              !(item.ShippingPostalCode == item.BillingPostalCode) ){       //Campo é diferente?
                item.BillingPostalCode = item.ShippingPostalCode;   //Faz
            }
        }
    }

    //Update
    public regrasDeNegocioAccount(List<Account> acc, Map<Id, Account> accOldMap) {
        for (Account item : acc) {
            if((item.Match_Billing_Address__c) &&                                       //está marcado?
              (item.ShippingPostalCode != null) &&                                      //está nulo?
              //(item.Id ==  accOldMap.get(item.Id).id) &&                              //Compara Listas
              !(item.ShippingPostalCode == accOldMap.get(item.Id).ShippingPostalCode) &&//Campo cep foi atualizada? 
              !(item.ShippingPostalCode == item.BillingPostalCode) ){                   //Campo é diferente?
                item.BillingPostalCode = item.ShippingPostalCode;   //Faz
            }
        }
    }
}