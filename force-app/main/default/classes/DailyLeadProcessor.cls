public with sharing class DailyLeadProcessor implements Schedulable {
    public void execute(SchedulableContext ctx) {
        List<Lead> leads = [SELECT Id, LeadSource
                            FROM Lead
                            WHERE LeadSource = null
                            LIMIT 200];
        for (Lead itemLead : leads) {
            itemLead.LeadSource = 'Dreamforce';
        }
        update leads;
    }
}