@isTest
private class AccountManagerTest {

    private static testMethod void getAccountTest1() {
        Account TestAcc = new Account(
            Name='Test record');
        insert TestAcc;
        Contact TestCon= new Contact(
            LastName='Test', 
            AccountId = Testacc.id);
            insert testcon;
        // Set up a test request
        RestRequest request = new RestRequest();
        request.requestUri = 'https://na1.salesforce.com/services/apexrest/Accounts/'+ TestAcc.id+'/contacts' ;
        request.httpMethod = 'GET';
        RestContext.request = request;
        // Call the method to test
        Account thisAccount = AccountManager.getAccount();
        // Verify results
       // System.assert(thisAccount != null);
     //   System.assertEquals('Test record', thisAccount.Name);

    }

    // Helper method
     
}