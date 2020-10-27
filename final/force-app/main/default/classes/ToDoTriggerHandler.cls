//Integration between 2 organizations (Trigger to Insert, Update and Delete operations, future call)
public with sharing class ToDoTriggerHandler {
  public void afterInsert(List<To_Do__c> newToDos) {
    String jsonToDos = ToDoTriggerHandlerHelper.getSerializedToDos(newToDos);
    ToDoTriggerHandlerHelper.createRemoteToDos(jsonToDos);
  }

  public void afterUpdate(List<To_Do__c> newToDos, List<To_Do__c> oldToDos) {
  }

  public void afterDelete(List<To_Do__c> oldToDos) {
    String jsonToDos = ToDoTriggerHandlerHelper.getSerializedToDos(oldToDos);
    ToDoTriggerHandlerHelper.deleteRemoteToDos(jsonToDos);
  }

  public void afterUndelete(List<To_Do__c> newToDos) {
    String jsonToDos = ToDoTriggerHandlerHelper.getSerializedToDos(newToDos);
    ToDoTriggerHandlerHelper.createRemoteToDos(jsonToDos);
  }

  public void beforeInsert(List<To_Do__c> newToDos) {
  }
  public void beforeDelete(
    List<To_Do__c> oldToDos,
    Map<Id, To_Do__c> oldToDosMap
  ) {
  }

  public void beforeUpdate(List<To_Do__c> newToDos, List<To_Do__c> oldToDos) {
    Boolean isExternalIdUpdate = true;
    for (Integer i=0; i < newToDos.size(); i++) {
      if (newToDos.get(i).External_Id__c == oldToDos.get(i).External_Id__c) {
        isExternalIdUpdate = false;
      }
    }
    if (!isExternalIdUpdate) {
      String jsonToDos = ToDoTriggerHandlerHelper.getSerializedToDos(newToDos);
      ToDoTriggerHandlerHelper.updateRemoteToDos(jsonToDos);
    }
  }
}
