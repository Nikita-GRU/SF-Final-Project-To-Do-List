//Integration between 2 organizations (Trigger to Insert, Update and Delete operations, future call)
trigger toDoTrigger on To_Do__c(before update, after insert, after delete) {
  ToDoTriggerHandler handler = new ToDoTriggerHandler();
  if (Trigger.isInsert && Trigger.isAfter) {
    handler.afterInsert(Trigger.new);
  } else if (Trigger.isUpdate && Trigger.isBefore) {
    handler.beforeUpdate(Trigger.new, Trigger.old);
  } else if (Trigger.isDelete && Trigger.isAfter) {
    handler.afterDelete(Trigger.old);
  }
}
