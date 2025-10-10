public with sharing class EmpolyessAgentCaseAction {

        @InvocableMethod(
        label='create case from email and remarks' 
        description='Creates case from email and remarks'
        category='Agent Actions'
    )
    public static list<Result> createleads(List<Request> req){
        case c = new case();
        string results = 'case created successfully';
        for(Request r:req)
        {
           c =  AgentforceUtil.createcase(r.Email, r.Remarks);
           results += ' '+ 'SAP Case: 12';
        }
        list<Result> res = new list<Result>();
        Result r1 = new Result();
        r1.result = results;
        res.add(r1);
        return res;
    }

        public class Request {
        @InvocableVariable(label='Email' required=true)
        public string Email;
        @InvocableVariable(label='Remarks' required=true)
        public string Remarks;
    }

    public class Result {
        @InvocableVariable(label='Result')
        public string result;
    }

}