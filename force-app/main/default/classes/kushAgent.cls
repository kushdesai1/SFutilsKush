public with sharing class kushAgent {
    @InvocableMethod(
        label='Get all complaints from product name' 
        description='Returns all complaints for that product details for a given product'
        category='Agent Actions'
    )

    public static list<Result> complaints(List<Request> pname){
        list<Result> results = new list<Result>();
        
        for(Request comp:pname)
        {
        List<Complaint__c> toadd = [SELECT Id, Name FROM Complaint__c WHERE Product__r.Name LIKE :('%' + comp.productname + '%')];
        Result res = new Result();
        res.finallist = toadd;
        results.add(res);
        }

        return results;
    }
    public class Request {
        @InvocableVariable(label='product name' required=true)
        public string productname;
    }

    public class Result {
        @InvocableVariable(label='COMPLAINTS')
        public list<complaint__c> finallist;
    }
}