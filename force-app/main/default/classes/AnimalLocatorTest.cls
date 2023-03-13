@isTest
private class AnimalLocatorTest {

    @isTest
    static void animalLocatorTeste1(){
     	Test.setMock(HttpCalloutMock.class, new AnimalLocatorMock());
        system.debug(AnimalLocator.getAnimalNameById(1));
        System.assertEquals('moose', AnimalLocator.getAnimalNameById(1));
        System.assertEquals('bear', AnimalLocator.getAnimalNameById(1));
    }
}