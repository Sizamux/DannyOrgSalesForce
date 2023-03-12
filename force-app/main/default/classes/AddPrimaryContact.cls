public with sharing class AddPrimaryContact implements Queueable{
    private Contact contact;
    private String stateAbreviation;
    public AddPrimaryContact(Contact rContact, String rStateAbreviation) {
        contact = rContact;
        stateAbreviation = rStateAbreviation;
    }

    public void execute(QueueableContext context) {
        List<Account> acclist = [SELECT Id 
                                FROM Account
                                WHERE BillingState = :stateAbreviation 
                                LIMIT 200];
        List<Contact> ctcts = new List<Contact>();
        for (Account acc : acclist) {
            //Clone
            Contact contactClone = contact.clone();
            contactClone.AccountId = acc.Id;
            ctcts.add(contactClone);
        } 
        insert ctcts;    
    }
}