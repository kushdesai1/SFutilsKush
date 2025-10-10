@RestResource(urlMapping='/createComplaint/*')
global with sharing class VoiceAgent {
    
    @HttpPost
    global static void doPost() {
        RestRequest req = RestContext.request;
        RestResponse res = RestContext.response;

        try {
            // Parse JSON body
            Map<String, Object> data = (Map<String, Object>) JSON.deserializeUntyped(req.requestBody.toString());
            
            System.debug('Received JSON: ' + data);

            // Example: extract fields
            String name    = (String) data.get('customerName');
            String email   = (String) data.get('customerEmail');
            String message = (String) data.get('complaint');

            // (Optional) Save to Case or Custom Object
            // Case c = new Case(Subject = message, Origin = 'Web', SuppliedEmail = email, SuppliedName = name);
            // insert c;

            res.statusCode = 200;
            res.responseBody = Blob.valueOf(
                JSON.serialize(new Map<String,Object>{
                    'status' => 'success',
                    'received' => data
                })
            );
        } catch (Exception e) {
            res.statusCode = 400;
            res.responseBody = Blob.valueOf(
                JSON.serialize(new Map<String,Object>{
                    'status' => 'error',
                    'message' => e.getMessage()
                })
            );
        }
    }
}
