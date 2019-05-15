trigger ClosedOpportunityTrigger on Opportunity (after insert, after update) {
list<task> insertTaskList= new List<Task>();
if(trigger.isafter &&(trigger.isinsert||trigger.isupdate)){
for(opportunity opp:trigger.new){
if(opp.stageName=='Closed Won') 
insertTaskList.add(new task(Subject='Follow Up Test Task',Whatid=opp.id));
}
if(insertTaskList.size()>0)insert insertTaskList;
}

}