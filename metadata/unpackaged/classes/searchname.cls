public class searchname {
     public Opportunity ob1{get;set;}
         public boolean a{set;get;}
    public searchname(ApexPages.StandardController controller) 
        {         this.ob1=(Opportunity)controller.getrecord();
        }
     public List<Opportunity> sanjay1{get;set;}
     public String s1{get;set;}
          public void searchdata1()
        { s1= ob1.name+'%'; 
        a=true;
        sanjay1=[select Name from Opportunity where name like :s1];
        }
}