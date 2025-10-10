public with sharing class AgentforceUtil {
public static id SALES = [SELECT Id, Name FROM CollaborationGroup WHERE Name = 'Sales Team' limit 1].id;    
public static id SUPPORT = [SELECT Id, Name FROM CollaborationGroup WHERE Name = 'Support Team' limit 1].id;    

public static Lead createlead(String email, String remarks){
        Lead l = new Lead();
        l.LastName = 'AgentforceLead: '+ String.valueOf(Datetime.now().getTime());
        l.Company = 'Agentforc';
        l.Status = 'Open - Not Contacted';
        l.Email = email;
        l.Description = remarks;
        insert l;

        Id userid = getuser(True);    
        SUPPORThatterpostToCase(l.Id, userid, true, remarks);
        return l;   
    }    
    public static Case createcase(String email, String remarks){
        //contact con = [SELECT Id, Email FROM Contact WHERE Email =: email limit 1];

        Case c = new Case();
        c.Subject = 'SAP Issue';
        c.Status = 'New';
        c.Origin = 'Phone';
        c.Priority = 'Medium';
        c.Type = 'Complaint';
        c.SuppliedEmail = email;
        c.Description = remarks;

        insert c;
    
        Id userid = getuser(false);    
        SUPPORThatterpostToCase(c.Id, userid, false, remarks);
        return c;
    }

    public static Id getuser(boolean isLead){
        Map<Integer, Id> usermap = new Map<Integer, Id>();
        List<AggregateResult> caseorleads = new List<AggregateResult>();
        try{  
            if(!isLead){
            caseorleads = [SELECT COUNT(Id) countforcase, OwnerId 
                                       FROM Case 
                                       GROUP BY OwnerId];
            }
            else{
            caseorleads = [SELECT COUNT(Id) countforcase, OwnerId 
                                       FROM Lead 
                                       GROUP BY OwnerId];
            }                          
            if(!caseorleads.isEmpty()) {                        
                for(AggregateResult ar : caseorleads) {
                    usermap.put(Integer.valueOf(ar.get('countforcase')), (Id)ar.get('OwnerId'));
                }
            }
            
            Integer mincasecount = 0;
            
            if(!usermap.isEmpty()) {
                
                List<Integer> caseCounts = new List<Integer>(usermap.keySet());
                caseCounts.sort();
                mincasecount = caseCounts[0]; 
                Id userid = usermap.get(mincasecount);
                return userid;
            } else {
                return UserInfo.getUserId(); 
            }
        }
        catch(Exception e){
            System.debug('Exception in getuser method: ' + e.getMessage());
            return UserInfo.getUserId(); 
        }                      
    }

    public static void SUPPORThatterpostToCase(Id caseid, Id userId, Boolean isLead, string remarks){
    try{
        ConnectApi.FeedItemInput input = new ConnectApi.FeedItemInput();
        input.body = new ConnectApi.MessageBodyInput();
        input.feedElementType = ConnectApi.FeedElementType.FeedItem;
        input.subjectId = caseid; 
        ConnectApi.MentionSegmentInput mention = new ConnectApi.MentionSegmentInput();
        if(isLead){
        mention.id = SALES;
        }
        else{
        mention.id = SUPPORT;
        }
        string name = [SELECT LastName FROM User WHERE Id =: userId limit 1].LastName;
        ConnectApi.TextSegmentInput text = new ConnectApi.TextSegmentInput();
        if(!isLead){
        text.text = ' please check this case for support! ' +'-' +  ' assigend to ' + name +' '+'https://orgfarm-d3088256ab-dev-ed.develop.lightning.force.com/lightning/r/Case/'+caseid +'/view';
        }
        else{
        text.text = ' please check this lead for sales! '+  '-' +  ' assigend to ' + name +' '+'https://orgfarm-d3088256ab-dev-ed.develop.lightning.force.com/lightning/r/Case/'+caseid +'/view';
        }

        input.body.messageSegments = new List<ConnectApi.MessageSegmentInput>{ mention, text };

        ConnectApi.FeedElement feedElement = ConnectApi.ChatterFeeds.postFeedElement(
            Network.getNetworkId(),
            input
        );

        System.debug('Chatter post created successfully on Case: ' + feedElement.id);
    }
    catch(Exception e){
        System.debug('Exception in SUPPORThatterpostToCase method: ' + e.getMessage());
    }
}

}