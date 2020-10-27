@RestResource(UrlMapping='/ToDos/*')
global with sharing class ToDoRESTService {
  @HttpPost
  global static List<To_Do__c> createToDos() {
    List<To_Do__c> newToDos = new List<To_Do__c>();
    RestRequest request = RestContext.request;
    List<To_Do__c> toDos = (List<To_Do__c>) JSON.deserialize(
      request.requestBody.toString(),
      List<To_Do__c>.class
    ); 
    List<String> names = new List<String>();
    for (To_Do__c toDo : toDos) {
      To_Do__c newToDo = new To_Do__c(
        Name = toDo.Name,
        Start_Date__c = toDo.Start_Date__c,
        End_Date__c = toDo.End_Date__c,
        Status__c = toDo.Status__c,
        Created_Date__c = toDo.Created_Date__c,
        External_Id__c = toDo.Id
      );
      newToDos.add(newToDo);
      names.add(toDo.Name);
    }
    insert newToDos;

    return [SELECT Id, Name, External_Id__c FROM To_Do__c WHERE Name IN :names];
  }
  @HttpPatch
  global static List<Id> updateToDoFields() {
    RestRequest request = RestContext.request;
    List<To_Do__c> toDos = (List<To_Do__c>) JSON.deserialize(
      request.requestBody.toString(),
      List<To_Do__c>.class
    );
    List<Id> toDosIds = new List<Id>();
    for (To_Do__c temp : toDos) {
      toDosIds.add(temp.External_Id__c);
    }
    List<To_Do__c> newToDos = [
      SELECT
        Id,
        Status__c,
        Start_Date__c,
        End_Date__c,
        Created_Date__c,
        External_Id__c
      FROM To_Do__c
      WHERE Id IN :toDosIds
    ];

    Integer updateCount = 0;
    for (Integer i = 0; i < toDos.size(); i++) {
      for (Integer j = 0; i < newToDos.size(); j++) {
        if (toDos.get(i).Id == newToDos.get(j).External_Id__c) {
          newToDos.get(j).Name = toDos.get(i).Name;
          newToDos.get(j).Start_Date__c = toDos.get(i).Start_Date__c;
          newToDos.get(j).End_Date__c = toDos.get(i).End_Date__c;
          newToDos.get(j).Status__c = toDos.get(i).Status__c;
          newToDos.get(j).Created_Date__c = toDos.get(i).Created_Date__c;
          break;
        }
      }
    }
    update newToDos;
    return toDosIds;
  }
  @HttpDelete
  global static void deleteToDos() {
    RestRequest request = RestContext.request;
    List<To_Do__c> toDos = (List<To_Do__c>) JSON.deserialize(
      request.requestBody.toString(),
      List<To_Do__c>.class
    );
    List<Id> toDosIds = new List<Id>();
    for (To_Do__c temp : toDos) {
      toDosIds.add(temp.External_Id__c);
    }
    List<To_Do__c> newToDos = [SELECT Name FROM To_Do__c WHERE Id IN :toDosIds];
    delete newToDos;
  }

}
