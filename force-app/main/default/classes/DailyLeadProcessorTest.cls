@IsTest
public class DailyLeadProcessorTest {
    
    private static String CRON_EXP = '0 0 0 ? * * *';
    
@IsTest
    private static void testSchedulableClass(){
        
     //Carregar dados para test
        List<Lead> leads = new List<Lead>();
        for (Integer i=0; i<500; i++){
            if(i<250){
                leads.add(new Lead(LastName='Connock', Company='Salesforce'));
            }else{
                leads.add(new Lead(LastName='Connock', Company='Salesforce',LeadSource='Other'));
            }
        }
        insert leads;
        
        //Fazer o teste
        Test.startTest();
        String jobId = System.schedule('Process Lead', CRON_EXP, new DailyLeadProcessor());
        Test.stopTest();
        
        //Checar resultados
    	List<Lead> updatedLeads = [SELECT Id, LeadSource FROM Lead WHERE LeadSource = 'Dreamforce'];
        system.assertEquals(200, updatedLeads.size(), 'Erro');
        
        //ChecarTempo
        List<CronTrigger> cts = [SELECT Id, TimesTriggered,NextFireTime FROM CronTrigger Where id = :jobId];
        system.debug('test ' + cts[0].NextFireTime);       
    }
}