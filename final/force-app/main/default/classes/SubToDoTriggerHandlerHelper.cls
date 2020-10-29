public with sharing class SubToDoTriggerHandlerHelper {
    public static final String REST_SERVICE_ENDPOINT = 'callout:ToDoRESTEndpoint/services/apexrest/SubToDos/';
  private static final String CONTENT_TYPE_HEADER_KEY = 'Content-Type';
  private static final String GET_METHOD = 'GET';
  private static final String POST_METHOD = 'POST';
  private static final String JSON_CONTENT_TYPE = 'application/json';
  private static final String DELETE_METHOD = 'DELETE';
  private static final String PATCH_METHOD = 'PATCH';
  private static final String PUT_METHOD = 'PUT';

  @Future(callout=true)
  public static void createRemoteSubToDos(String subToDos) {
    Http httpConnection = new Http();
    HttpRequest request = new HttpRequest();
    request.setHeader(CONTENT_TYPE_HEADER_KEY, JSON_CONTENT_TYPE);
    request.setEndpoint(REST_SERVICE_ENDPOINT);
    request.setMethod(POST_METHOD);
    request.setBody(subToDos);
    HttpResponse response = httpConnection.send(request);
    List<Sub_To_Do__c> remoteSubToDos = (List<Sub_To_Do__c>) JSON.deserialize(
      response.getBody(),
      List<Sub_To_Do__c>.class
    );

    List<Id> ids = new List<Id>();
    for (Sub_To_Do__c subToDo : remoteSubToDos) {
      ids.add(subToDo.External_Id__c);
    }
    List<Sub_To_Do__c> subToDosToUpdateExternalId = [SELECT Name,External_Id__c,To_Do__c FROM Sub_To_Do__c WHERE Id IN :ids];
    
    for(Integer i = 0; i<subToDosToUpdateExternalId.size();i++){
        Id externalId = remoteSubToDos.get(i).Id;
        subToDosToUpdateExternalId.get(i).External_Id__c = externalId;
    }

    update subToDosToUpdateExternalId;
  }

  @Future(callout=true)
  public static void updateRemoteSubToDos(String subToDos) {
    Http httpConnection = new Http();
    HttpRequest request = new HttpRequest();
    request.setHeader(CONTENT_TYPE_HEADER_KEY, JSON_CONTENT_TYPE);
    request.setEndpoint(REST_SERVICE_ENDPOINT);
    request.setMethod(PATCH_METHOD);
    request.setBody(subToDos);
    HttpResponse response = httpConnection.send(request);
  }
  @Future(callout=true)
  public static void deleteRemoteSubToDos(String oldSubToDos) {
    Http httpConnection = new Http();
    HttpRequest request = new HttpRequest();
    request.setHeader(CONTENT_TYPE_HEADER_KEY, JSON_CONTENT_TYPE);
    request.setEndpoint(REST_SERVICE_ENDPOINT);
    request.setMethod(DELETE_METHOD);
    request.setBody(oldSubToDos);
    HttpResponse response = httpConnection.send(request);
  }
  public static String getSerializedSubToDos(List<Sub_To_Do__c> newSubToDos) {
    return JSON.serialize(newSubToDos);
  }
 
}

