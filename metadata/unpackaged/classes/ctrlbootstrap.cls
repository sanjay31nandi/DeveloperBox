public with sharing class ctrlbootstrap {
    public string demo{get;set;}
    public account acc{get;set;}
    public string demo1{get;set;}
    public contact con{get;set;}
    public list<selectoption>tempselectList{get;set;}
    public list<wrappertest> wrplist{get;set;}
    public ctrlbootstrap(ApexPages.StandardController controller) {
    tempselectList= new list<selectoption>();
    tempselectList.add(new selectoption('A','A'));
    tempselectList.add(new selectoption('B','B'));
    tempselectList.add(new selectoption('C','C'));
    tempselectList.add(new selectoption('D','D'));
    
    wrplist= new list<Wrappertest>();
    wrplist.add(new wrappertest());
    wrplist.add(new wrappertest());
    wrplist.add(new wrappertest());
    wrplist.add(new wrappertest());
    wrplist.add(new wrappertest());
    wrplist.add(new wrappertest());
    
    
    }
    
    public void hello(){
    
    }
    
    public class wrappertest{
        public integer intvalue{get;set;}
        public string strvalue1{get;set;}
        public string strvalue2{get;set;}
        public integer intvalue2{get;set;}
        public double doublevalue{get;set;}
        public String stringvalue{get;set;}
        public list<selectoption>tempselectListwrapp{get;set;}
        
        public wrappertest(){
        tempselectListwrapp= new list<selectoption>();
        tempselectListwrapp.add(new selectoption('Apple','Applesssssssssssssssssssssssssss'));
        tempselectListwrapp.add(new selectoption('Boomberg','Boombergssssssssssssssssssssssssssssssssssssss'));
        tempselectListwrapp.add(new selectoption('Car','Carrrrrrrrrrrrrrrrrr'));
        tempselectListwrapp.add(new selectoption('Donkety','Donkey'));
        
        }
    
    }
}