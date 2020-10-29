@IsTest
private class CleanOldTodosSchedulerTest {
    
    static final String JOB_NAME = 'testCleanOldTodosScheduler';
    // This test runs a scheduled job at midnight Oct. 30th 2030
    static final String CRON_EXP = '0 0 0 30 10 ? 2030';
    
	@IsTest static void test(){
        
		Test.startTest();
        
		// Schedule the test job
    	String jobId = System.schedule(JOB_NAME, CRON_EXP, new CleanOldTodosScheduler());
        
        // Get the information from the CronTrigger API object
        CronTrigger ct = [SELECT Id, CronExpression, TimesTriggered, 
        NextFireTime FROM CronTrigger WHERE id = :jobId];
        
        // Verify the expressions are the same
        System.assertEquals(CRON_EXP, ct.CronExpression);
        
        // Verify the job has not run
      	System.assertEquals(0, ct.TimesTriggered);
 
        // Verify the next time the job will run
        System.assertEquals('2030-10-30 00:00:00', 
        String.valueOf(ct.NextFireTime));
         
   		Test.stopTest();
    }
}
