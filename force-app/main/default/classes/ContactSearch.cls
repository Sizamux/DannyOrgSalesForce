public with sharing class ContactSearch {
    public ContactSearch() {

    }   

    public static List<Contact> searchForContacts(String var1, String var2) {
        List<Contact> contatos = [SELECt id, FirstName, LastName from Contact WHERE LastName = :var1 and MailingPostalCode = :var2];
        return contatos;
    }

}