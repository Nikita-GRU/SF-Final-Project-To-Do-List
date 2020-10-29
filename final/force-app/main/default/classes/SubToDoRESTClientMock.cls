public with sharing class SubToDoRESTClientMock implements HttpCalloutMock {
  public static final String POST_EXTERNAL_ID = 'a032w000009oRDCAA2';
  public HttpResponse respond(HttpRequest request) {
    HttpResponse response = new HttpResponse();
    response.setHeader('Content-Type', 'application/json');
    response.setStatusCode(200);
    if (request.getMethod().equals('POST')) {
      response.setBody(JSON.serialize(createSampleSubToDoList()));
    } else if (request.getMethod().equals('DELETE')) {
      //unused
    } else if (request.getMethod().equals('PATCH')) {
      response.setBody(JSON.serialize(createSampleSubToDoList()));
    }
    return response;
  }
  private List<Sub_To_Do__c> createSampleSubToDoList() {
    Sub_To_Do__c subToDo = new Sub_To_Do__c(
      Id = POST_EXTERNAL_ID,
      Name = 'test'
    );
    List<Sub_To_Do__c> subToDos = new List<Sub_To_Do__c>();
    subToDos.add(subToDo);
    return subToDos;
  }
}
