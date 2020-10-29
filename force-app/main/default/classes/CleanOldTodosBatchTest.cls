@IsTest
private class CleanOldTodosBatchTest {
    
    static final Integer BATCH_SIZE = 200;
    static final Integer MONTHS = 3;
    static final Date CREATED_DATE = Date.today().addMonths(-(MONTHS + 1));
    static final String TODO_NAME = 'TestToDo';
    static final String STATUS = 'Ended-Succesful';
 
    @testSetup static void setup(){
        
        List<To_Do__c> testTodos = new List<To_Do__c>();
        for (Integer i = 0; i < BATCH_SIZE; i++) {
            To_Do__c oldTodo = new To_Do__c(Name = TODO_NAME + i, 
                                            Created_Date__c = CREATED_DATE,
                                            Status__c = STATUS);
            testTodos.add(oldTodo);
        }
        insert testTodos;
    }
    
    @IsTest static void testCleanOldTodos() {
		
        List<To_Do__c> todos = [SELECT Id FROM To_Do__c]; 
        System.assertEquals(BATCH_SIZE, todos.size());
        
        List<Id> ids = new List<Id>();
        for (To_Do__c todo : todos) {
            ids.add(todo.Id);
        }
        System.assertEquals(todos.size(), ids.size());
         
        Test.startTest();
        String query = 'SELECT Id FROM To_Do__c WHERE Created_Date__c < LAST_N_MONTHS:' + MONTHS + ' AND Status__c = \'' + STATUS + '\'';
		CleanOldTodosBatch batch = new CleanOldTodosBatch(query); 
		Database.executeBatch(batch);
        Test.stopTest();

        System.assertEquals(0, [SELECT COUNT() FROM To_Do__c]);    
    }
}
