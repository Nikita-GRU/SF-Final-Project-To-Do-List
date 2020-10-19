//Integration between 2 organizations (Trigger to Insert, Update and Delete operations, future call)
public with sharing class ToDoTriggerHandler {
    public void beforeInsert(List<To_Do__c> newToDos) {}
    public void afterInsert(List<To_Do__c> newToDos) {}
    public void beforeUpdate(Map<Id, To_Do__c> oldToDosMap, Map<Id, To_Do__c> newToDosMap) {}
    public void afterUpdate(Map<Id, To_Do__c> oldToDosMap, Map<Id, To_Do__c> newToDosMap) {}
    public void beforeDelete(List<To_Do__c> oldToDos, Map<Id, To_Do__c> oldToDosMap) {}
    public void afterDelete(List<To_Do__c> oldToDos, Map<Id, To_Do__c> oldToDosMap) {}
    public void afterUndelete(List<To_Do__c> newToDos) {}

}
