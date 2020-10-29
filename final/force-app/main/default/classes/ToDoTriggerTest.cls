@IsTest
private class ToDoTriggerTest {
  @IsTest
  static void afterInsertTest() {
    Test.setMock(HttpCalloutMock.class, new RESTClientMock());
    To_Do__c toDo = new To_Do__c(Name = 'test');
    Test.startTest();
    insert (toDo);
    Test.stopTest();
    
    To_Do__c resultToDo = [
      SELECT Id, External_Id__c
      FROM To_Do__c
      WHERE Name = 'test'
      LIMIT 1
    ];
    System.assert(resultToDo!=null);
    System.assert(resultToDo.External_Id__c != '');
  }
  @IsTest
  static void afterUpdateTest() {
    Test.setMock(HttpCalloutMock.class, new RESTClientMock());
    To_Do__c toDo = new To_Do__c(Name = 'test', Start_Date__c = DateTime.now());
    Test.startTest();
    insert (toDo);
    todo.Description__c = 'test description';
    update (toDo);
    Test.stopTest();
    To_Do__c resultToDo = [
      SELECT Id, External_Id__c,Description__c
      FROM To_Do__c
      WHERE Name = 'test'
      LIMIT 1
    ];
    System.assertEquals(
        'test description',
      resultToDo.Description__c
    );
  }
  @IsTest
  static void afterDeleteTest() {
    Test.setMock(HttpCalloutMock.class, new RESTClientMock());
    To_Do__c toDo = new To_Do__c(Name = 'test', Start_Date__c = DateTime.now());
    Test.startTest();
    insert (toDo);
    delete (toDo);
    Test.stopTest();
  List<To_Do__c> resultToDos = [
      SELECT Id, External_Id__c,Description__c
      FROM To_Do__c
      WHERE Name = 'test'
    ];
    System.assert(resultToDos.isEmpty());
}


}
