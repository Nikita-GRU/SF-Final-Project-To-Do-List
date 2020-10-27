trigger SubToDoTrigger on Sub_To_Do__c (
    before insert,
    before update,
    before delete,
    after insert,
    after update,
    after delete,
    after undelete
  ) {
    SubToDoTriggerHandler handler = new SubToDoTriggerHandler();
    if (Trigger.isInsert && Trigger.isBefore) {
      handler.beforeInsert(Trigger.new);
    } else if (Trigger.isInsert && Trigger.isAfter) {
      handler.afterInsert(Trigger.new);
    } else if (Trigger.isUpdate && Trigger.isBefore) {
      handler.beforeUpdate(Trigger.oldMap, Trigger.newMap);
    } else if (Trigger.isUpdate && Trigger.isAfter) {
      handler.afterUpdate(Trigger.new);
    } else if (Trigger.isDelete && Trigger.isBefore) {
      handler.beforeDelete(Trigger.old, Trigger.oldMap);
    } else if (Trigger.isDelete && Trigger.isAfter) {
      handler.afterDelete(Trigger.old);
    } else if (Trigger.isUndelete && Trigger.isAfter) {
      handler.afterUndelete(Trigger.new);
    }
  }