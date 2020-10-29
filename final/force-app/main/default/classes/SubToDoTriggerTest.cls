@IsTest
private class SubToDoTriggerTest {
      @IsTest
      static void afterInsertTest() {
        Test.setMock(HttpCalloutMock.class, new SubToDoRESTClientMock());
        Sub_To_Do__c subToDo = new Sub_To_Do__c(Name = 'test');
        To_Do__c toDo = new To_Do__c(Name = 'test');
        Test.startTest();
        insert(toDo);
        subToDo.To_Do__c = toDo.Id;
        insert (subToDo);
        Test.stopTest();
        
        Sub_To_Do__c resultSubToDo = [
          SELECT Id, External_Id__c
          FROM Sub_To_Do__c
          WHERE Name = 'test'
          LIMIT 1
        ];
        System.assert(resultSubToDo!=null);
        System.assert(resultSubToDo.External_Id__c != '');
      }
      @IsTest
      static void afterUpdateTest() {
        Test.setMock(HttpCalloutMock.class, new SubToDoRESTClientMock());
        To_Do__c toDo = new To_Do__c(Name = 'test');
        Sub_To_Do__c subToDo = new Sub_To_Do__c(Name = 'test');
        Test.startTest();
        insert(toDo);
        subToDo.To_Do__c = toDo.Id;
        insert (subToDo);
        subToDo.Description__c = 'test description';
        update (subToDo);
        Test.stopTest();
        Sub_To_Do__c resultSubToDo = [
          SELECT Id, External_Id__c,Description__c
          FROM Sub_To_Do__c
          WHERE Name = 'test'
          LIMIT 1
        ];
        System.assertEquals(
            'test description',
          resultSubToDo.Description__c
        );
      }
      @IsTest
      static void afterDeleteTest() {
        Test.setMock(HttpCalloutMock.class, new SubToDoRESTClientMock());
        To_Do__c toDo = new To_Do__c(Name = 'test');
        Sub_To_Do__c subToDo = new Sub_To_Do__c(Name = 'test');
        Test.startTest();
        insert(toDo);
        subToDo.To_Do__c = toDo.Id;
        insert (subToDo);
        delete (subToDo);
        Test.stopTest();
      List<Sub_To_Do__c> resultSubToDo = [
          SELECT Id, External_Id__c,Description__c
          FROM Sub_To_Do__c
          WHERE Name = 'test'
        ];
        System.assert(resultSubToDo.isEmpty());
    }
    
}
