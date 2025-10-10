public with sharing class AccountLookupController {
    @AuraEnabled(cacheable=true)
    public static List<Account> searchAccounts(String searchKey) {
        return [
            SELECT Id, Name 
            FROM Account 
            WHERE Name LIKE :('%' + searchKey + '%') 
            LIMIT 10
        ];
    }
}
