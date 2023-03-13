public class AnimalLocator {

    public static String getAnimalNameById(Integer id){
        /*
        http http = new Http();
        HttpRequest request = new HttpRequest();
        request.setEndpoint(endpoint);
        request.setMethod('GET');
        HttpResponse response = http.send(request);
        */
		http http = new Http();
        HttpRequest request = new HttpRequest();
        request.setEndpoint('https://th-apex-http-callout.herokuapp.com/animals/'+id);
        request.setMethod('GET');
        HttpResponse response = http.send(request);

        Map<String, Object> result = (Map<String, Object>)JSON.deserializeUntyped(response.getBody());
        Map<String, Object> animal = (Map<String, Object>)result.get('animal'); 
        system.debug(result);
        system.debug(animal);
        system.debug(string.valueOf(animal.get('name')));
        return string.valueOf(animal.get('name'));
         
    }
}