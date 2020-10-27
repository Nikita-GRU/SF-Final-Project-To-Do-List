//Integration between 2 organizations (Trigger to Insert, Update and Delete operations, future call)
trigger toDoTrigger on To_Do__c(
  before insert,
  before update,
  before delete,
  after insert,
  after update,
  after delete,
  after undelete
) {
  
  ToDoTriggerHandler handler = new ToDoTriggerHandler();
  if (Trigger.isInsert && Trigger.isBefore) {
    handler.beforeInsert(Trigger.new);
  } else if (Trigger.isUpdate && Trigger.isAfter) {
    handler.afterUpdate(Trigger.new,Trigger.old);
  } else if (Trigger.isInsert && Trigger.isAfter) {
    handler.afterInsert(Trigger.new);
  } else if (Trigger.isUpdate && Trigger.isBefore) {
    handler.beforeUpdate(Trigger.new,Trigger.old);
  } else if (Trigger.isDelete && Trigger.isBefore) {
    handler.beforeDelete(Trigger.old, Trigger.oldMap);
  } else if (Trigger.isDelete && Trigger.isAfter) {
    handler.afterDelete(Trigger.old);
  } else if (Trigger.isUndelete && Trigger.isAfter) {
    handler.afterUndelete(Trigger.new);
  }
}
