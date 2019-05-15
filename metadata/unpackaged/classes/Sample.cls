public class Sample
{
    public String tabOpt {get;set;}
    public String amount {get;set;}
    public Boolean curencyBool {get;set;}
    public string hellorich{get;set;}
    public string entereddata{get;set;}
    public account acc{get;set;}
    public sample()
    {          curencyBool =true; 
                acc= new account();
    }     
   
    public void switch()
    {      curencyBool =false; 
        tabOpt = 'one';
    }
    public pagereference  saveValue(){
        
        acc.Rich_text_Area_check__c=hellorich;
        acc.SLASerialNumber__c=entereddata;
        
        insert acc;
        pagereference pr= new pageReference('/'+acc.id);
        return pr;
    
    }
}