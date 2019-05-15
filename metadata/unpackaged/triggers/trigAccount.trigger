trigger trigAccount on Account (before insert, before update) {
    if(trigger.Isinsert){
    List<testinlist__c> alist= testinlist__c.getall().values();
        For(Account acc:trigger.new){
        acc.SLASerialNumber__c='test';
        }
        For(Account acc:trigger.new){
        system.debug('hello'+acc.SLASerialNumber__c);
        }
    }
    
    if(trigger.Isupdate){
         For(Account acc:trigger.new){
        acc.SLASerialNumber__c='test';
        }
        For(Account acc:trigger.new){
        system.debug('hello'+acc.SLASerialNumber__c);
        }
    }
}