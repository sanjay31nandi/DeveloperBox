public with sharing class ctrlaccessPage {

    public ctrlaccessPage(ApexPages.StandardController controller) {

    }
    public pagereference go(){
    return (new pagereference('/apex/TestFacebookIntegration'));
    
    }

}