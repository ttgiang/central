import java.util.Date;
import org.quartz.Scheduler;
import org.quartz.SchedulerException;
import org.quartz.impl.StdSchedulerFactory;
import org.quartz.JobDetail;
import org.quartz.Trigger;
import org.quartz.SimpleTrigger;

public class QuartzTest {

	public QuartzTest ()throws Exception {

		try {
			// Grab the Scheduler instance from the Factory
			Scheduler scheduler = StdSchedulerFactory.getDefaultScheduler();

			// and start it off
			scheduler.start();

			// Define job instance
			JobDetail job = new JobDetail("job1", null, HelloJob.class);

			// Define a Trigger that will fire "now"
			Trigger trigger = new SimpleTrigger("trigger1", null, new Date());

			// Schedule the job with the trigger
			scheduler.scheduleJob(job, trigger);

			scheduler.shutdown();
		}
		catch (SchedulerException se) {
			se.printStackTrace();
		}
	}

	public static void main(String[] args) {
		try{
			new QuartzTest();
		}
		catch(Exception e){}
	}
}
