@isTest
public class exeSql2Test {
	@TestSetup	//popula Test
    private static void getData(){
        Account conta = new Account();
        conta.Name = 'conta Test';
        insert conta;
        
        
        Contract contrato = new Contract();
        contrato.AccountId = conta.id;
        insert contrato;
    }
    
    @isTest
    private static void todosOsContratosTest(){
        ExeSQL2 exesoql = new ExeSQL2();
        Integer expected = [SELECT count() FROM Contract];
    }
    
}