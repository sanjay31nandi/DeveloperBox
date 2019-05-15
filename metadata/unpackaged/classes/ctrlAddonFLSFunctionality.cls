public with sharing class ctrlAddonFLSFunctionality {
public string username{get;set;}
public string password{get;set;}

    public ctrlAddonFLSFunctionality (){
        HttpRequest request = new HttpRequest();
        request.setEndpoint('https://www.salesforce.com/services/Soap/u/34.0');
        request.setMethod('POST');
        request.setHeader('Content-Type', 'text/xml;charset=UTF-8');
        request.setHeader('SOAPAction', '""');
        String requestBody='';
        
    }
    
    
}