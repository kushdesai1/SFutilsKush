public class PtTriggerHelper extends PtEventHandler {
    public override void bulkAfter() {
        list<Ecommerece__e> Tnew = (List<Ecommerece__e>) Trigger.new;
        if (Tnew != null && !Tnew.isEmpty()) {
            createtask(Tnew);
        }
    }

    public override void afterInsert(SObject so) {
        Ecommerece__e item = (Ecommerece__e) so;
        Contact con = new Contact();
        con.LastName = item.Product_Name__c != null ? item.Product_Name__c : 'DefaultName';
        insert con;
    }

public static void createtask(List<Ecommerece__e> ecommEvents){

        List<Task> tasksToInsert = new List<Task>();
    try{
        for (Ecommerece__e event : ecommEvents) {
            Task task = new Task();
            task.Subject = 'Follow up on ' + event.Product_Name__c;
            task.OwnerId = '005gK0000059q4YQAQ'; 
            task.ActivityDate = Date.today().addDays(7); 
            task.Status = 'Not Started';
            task.Priority = 'Normal';
            tasksToInsert.add(task);
        }
    }
    catch (Exception e) { 
        System.debug('Error creating tasks: ' + e.getMessage());
    }
        if (!tasksToInsert.isEmpty()) {
            insert tasksToInsert;
            createoppotunity(ecommEvents);
        }    
    }

public static void createoppotunity(List<Ecommerece__e> ecommEvents){
            List<Opportunity> oppToInsert = new List<Opportunity>();
            list<string> productnames = new List<string>();
            list<string> Emails = new List<string>();
    try{
        for (Ecommerece__e event : ecommEvents) {
            Opportunity opp = new Opportunity();
            opp.Name = 'Ecommercee product' + event.Product_Name__c;
            opp.OwnerId = '005gK0000059q4YQAQ';//UserInfo.getUserId(); 
            opp.CloseDate = Date.today().addDays(1); 
            opp.StageName = 'Prospecting';
            opp.leadsource = 'Web';
            productnames.add(event.Product_Name__c);
            Emails.add(event.Email__c);
            oppToInsert.add(opp);
        }
    }
    catch (Exception e) { 
        System.debug('Error creating tasks: ' + e.getMessage());
    }
        if (!oppToInsert.isEmpty()) {      
        insert oppToInsert;
            if (!oppToInsert.isEmpty()) {
                insert oppToInsert;
                EmailSchedular.sendemail(Emails, productnames);
            }
        }
   } 

   
}
