trigger SubToDoTrigger on Sub_To_Do__c (before update, after insert, after delete) {
    SubToDoTriggerHandler handler = new SubToDoTriggerHandler();
    if (Trigger.isInsert && Trigger.isAfter) {
      handler.afterInsert(Trigger.new);
    } else if (Trigger.isUpdate && Trigger.isBefore) {
      handler.beforeUpdate(Trigger.new, Trigger.old);
    } else if (Trigger.isDelete && Trigger.isAfter) {
      handler.afterDelete(Trigger.old);
    }
  }