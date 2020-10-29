//Integration between 2 organizations (Trigger to Insert, Update and Delete operations, future call)
public with sharing class ToDoTriggerHandler {
  public static Boolean isFirstRun = true;
  public void afterInsert(List<To_Do__c> newToDos) {
    if (!System.isBatch()) {
      String jsonToDos = ToDoTriggerHandlerHelper.getSerializedToDos(newToDos);
      ToDoTriggerHandlerHelper.createRemoteToDos(jsonToDos);
    }
  }

  public void afterDelete(List<To_Do__c> oldToDos) {
    if (!System.isBatch()) {
      String jsonToDos = ToDoTriggerHandlerHelper.getSerializedToDos(oldToDos);
      ToDoTriggerHandlerHelper.deleteRemoteToDos(jsonToDos);
    }
  }

  public void beforeUpdate(List<To_Do__c> newToDos, List<To_Do__c> oldToDos) {
    if (!System.isBatch()) { // with System.isFuture check it works too slow =( 
      Boolean isExternalIdUpdate = true;
      for (Integer i = 0; i < newToDos.size(); i++) {
        if (newToDos.get(i).External_Id__c == oldToDos.get(i).External_Id__c) {
          isExternalIdUpdate = false;
        }
      }
      if (!isExternalIdUpdate) {
        String jsonToDos = ToDoTriggerHandlerHelper.getSerializedToDos(
          newToDos
        );
        ToDoTriggerHandlerHelper.updateRemoteToDos(jsonToDos);
      }
    }
  }
}
