public class ManageListController
{
 public string a{get;set;}
 public boolean ab{get;set;}
 public List<AccountWrapper> wrappers {get; set;}
 public static Integer toDelIdent {get; set;}
 public static Integer addCount {get; set;}
 private Integer nextIdent=0;
public integer size{get;set;}
public integer lastindex=0;
Public Integer ident{get;set;}
public List<string> addlist= new list<string>();
   AccountWrapper accnt;

 public ManageListController()
 {
 ident=0;
  wrappers=new List<AccountWrapper>();
  accnt=new AccountWrapper(ident);
  

    //accnt.addvalue();

 wrappers.add(accnt);
 size=wrappers.size();
   }
  
public void delWrapper()
 {
 nextIdent=--nextIdent;
  Integer toDelPos=-1;
  for (Integer idx=0; idx<wrappers.size(); idx++)
  {
   if (wrappers[idx].ident==toDelIdent)
   {
    toDelPos=idx;
   }
  }
  
  if (-1!=toDelPos)
  {
   wrappers.remove(toDelPos);
   size=wrappers.size();
   addlist.remove(toDelPos);
  }
 }
  
 public void addRows()
 {
    ab=true;
    nextIdent=++nextIdent;
    accnt.addvalue();
    addlist.add(accnt.finalvalue);
    accnt=new AccountWrapper(nextIdent);
    wrappers.add(accnt);
     size=wrappers.size();
 }
  
 public void save()
 {
    ab=true;
    //String validatefinalvalue=accnt.finalvalue;
    accnt.addvalue();
    addlist.add(accnt.finalvalue);
    a=addlist.get(0);
    for(integer i=1;i<addlist.size();i++)
        {
             if(addlist.get(i)!=null){
            a= a+';'+addlist.get(i);}
        }
     addlist.clear();
  }
  
 public class AccountWrapper
 {
  public String acc {get;set;}
  public String acc1 {get;set;}
  public string acc2 {get;set;}
  public String finalvalue{get;set;}
  public Integer ident {get;set;}
   
  public AccountWrapper(Integer i)
   {
   ident=i;
     }
     Public void addvalue()
     {
finalvalue=acc+acc1+acc2;
}
}
}