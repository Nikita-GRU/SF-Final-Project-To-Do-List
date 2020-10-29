trigger CaseTrigger on Case (after insert) {
    List<Case> cases = new List<Case>();
    cases.addAll(Trigger.new);
    CaseTriggerHelper.afterInsert(cases); 
}