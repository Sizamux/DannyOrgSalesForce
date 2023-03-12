public with sharing class ContactAndLeadSearch {

    public static List<List<sObject>> searchContactsAndLeads(String var1) {
        String soslFindClause = 'Smith';
        List<List<sObject>> searchList = [FIND :soslFindClause IN ALL FIELDS
                    RETURNING Lead(FirstName,LastName),Contact(FirstName,LastName)];
        return searchList;
    }
}