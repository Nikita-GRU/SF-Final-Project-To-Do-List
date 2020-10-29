public class CleanOldTodosBatch implements Database.Batchable<SObject>{

    public final String query;
        
    public CleanOldTodosBatch(String query){
        this.query = query;
    }
    
    public Database.QueryLocator start(Database.BatchableContext bc){
        return Database.getQueryLocator(query);
    }

    public void execute(Database.BatchableContext bc, List<To_Do__c> scope){
                
        if(scope.size() > 0 ){
            delete scope;
        }
    }
    
    public void finish(Database.BatchableContext bc){
    }
}