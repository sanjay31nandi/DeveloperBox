public  class sanjaytry{

    public sanjaytry(ApexPages.StandardController controller) {
ident=0;
    }
Public boolean a1{get;set;}
Public string a{get;set;}
Public string b{get;set;}
Public string c{get;set;}
Public string finalvalue{get;set;}
 Public String[] myList1 = new List<String>();
 Public String[] myList2 = new List<String>();
 Public String[] myList3 = new List<String>();
 public static Integer toDelIdent {get; set;}
 public static Integer addCount {get; set;}
 private Integer nextIdent;
 public Integer ident{get;set;}  public void addRows()
 {
 myList1.add(a);
 myList2.add(b);
 myList3.add(c);
 ident++;
 }
 public void delete1()
 {
 Integer toDelPos=-1;
  for (Integer idx=0; idx<Mylist1.size(); idx++)
  {
   if (ident==toDelIdent)
   {
    toDelPos=idx;
   }
  }
   
  if (-1!=toDelPos)
  {
   mylist1[toDelPos]='';
   mylist2[toDelPos]='';
   mylist3[toDelPos]='';
  }}
 public void test()
 { myList1.add(a);
myList2.add(b);
myList3.add(c);

 String[] myList4 = new List<String>();
 for(Integer i=0;i<=ident;i++)
 {
finalvalue= myList1.get(ident)+myList2.get(ident)+myList3.get(ident);
 }
 system.debug('the size of the list is '+ mylist1.size());
  system.debug('the size of the list is '+ mylist1.size());
 a1=true;}

 }