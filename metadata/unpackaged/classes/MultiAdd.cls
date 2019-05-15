public class MultiAdd
{
    
    public List<Product2>lstAcct  = new List<product2>();
    public List<innerClass> lstInner {get; set;}
    public String selectedRowIndex{get;set;}  
    public Integer count = 1;
    public String recCount {get;set;}
    
   public PageReference Save()
    {
        PageReference pr = new PageReference('/apex/MultiAdd');
        for(Integer j = 0;j<lstInner.size();j++)
        {
            lstAcct.add(lstInner[j].acct);
        } 
        insert lstAcct;
        pr.setRedirect(True);
        return pr;
    }
        
    public void Add() {   
        count = count+1;
        addMore();      
        
    }
  public void countfun(){
 
  
  }
  
    public void addMore(){       
        innerClass objInnerClass = new innerClass(lstinner.size());
        lstInner.add(objInnerClass);    
                    
    }
    
    public void Del(){
        lstInner.remove(Integer.valueOf(selectedRowIndex));
        integer i = 0;
        for (innerclass a:lstinner) {
           a.traceindex = i++;         
        }
         
                       
        count = count - 1;
     recCount = String.valueOf(Count);           
    }/*End del*/
    
    public MultiAdd(ApexPages.StandardController ctlr)
    {    
        lstInner = new List<innerClass>();
        addMore();
        selectedRowIndex = '0';
    }

    public class innerClass
    {         public String recCount {get;set;}
    
        public integer traceindex{get;set;}   
        public product2 acct {get;set;}
        public innerClass(Integer intCount){
            recCount = String.valueOf(intCount);        
                        acct = new product2();
                    traceindex = intCount++;                        
            
        }/*End Inner class Constructor*/    
    }/*End inner Class*/
}/*End Class*/