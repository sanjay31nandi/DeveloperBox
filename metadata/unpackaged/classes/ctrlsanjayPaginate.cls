public without sharing class ctrlsanjayPaginate {
public List<account> selectaccountlist{get;set;}
public list<account> displaylist{get;set;}
public integer startindex{get;set;}
public integer LastIndex{get;set;}
public boolean first{get;set;}
public boolean Last{get;set;}
public boolean next{get;set;}
public boolean previous{get;set;}

    public ctrlsanjayPaginate(ApexPages.StandardController controller) {
        selectaccountlist= new List<account>([select id,name,createddate,accountnumber__c from account order by accountnumber__c]);
        displaylist=new list<account>();
        startIndex=0;
        
        last=false;
        previous=false;
        first=false;
        next=false;
        
        LastIndex=selectaccountlist.size();
        First();
    }
    
    public void next(){
        displaylist.clear();
        startIndex=startIndex+10;
        for(integer i=startIndex;i<(LastIndex<(startIndex+10)?lastIndex:startIndex+10); i++){
            displaylist.add(selectaccountlist[i]);
        }
        if(LastIndex<(startIndex+10) ){
            Last=true;
            next=true;
            first=false;
            previous=false;
        }  
        else{
            Last=false;
            next=false;
            first=false;
            previous=false;
        }             
    }
    
    public void previous(){
        displaylist.clear();
        startIndex=startIndex-10;
        for(integer i=startIndex;i<startIndex; i++){
            displaylist.add(selectaccountlist[i]);
        }
        if(startIndex<10 ){
            Last=false;
            next=false;
            first=true;
            previous=true;
        }    
        else{
            Last=false;
            next=false;
            first=true;
            previous=true;
        }          
    }
    
    public void last(){
        displaylist.clear();
        startIndex=(lastindex/10)*10;
        for(integer i=startIndex;i<(LastIndex<(startIndex+10)?lastIndex:startIndex+10); i++){
            displaylist.add(selectaccountlist[i]);
        }
        
            Last=true;
            next=true;
            first=false;
            previous=false;
        
                
    }
    public void First(){
        displaylist.clear();
        startIndex=0;
       for(integer i=startIndex;i<=(LastIndex<=10?lastIndex:startIndex+10); i++){
            displaylist.add(selectaccountlist[i]);
        }
        if(LastIndex>10){
            last=false;
            next=false;
            first=true;
            previous=true;
        }
                    
    }
}