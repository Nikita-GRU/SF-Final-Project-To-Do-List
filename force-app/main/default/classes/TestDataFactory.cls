public class TestDataFactory {
    
    public static List<To_Do__c> createOldTodos(Integer numberOfTodos) {
        
        List<To_Do__c> testTodos = new List<To_Do__c>();
        Date created = Date.today().addMonths(-4);
        for (Integer i = 0; i < numberOfTodos; i++) {
            To_Do__c oldTodo = new To_Do__c(Name = 'TestToDo' + i, Created_Date__c = created);
            testTodos.add(oldTodo);
        }
        insert testTodos;
        return testTodos;
    }
}
