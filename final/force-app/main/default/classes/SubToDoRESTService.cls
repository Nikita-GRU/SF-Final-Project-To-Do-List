@RestResource(UrlMapping='/SubToDos/*')
global with sharing class SubToDoRESTService {
    @HttpPost
    global static List<Sub_To_Do__c> createSubToDos() {
      List<Sub_To_Do__c> newSubToDos = new List<Sub_To_Do__c>();
      RestRequest request = RestContext.request;
      List<Sub_To_Do__c> subToDos = (List<Sub_To_Do__c>) JSON.deserialize(
        request.requestBody.toString(),
        List<Sub_To_Do__c>.class
      ); 
      List<String> names = new List<String>();
      for (Sub_To_Do__c subToDo : subToDos) {
        Sub_To_Do__c newSubToDo = new Sub_To_Do__c(
          Name = subToDo.Name,
          Start_Date__c = subToDo.Start_Date__c,
          End_Date__c = subToDo.End_Date__c,
          Status__c = subToDo.Status__c,
          External_Id__c = subToDo.Id,
          To_Do__c = subToDo.To_Do__c
        );
        newSubToDos.add(newSubToDo);
        names.add(subToDo.Name);
      }
      insert newSubToDos;
  
      return [SELECT Id, Name, External_Id__c,To_Do__c FROM Sub_To_Do__c WHERE Name IN :names];
    }
    @HttpPatch
    global static List<Id> updateSubToDosFields() {
      RestRequest request = RestContext.request;
      List<Sub_To_Do__c> subToDos = (List<Sub_To_Do__c>) JSON.deserialize(
        request.requestBody.toString(),
        List<Sub_To_Do__c>.class
      );
      List<Id> subToDosIds = new List<Id>();
      for (Sub_To_Do__c temp : subToDos) {
        subToDosIds.add(temp.External_Id__c);
      }
      List<Sub_To_Do__c> newSubToDos = [
        SELECT
          Id,
          Status__c,
          Start_Date__c,
          End_Date__c,
          External_Id__c,
          To_Do__c
        FROM Sub_To_Do__c
        WHERE Id IN :subToDosIds
      ];
  
      Integer updateCount = 0;
      for (Integer i = 0; i < subToDos.size(); i++) {
        for (Integer j = 0; i < newSubToDos.size(); j++) {
          if (subToDos.get(i).Id == newSubToDos.get(j).External_Id__c) {
            newSubToDos.get(j).Name = subToDos.get(i).Name;
            newSubToDos.get(j).Start_Date__c = subToDos.get(i).Start_Date__c;
            newSubToDos.get(j).End_Date__c = subToDos.get(i).End_Date__c;
            newSubToDos.get(j).Status__c = subToDos.get(i).Status__c;
            newSubToDos.get(j).To_Do__c = subToDos.get(i).To_Do__c;
            break;
          }
        }
      }
      update newSubToDos;
      return subToDosIds;
    }
    @HttpDelete
    global static void deleteSubToDos() {
      RestRequest request = RestContext.request;
      List<Sub_To_Do__c> subToDos = (List<Sub_To_Do__c>) JSON.deserialize(
        request.requestBody.toString(),
        List<Sub_To_Do__c>.class
      );
      List<Id> subToDosIds = new List<Id>();
      for (Sub_To_Do__c temp : subToDos) {
        subToDosIds.add(temp.External_Id__c);
      }
      List<Sub_To_Do__c> newToDos = [SELECT Name FROM Sub_To_Do__c WHERE Id IN :subToDosIds];
      delete newToDos;
    }
  
}
