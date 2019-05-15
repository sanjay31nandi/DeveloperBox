public class search {
public Opportunity ob2{get;set;}
public String accountid{get;set;}
public boolean a{set;get;}
public boolean a1{set;get;}
public String s1{get;set;}
public String hover{get;set;}

public List<Opportunity> sanjay{get;set;}
public List<Opportunity> sanjay1{get;set;}

public String s2{get;set;}
public search(ApexPages.StandardController controller) {
         this.ob2=(Opportunity)controller.getrecord();
            }
public void searchdata()
        {   a1=true;
            a=false;  
            sanjay=[select Name,StageName,CloseDate,Type,Description from Opportunity where id=:accountid];
        }
public void searchdata1()
        { s1= ob2.name+'%'; 
        a=true;
        sanjay1=[select Name from Opportunity where name like :s1];
           }
           
}