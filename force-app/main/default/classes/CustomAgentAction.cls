public with sharing class CustomAgentAction {
    @InvocableMethod(
        label='Get Account Info' 
        description='Returns account details for a given ID'
        category='Agent Actions'
    )
    public static List<Result> execute(List<Request> requests) {
        List<Result> results = new List<Result>();
        
        for (Request req : requests) {
            Result res = new Result();
            // Your logic here (e.g., query Salesforce data)
            Account acc = [SELECT Name, Industry FROM Account WHERE Id = :req.accountId LIMIT 1];
            
            // Populate result
            res.accountName = acc.Name;
            res.industry = acc.Industry;
            results.add(res);
        }
        return results;
    }


    public class Request {
        @InvocableVariable(label='Account ID' required=true)
        public Id accountId;
    }
    
    public class Result {
        @InvocableVariable(label='Account Name')
        public String accountName;
        
        @InvocableVariable(label='Industry')
        public String industry;
    }
}