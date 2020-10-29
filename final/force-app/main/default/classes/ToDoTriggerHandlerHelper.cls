public with sharing class ToDoTriggerHandlerHelper {
  public static final String REST_SERVICE_ENDPOINT = 'callout:ToDoRESTEndpoint/services/apexrest/ToDos/';
  private static final String CONTENT_TYPE_HEADER_KEY = 'Content-Type';
  private static final String JSON_CONTENT_TYPE = 'application/json';
  private static final String GET_METHOD = 'GET';
  private static final String POST_METHOD = 'POST';
  private static final String DELETE_METHOD = 'DELETE';
  private static final String PATCH_METHOD = 'PATCH';
  private static final String PUT_METHOD = 'PUT';

  @Future(callout=true)
  public static void createRemoteToDos(String toDos) {
    Http httpConnection = new Http();
    HttpRequest request = new HttpRequest();
    request.setHeader(CONTENT_TYPE_HEADER_KEY, JSON_CONTENT_TYPE);
    request.setEndpoint(REST_SERVICE_ENDPOINT);
    request.setMethod(POST_METHOD);
    request.setBody(toDos);
    System.debug(request.getBody());
    HttpResponse response = httpConnection.send(request);
    System.debug(response.getBody());
    List<To_Do__c> remoteToDos = (List<To_Do__c>) JSON.deserialize(
      response.getBody(),
      List<To_Do__c>.class
    );
    List<Id> ids = new List<Id>();
    for (To_Do__c toDo : remoteToDos) {
      ids.add(toDo.External_Id__c);
    }
    List<To_Do__c> toDosToUpdateExternalId = [
      SELECT Name, External_Id__c
      FROM To_Do__c
      WHERE Id IN :ids
    ];
      
    for (Integer i = 0; i < toDosToUpdateExternalId.size(); i++) {
      Id externalId = remoteToDos.get(i).Id;
      toDosToUpdateExternalId.get(i).External_Id__c = externalId;
    }
    update toDosToUpdateExternalId;
  }

  @Future(callout=true)
  public static void updateRemoteToDos(String toDos) {
    Http httpConnection = new Http();
    HttpRequest request = new HttpRequest();
    request.setHeader(CONTENT_TYPE_HEADER_KEY, JSON_CONTENT_TYPE);
    request.setEndpoint(REST_SERVICE_ENDPOINT);
    request.setMethod(PATCH_METHOD);
    request.setBody(toDos);
    HttpResponse response = httpConnection.send(request);
  }
  @Future(callout=true)
  public static void deleteRemoteToDos(String oldToDos) {
    Http httpConnection = new Http();
    HttpRequest request = new HttpRequest();
    request.setHeader(CONTENT_TYPE_HEADER_KEY, JSON_CONTENT_TYPE);
    request.setEndpoint(REST_SERVICE_ENDPOINT);
    request.setMethod(DELETE_METHOD);
    request.setBody(oldToDos);
    HttpResponse response = httpConnection.send(request);
  }
  
  public static String getSerializedToDos(List<To_Do__c> newToDos) {
    return JSON.serialize(newToDos);
  }
}