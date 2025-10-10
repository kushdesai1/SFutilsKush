public class EmailSchedular implements Schedulable {
 
    public List<String> toAddresses;
    public String subject;
    public String body;

    public EmailSchedular(List<String> toAddresses, String subject, String body) {
        this.toAddresses = toAddresses;
        this.subject = subject;
        this.body = body;
    }
   
    public void execute(SchedulableContext sc) {
        sendSimpleEmail(toAddresses, subject, body);
    }
  
    public static Boolean sendSimpleEmail(List<String> toAddresses, String subject, String body){
        try {
            Messaging.SingleEmailMessage email = new Messaging.SingleEmailMessage();
            email.setToAddresses(toAddresses);
            email.setSubject(subject);
            email.setPlainTextBody(body);
            
            Messaging.SendEmailResult[] results = Messaging.sendEmail(new Messaging.SingleEmailMessage[]{email});
            
            return results[0].isSuccess();
        } catch (Exception e) {
            System.debug('Error sending email: ' + e.getMessage());
            return false;
        }
    }
    public static String getCronAfterMinutes(Integer minutesFromNow) {

        Datetime targetTime = System.now().addMinutes(minutesFromNow);
        Integer sec = targetTime.second();
        Integer min = targetTime.minute();
        Integer hour = targetTime.hour();
        Integer day = targetTime.day();
        Integer month = targetTime.month();
        Integer year = targetTime.year();

        String cron = sec + ' ' + min + ' ' + hour + ' ' + day + ' ' + month + ' ? ' + year;
        return cron;
    }
    public static void sendemail(List<String> toAddresses, list<string> Discounted){
        String subject = 'It got cheaper!';
        String body = 'The following products went for a discount: ' + String.join(Discounted, ', ') + '. Check them out!';
        
        EmailSchedular emailSchedular = new EmailSchedular(toAddresses, subject, body);
        string scheduledTime = getCronAfterMinutes(5);
        System.schedule('Product Update Email', scheduledTime, emailSchedular);
    }
}

