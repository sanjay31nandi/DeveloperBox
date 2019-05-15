public with sharing class createedit {
Case cases{get;set;}
List<Case> types= new List<Case>();
List<SelectOption> options = new List<SelectOption>();
    public createedit(ApexPages.StandardController controller) {

    }
    Public void newmethod()
    {
    types=[select type from case];
    
    }

}