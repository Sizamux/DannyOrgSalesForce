@isTest
public class ParkLocatorTest {
    @isTest 
    static void testParkCallout() {    
    	Test.setMock(WebServiceMock.class, new ParkServiceMock());
        String country = 'United States';
        List<String> expected= new List<String>{'Yosemite', 'Sequola', 'Crater Lake'};
        System.assertEquals(expected, ParkLocator.country(country));
    }
}