public with sharing class SubToDoTriggerHandler {
    public void afterInsert(List<Sub_To_Do__c> newSubToDos) {
        String jsonSubToDos = SubToDoTriggerHandlerHelper.getSerializedSubToDos(newSubToDos);
        SubToDoTriggerHandlerHelper.createRemoteSubToDos(jsonSubToDos);
      }
     
      public void afterUpdate(List<Sub_To_Do__c> newSubToDos) {
        String jsonSubToDos = SubToDoTriggerHandlerHelper.getSerializedSubToDos(newSubToDos);
        SubToDoTriggerHandlerHelper.updateRemoteSubToDos(jsonSubToDos);
      }
    
      
      public void afterDelete(List<Sub_To_Do__c> oldSubToDos) {
        String jsonSubToDos = SubToDoTriggerHandlerHelper.getSerializedSubToDos(oldSubToDos);
        SubToDoTriggerHandlerHelper.deleteRemoteSubToDos(jsonSubToawaDos);
      }
    
      public void afterUndelete(List<Sub_To_Do__c> newSubToDos) {
        String jsonSubToDos = SubToDoTriggerHandlerHelper.getSerializedSubToDos(newSubToDos);
        SubToDoTriggerHandlerHelper.createRemoteSubToDos(jsonSubToDos);}
        
      
      public void beforeInsert(List<Sub_To_Do__c> newSubToDos) {}
      public void beforeDelete(List<Sub_To_Do__c> oldSubToDos,Map<Id, Sub_To_Do__c> oldSubToDosMap) {}
      public void beforeUpdate(Map<Id, Sub_To_Do__c> oldSubToDosMap, Map<Id, Sub_To_Do__c> newSubToDosMap) {}
}
