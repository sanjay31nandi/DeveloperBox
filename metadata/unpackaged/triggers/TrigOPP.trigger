trigger TrigOPP on Opportunity (Before insert,before update) {
      if(trigger.isinsert){
       // System.debug('The value of trigger.new OPP insert before is '+trigger.new.size());
        System.debug('The value of trigger.new OPP insert before is '+trigger.new);
       }
       if(trigger.isupdate){
       
        //System.debug('The value of trigger.new OPP is '+trigger.new.size());
        //System.debug('The value of trigger.new OPP is '+trigger.old.size());
        System.debug('The value of trigger.new OPP is '+trigger.new);
        System.debug('The value of trigger.new OPP is '+trigger.old); 
       
       }
        
}