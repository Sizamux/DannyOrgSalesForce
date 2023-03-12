public with sharing class AccountHandler {
    
    public static void insertAccount(Integer num){
        List<Account> addAccounts = new List<Account>();
        
        for(Integer n=0 ; n<num ; n++){
            Account conta = new Account(Name= 'Acme Inc '+n,
                                        AccountNumber= 'A000'+n);
            addAccounts.add(conta);
        }
        insert addAccounts;

    }
    
    public static Account insertNewAccount(String var1){
        try{
            Account conta = new Account(Name=var1);
            insert conta;
            return conta;
        }catch(DmlException e){
            System.debug('DmlException: ' + e.getMessage());
            return null;
        }
   }
}