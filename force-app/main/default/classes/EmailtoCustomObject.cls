public with sharing class EmailtoCustomObject implements Messaging.InboundEmailHandler {

    public Messaging.InboundEmailResult handleInboundEmail(Messaging.InboundEmail email, Messaging.InboundEnvelope envelope) {
        Messaging.InboundEmailResult result = new Messaging.InboundEmailResult();
       
    try{    
        email_record__c emailRecord = new email_record__c();
        emailRecord.Subject__c = email.subject;

        String bodyContent = (email.htmlBody != null) ? email.htmlBody : email.plainTextBody;

        if (bodyContent != null) {
            bodyContent = bodyContent.replaceAll('<[^>]*>', '');
        }

        emailRecord.Email_Body__c = bodyContent;
        emailRecord.FromEmail__c = email.fromAddress;
        emailRecord.name = email.fromAddress;


        if (Schema.sObjectType.Email_Record__c.isCreateable()) {
            insert emailRecord;
        }
    }
    catch(Exception e){
        System.debug('Error processing inbound email: ' + e.getMessage());
    }
    
        return result;
        
    }
}
