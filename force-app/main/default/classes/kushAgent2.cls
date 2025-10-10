public with sharing class kushAgent2 {
    @InvocableMethod(
        label='complaints from status' 
        description='Returns all complaints for given status'
        category='Agent Actions'
    )

    public static list<Result> complaintstatus(List<Request> staus){
        list<Result> results = new list<Result>();
        
        for(Request comp:staus)
        {
        List<Complaint__c> toadd = [SELECT Id, Name, DIvision__c, Status__c FROM Complaint__c WHERE Status__c LIKE :('%' + comp.status + '%')];
        Result res = new Result();
        res.finallist = toadd;
        results.add(res);
        }

        return results;
    }
    public class Request {
        @InvocableVariable(label='status' required=true)
        public string status;
    }

    public class Result {
        @InvocableVariable(label='COMPLAINTS')
        public list<complaint__c> finallist;
    }
}