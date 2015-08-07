global with sharing class ScheduledBatchClassEvents implements Schedulable{ 
	
	Integer intervalMinutes;
	
    public ScheduledBatchClassEvents(Integer intervalMinutes) {
        this.intervalMinutes = intervalMinutes;
    }
    
    public void execute(SchedulableContext sc) { 
        // Re-schedule ourself to run again in "intervalMinutes" time
        DateTime now  = DateTime.now();
        DateTime nextRunTime = now.addMinutes(intervalMinutes);
        String cronString = '' + nextRunTime.second() + ' ' + nextRunTime.minute() + ' ' + 
            nextRunTime.hour() + ' ' + nextRunTime.day() + ' ' + 
            nextRunTime.month() + ' ? ' + nextRunTime.year(); 
        System.schedule(ScheduledBatchClassEvents.class.getName() + '-' + now.format(), cronString, new ScheduledBatchClassEvents(3));
        // Abort the current job
        Id jobId = sc.getTriggerId();
        System.abortJob(jobId);     
        // Launch a batch job or call a future method to do the actual work
        Database.executeBatch(new BatchClassEvents());
    }
    

}