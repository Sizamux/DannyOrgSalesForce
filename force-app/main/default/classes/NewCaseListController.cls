public with sharing class NewCaseListController {

    
    public List<case> getNewCases(){

        return [SELECT Id, CaseNumber, Status FROM Case];
    }
}