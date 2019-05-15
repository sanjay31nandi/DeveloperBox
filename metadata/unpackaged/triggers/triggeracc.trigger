trigger triggeracc on Individual (before insert) {
    
    for(Individual ind :trigger.new){
        ind.lastname='test';
    }    

}