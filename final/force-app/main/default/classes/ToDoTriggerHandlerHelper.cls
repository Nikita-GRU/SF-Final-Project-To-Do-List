public with sharing class ToDoTriggerHandlerHelper {
  public static final String REST_SERVICE_ENDPOINT = 'callout:ToDoRESTEndpoint';
  private static final String BEARER_TOKEN_TYPE = 'Bearer ';
  private static final String AUTHORIZATION_HEADER_KEY = 'Authorization';
  private static final String CONTENT_TYPE_HEADER_KEY = 'Content-Type';
  private static final String GET_METHOD = 'GET';
  private static final String POST_METHOD = 'POST';
  private static final String ACCESS_TOKEN_KEY = 'access_token';
    private static final String JSON_CONTENT_TYPE = 'application/json';
  private static final String DELETE_METHOD = 'DELETE';
  private static final String PATCH_METHOD = 'PATCH';
  private static final String PUT_METHOD = 'PUT';

 @Future(callout=true)
  public static void createRemoteToDos(String toDos) {
    Http httpConnection = new Http();
    HttpRequest request = new HttpRequest();
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
    List<String> names = new List<String>();
    for (To_Do__c toDo : remoteToDos) {
      names.add(toDo.Name);
    }
    List<To_Do__c> toDosToUpdateExternalId = [
      SELECT Name, External_Id__c
      FROM To_Do__c
      WHERE Name IN :names
    ];

    for (Integer i = 0; i < remoteToDos.size(); i++) {
      Id externalId = remoteToDos.get(i).Id;
      toDosToUpdateExternalId.get(i).External_Id__c = externalId;
    }
    update toDosToUpdateExternalId;
  }

  @Future(callout=true)
  public static void updateRemoteToDos(String toDos) {
    Http httpConnection = new Http();
    HttpRequest request = new HttpRequest();
    String accessToken = getAccessToken();
    request.setHeader(AUTHORIZATION_HEADER_KEY, accessToken);
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
    String accessToken = getAccessToken();
    request.setHeader(AUTHORIZATION_HEADER_KEY, accessToken);
    request.setHeader(CONTENT_TYPE_HEADER_KEY, JSON_CONTENT_TYPE);
    request.setEndpoint(REST_SERVICE_ENDPOINT);
    request.setMethod(DELETE_METHOD);
    request.setBody(oldToDos);
    HttpResponse response = httpConnection.send(request);
  }
  public static String getSerializedToDos(List<To_Do__c> newToDos) {
    return JSON.serialize(newToDos);
  }
  private static String getAccessToken() {
    Http httpConnection = new Http();
    HttpRequest request = new HttpRequest();
    request.setEndpoint(ACCESS_TOKEN_ENDPOINT);
    request.setMethod(POST_METHOD);
    HttpResponse response = httpConnection.send(request);
    Map<String, Object> result = (Map<String, Object>) JSON.deserializeUntyped(
      response.getBody()
    );
    String token = (String) result.get(ACCESS_TOKEN_KEY);
    return BEARER_TOKEN_TYPE + token;
  }
}