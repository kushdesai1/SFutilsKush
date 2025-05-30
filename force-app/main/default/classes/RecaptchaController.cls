public with sharing class RecaptchaController {

    public static String secretKey;
    @AuraEnabled
    public static String createCase(Case caseRecord, String recaptchaResponse) {
        system.debug(caseRecord);
        if (!verifyRecaptchaToken(recaptchaResponse)) {
            system.debug('failed: '+recaptchaResponse);           
            throw new AuraHandledException('reCAPTCHA validation failed.');
        }
        insert caseRecord;
        system.debug(caseRecord.Id);
        return caseRecord.Id; // Return Case ID
    }

    private static Boolean verifyRecaptchaToken(String token) {
        try{
        recaptchaKEY__c settings = recaptchaKEY__c.getInstance();
            if (settings != null && settings.Secretkey__c != null) {
                secretKey = settings.Secretkey__c;
            } else {
                system.debug('Recaptcha secret key is not configured in custom settings.');
            } 
        HttpRequest req = new HttpRequest();
        req.setEndpoint('https://www.google.com/recaptcha/api/siteverify');
        req.setMethod('POST');
        req.setHeader('Content-Type', 'application/x-www-form-urlencoded');
        req.setBody('secret=' + EncodingUtil.urlEncode(secretKey, 'UTF-8') + '&response=' + token); 
        HttpResponse res = new Http().send(req);
        if (res.getStatusCode() == 200) {
            Map<String, Object> result = (Map<String, Object>) JSON.deserializeUntyped(res.getBody());
            return (Boolean) result.get('success');
        }
        return false;
    }
    catch(Exception e){
            return false;
        }
}
    
}