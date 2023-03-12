public with sharing class StringArrayTest {
    
    public static List<String> generateStringArray(Integer var1) {
        
        List<String> temporario = new List<String>();
        for(Integer i = 0 ; i<var1 ; i++){
            temporario.add('Test '+i);
        }
        return temporario;  
    
    
    }
}