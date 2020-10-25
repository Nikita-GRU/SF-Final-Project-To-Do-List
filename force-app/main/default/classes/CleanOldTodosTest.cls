@IsTest
private class CleanOldTodosBatchTest {
    
    @IsTest static void testCleanOldTodos() {
		
        // We can test only one execution that's why we create 200 Todo
        List<To_Do__c> todos = TestDataFactory.createOldTodos(200);    
        List<Id> ids = new List<Id>();
        for (To_Do__c todo : todos) {
            ids.add(todo.Id);
        }
        System.assertEquals(ids.size(), 200);

        Test.startTest();
        String query = 'SELECT Id, Created_Date__c from To_Do__c';
		CleanOldTodosBatch batch = new CleanOldTodosBatch(query); 
		Database.executeBatch(batch);
        Test.stopTest();

        System.assertEquals(0, [SELECT COUNT() FROM To_Do__c]);    
    }
}
