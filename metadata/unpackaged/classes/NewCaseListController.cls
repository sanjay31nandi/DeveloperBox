public  class NewCaseListController {
public list<case> NewCases{set;}
public List<case> getNewCases(){
 List<case> results = new list<case>();
 results=[select id, caseNumber from case where status='New'];

return(results);

}
}