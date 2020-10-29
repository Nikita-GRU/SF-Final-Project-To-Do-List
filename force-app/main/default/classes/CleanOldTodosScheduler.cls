public class CleanOldTodosScheduler implements Schedulable {
     
	static final String STATUS_1 = 'Ended- Successful';
    static final String STATUS_2 = 'Ended- Unsuccessful';
       
    public Integer numberOfMonths;
    
    {
        List<Clean_Old_To_Dos_Config__mdt> config = [SELECT Number_Of_Months__c FROM Clean_Old_To_Dos_Config__mdt];
        numberOfMonths = Integer.valueOf(config.get(0).Number_Of_Months__c);    
    } 
    
    public void execute(SchedulableContext context){
        
        //'SELECT Id FROM To_Do__c WHERE Created_Date__c < LAST_N_MONTHS:' + MONTHS + ' AND Status__c = \'' + STATUS + '\'';
        String query = 'SELECT Id FROM To_Do__c WHERE Created_Date__c < LAST_N_MONTHS:' + numberOfMonths + 
            ' AND (Status__c = \'' + STATUS_1 + '\' OR Status__c = \'' + STATUS_2 + '\')' ;
		CleanOldTodosBatch batch = new CleanOldTodosBatch(query); 
		Database.executeBatch(batch);        
    }
}