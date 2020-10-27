public with sharing class SubToDoTriggerHandlerHelper {
    public static final String REST_SERVICE_ENDPOINT = 'https://wise-bear-t0v9lv-dev-ed.my.salesforce.com/services/apexrest/SubToDos/';
  private static final String BEARER_TOKEN_TYPE = 'Bearer ';
  private static final String AUTHORIZATION_HEADER_KEY = 'Authorization';
  private static final String CONTENT_TYPE_HEADER_KEY = 'Content-Type';
  private static final String GET_METHOD = 'GET';
  private static final String POST_METHOD = 'POST';
  private static final String ACCESS_TOKEN_KEY = 'access_token';
  public static final String ACCESS_TOKEN_ENDPOINT = 'https://login.salesforce.com/services/oauth2/token?grant_type=password&client_id=3MVG9n_HvETGhr3Ca0T9vrY0B1ZV3PSVCfwmBWgTl3A.PaZba7CRE2g8ChhId3FaiH12kenxa4O6JFx1WCwFB&client_secret=241CE586D835C63AAF3FDD15F9F141DFAF7EC907D5B7BE5A95E74DAD0A740BDA&username=mikitka334@wise-bear-t0v9lv.com&password=nik2486976PdMZehZg1x2jOgvvI893J7F9W';
  private static final String JSON_CONTENT_TYPE = 'application/json';
  private static final String DELETE_METHOD = 'DELETE';
  private static final String PATCH_METHOD = 'PATCH';
  private static final String PUT_METHOD = 'PUT';

  @Future(callout=true)
  public static void createRemoteSubToDos(String subToDos) {
    Http httpConnection = new Http();
    HttpRequest request = new HttpRequest();
    String accessToken = getAccessToken();
    request.setHeader(AUTHORIZATION_HEADER_KEY, accessToken);
    request.setHeader(CONTENT_TYPE_HEADER_KEY, JSON_CONTENT_TYPE);
    request.setEndpoint(REST_SERVICE_ENDPOINT);
    request.setMethod(POST_METHOD);
    request.setBody(subToDos);
    HttpResponse response = httpConnection.send(request);
    List<Sub_To_Do__c> remoteSubToDos = (List<Sub_To_Do__c>) JSON.deserialize(
      response.getBody(),
      List<Sub_To_Do__c>.class
    );

    List<String> names = new List<String>();
    for (Sub_To_Do__c toDo : remoteSubToDos) {
        names.add(toDo.Name);
      }
    List<Sub_To_Do__c> SubToDosToUpdateExternalId = [SELECT Name,External_Id__c,To_Do__c FROM Sub_To_Do__c WHERE Name IN :names];
    
    for(Integer i = 0; i<remoteSubToDos.size();i++){
        Id externalId = remoteSubToDos.get(i).Id;
        Id externalToDo = remoteSubToDos.get(i).To_Do__c;
        SubToDosToUpdateExternalId.get(i).External_Id__c = externalId;
        SubToDosToUpdateExternalId.get(i).To_Do__c = externalToDo;

    }

    update SubToDosToUpdateExternalId;
  }

  @Future(callout=true)
  public static void updateRemoteSubToDos(String subToDos) {
    Http httpConnection = new Http();
    HttpRequest request = new HttpRequest();
    String accessToken = getAccessToken();
    request.setHeader(AUTHORIZATION_HEADER_KEY, accessToken);
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
    String accessToken = getAccessToken();
    request.setHeader(AUTHORIZATION_HEADER_KEY, accessToken);
    request.setHeader(CONTENT_TYPE_HEADER_KEY, JSON_CONTENT_TYPE);
    request.setEndpoint(REST_SERVICE_ENDPOINT);
    request.setMethod(DELETE_METHOD);
    request.setBody(oldSubToDos);
    HttpResponse response = httpConnection.send(request);
  }
  public static String getSerializedSubToDos(List<Sub_To_Do__c> newSubToDos) {
    return JSON.serialize(newSubToDos);
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

