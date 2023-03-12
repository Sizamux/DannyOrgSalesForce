@IsTest
(SeeAllData=true) //possibilita a vizualização de todos dados na org
public class FirstTest {
	
    @IsTest
    private static void myContactCount(){
        //popula test
        Integer count = [SELECT count() from Contact];
        system.debug(count);
        
        //test
        //system.assert(count >= 0);
        system.assertEquals(true, count > 0, 'Erro');
    }
}