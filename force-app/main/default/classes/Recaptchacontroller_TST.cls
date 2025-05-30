@isTest
private class Recaptchacontroller_TST {

    private class MockHttpResponseGenerator implements HttpCalloutMock {
        public HTTPResponse respond(HTTPRequest req) {
            HttpResponse res = new HttpResponse();
            res.setHeader('Content-Type', 'application/json');
            res.setBody('{"success": true}');
            res.setStatusCode(200);
            return res;
        }
    }

    @isTest
    static void testCreateCase_Success() {
        recaptchaKEY__c settings = new recaptchaKEY__c(
            Secretkey__c = 'mockSecretKey'
        );
        insert settings;
        Test.setMock(HttpCalloutMock.class, new MockHttpResponseGenerator());

        Case testCase = new Case(
            Subject = 'Test Case',
            Status = 'New',
            Origin = 'Web'
        );

        Test.startTest();
        String caseId = RecaptchaController.createCase(testCase, 'dummy_token');
        Test.stopTest();

        System.assertNotEquals(null, caseId);
        Case insertedCase = [SELECT Id, Subject FROM Case WHERE Id = :caseId];
        System.assertEquals('Test Case', insertedCase.Subject);
    }

}
