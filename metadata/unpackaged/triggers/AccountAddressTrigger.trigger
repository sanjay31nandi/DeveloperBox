trigger AccountAddressTrigger on Account (before insert, before update) {
if(trigger.isbefore && (trigger.isinsert|| trigger.isupdate)){
For(Account acc:trigger.new){
if(acc.Match_Billing_Address__c==true && string.isnotblank(acc.billingPostalCode)) acc.shippingpostalcode=acc.billingpostalcode;
}

}

}