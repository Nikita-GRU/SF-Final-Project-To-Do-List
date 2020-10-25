public class CleanOldTodosScheduler implements Schedulable {
        
    public void execute(SchedulableContext context){
        
        String query = 'SELECT Id, Created_Date__c from To_Do__c';
		CleanOldTodosBatch batch = new CleanOldTodosBatch(query); 
		Database.executeBatch(batch);        
    }
}