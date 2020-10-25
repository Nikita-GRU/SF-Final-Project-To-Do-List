public class CleanOldTodosBatch implements Database.Batchable<SObject>{

    public final String query;
        
    public CleanOldTodosBatch(String query){
        this.query = query;
    }
    
    // Return object that contains the records to use in the batch job (up to 50 million records)
    public Database.QueryLocator start(Database.BatchableContext bc){
        return Database.getQueryLocator(query);
    }

    // Do processing for each chunk of data (up to 2000 records, default 200)
    public void execute(Database.BatchableContext bc, List<To_Do__c> scope){
        
        List<To_Do__c> oldTodos = new List<To_Do__c>();
        
        for(To_Do__c todo : scope){
            
            // check if creation date > 3 month
            if(todo.Created_Date__c.monthsBetween(Date.today()) > 3) {
                oldTodos.add(todo);
            }          
        }
        
        delete oldTodos;
    }
    
    public void finish(Database.BatchableContext bc){
    }
}