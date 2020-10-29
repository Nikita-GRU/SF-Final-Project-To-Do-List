/**
 * Created by JJ93 on 20.09.2020.
 */

public with sharing class RESTClientMock implements HttpCalloutMock {
  public static final String POST_EXTERNAL_ID = 'a022w00000HuGfHAAV';
  public HttpResponse respond(HttpRequest request) {
    HttpResponse response = new HttpResponse();
    response.setHeader('Content-Type', 'application/json');
    response.setStatusCode(200);
    if (request.getMethod().equals('POST')) {
      response.setBody(JSON.serialize(createSampleToDoList()));
    } else if (request.getMethod().equals('DELETE')) {
      //unused
    } else if (request.getMethod().equals('PATCH')) {
      response.setBody(JSON.serialize(createSampleToDoList()));
    }
    return response;
  }
  private List<To_Do__c> createSampleToDoList(){
    To_Do__c toDo = new To_Do__c(
        Id = POST_EXTERNAL_ID,
        Name = 'test',
        Start_Date__c = DateTime.now(),
        Description__c = 'test description'
      );
      List<To_Do__c> toDos = new List<To_Do__c>();
      toDos.add(toDo);
      return toDos;
  }

}
