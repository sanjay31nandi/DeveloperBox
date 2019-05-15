public with sharing class ctrlaccount {
public account acc{get;set;}
public account acc1{get;set;}
public string value{get;set;}
public static string valuestr{get;set;}
    public ctrlaccount(ApexPages.StandardController controller) {
        acc= new account();
        acc1=new Account();
    }
    public void valueupdate(){
    acc.type=acc1.type;
    valuestr=acc1.type;
    }
    public void savebutton(){
        acc.type=valuestr;
        system.debug('hello'+acc1+valuestr);
       // insert acc;
        
        //return (new pagereference('/'+acc.id));
    }

}