public with sharing class SubToDoTriggerHandler {
  public void afterInsert(List<Sub_To_Do__c> newSubToDos) {
    if (!System.isBatch()) {
      String jsonSubToDos = SubToDoTriggerHandlerHelper.getSerializedSubToDos(
        newSubToDos
      );
      SubToDoTriggerHandlerHelper.createRemoteSubToDos(jsonSubToDos);
    }
  }
  public void afterDelete(List<Sub_To_Do__c> oldSubToDos) {
    if (!System.isBatch()) {
      String jsonSubToDos = SubToDoTriggerHandlerHelper.getSerializedSubToDos(
        oldSubToDos
      );
      SubToDoTriggerHandlerHelper.deleteRemoteSubToDos(jsonSubToDos);
    }
  }
  public void beforeUpdate(
    List<Sub_To_Do__c> newSubToDos,
    List<Sub_To_Do__c> oldSubToDos
  ) {
    if (!System.isBatch()) {
      Boolean isExternalIdUpdate = true;
      for (Integer i = 0; i < newSubToDos.size(); i++) {
        if (
          newSubToDos.get(i).External_Id__c == oldSubToDos.get(i).External_Id__c
        ) {
          isExternalIdUpdate = false;
        }
      }
      if (!isExternalIdUpdate) {
        String jsonSubToDos = SubToDoTriggerHandlerHelper.getSerializedSubToDos(
          newSubToDos
        );
        SubToDoTriggerHandlerHelper.updateRemoteSubToDos(jsonSubToDos);
      }
    }
  }
}
