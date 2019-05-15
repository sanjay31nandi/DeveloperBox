public with sharing class ctrldemoOdataStimulator {

 public string result {  get;  set; }
 public string Query {  get;  set; }
 public void ctrldemoOdataStimulator() {

 }
 public list < string > newlist {  get;  set; }
 public void testDataConnection() {
 
 
 //req.setEndpoint('http://host-name/sap/opu/odata/sap/TEST;mo/Carriers?$format=json');
     
     String username = 'ekhairallah@usgme.com';
     String password = 'emilio1969';

     Blob headerValue = Blob.valueOf(username + ':' + password);
     String authorizationHeader = 'Basic ' + EncodingUtil.base64Encode(headerValue);
     //System.debug( 'authorizationHeader : ' + authorizationHeader );
     
 
 
 
  newlist = new list < string > ();
  boolean redirect = true;
  HttpRequest request = new HttpRequest();
  request.setEndpoint('https://odata.meedprojects.com/DataService.svc/tblProjects?$top=5&$inlinecount=allpages');
  request.setMethod('GET');
  request.setTimeout(120000);
  request.setHeader('Authorization', authorizationHeader);
  request.setHeader('Content-Type', 'application/json');
  request.setHeader('Accept', 'application/json');
  request.setHeader('SOAPAction', '');
  //request.setheader('Authorization');
  Query = string.valueof(request);
  Http http = new Http();
  HttpResponse res = http.send(request);

  if (res.getStatusCode() >= 300 && res.getStatusCode() <= 307 && res.getStatusCode() != 306) {
   do {
    redirect = false; // reset the value each time
    String loc = res.getHeader('Location'); // get location of the redirect
    if (loc == null) {
     redirect = false;
     continue;
    }

    request = new HttpRequest();
    request.setEndpoint('http://services.odata.org' + loc);
    request.setMethod('GET');
    request.setHeader('Content-Type', 'application/json');
    request.setHeader('Accept', 'application/json');
    res = http.send(request);
    if (res.getStatusCode() != 500) { // 500 = fail
     if (res.getStatusCode() >= 300 && res.getStatusCode() <= 307 && res.getStatusCode() != 306) {
      redirect = true;
     }
     system.debug('Inside this if');
    }
   } while (redirect && Limits.getCallouts() != Limits.getLimitCallouts());
  }
  result = string.valueof(res.getbody());
  //result=authorizationHeader ;
  String responseStr = res.getBody();
  responseStr = responseStr.replace('href="','href=');
  responseStr = responseStr.replace('">www','>www');
  responseStr = responseStr.replace('Measured"','Measured');
  responseStr = responseStr.replace('&apos;','\'');
  //List<AccountWrapper> pwList = AccountWrapper.parse(responseStr);
//  result =string.valueof(pwlist);
 }
}