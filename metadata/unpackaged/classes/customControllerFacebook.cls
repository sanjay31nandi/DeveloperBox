public class customControllerFacebook {
public string responsestr{get;set;}
public string resquestURL{get;set;}
public string messagesCus{get;set;}
public boolean MessRender{get;set;}
public customControllerFacebook(){
    if(ApexPages.currentPage().getParameters().get('code')!=null)  MessRender=true;
}
public pagereference calloutLogin(){
  String url = ApexPages.currentPage().getUrl().split('\\?')[0];        
        System.debug('url is '+url);
  
      
 // String redirectURI = 'https://ap1.salesforce.com/apex/TestFacebookIntegration';
 string redirectURI='http://infosyslimited-developer-edition.ap1.force.com/TestFacebookIntegration';
  
   String scope = '&scope=publish_actions,user_likes,user_status,user_posts,user_website,user_friends,publish_pages,user_actions.news';
            
        String state = '&state='+url;
            
        String authURI = 'https://graph.facebook.com/oauth/authorize?client_id=268530043520477'
                        +'&redirect_uri='+redirectURI+scope+state;
          resquestURL=authURI;
         String response;
        
   
    return new pagereference (authURI);
}

public pagereference tryPosting(){

       try{
        String code = ApexPages.currentPage().getParameters().get('code');
        System.debug('Facebook OAuth Step 2 - code:'+code);
        
        String state =  ApexPages.currentPage().getParameters().get('state');
        System.debug('state:'+state);
                
        String tokenURI = 'https://graph.facebook.com/oauth/access_token?client_id='+
                        '268530043520477'+'&redirect_uri='+'http://infosyslimited-developer-edition.ap1.force.com/TestFacebookIntegration'+
                        '&client_secret='+'3d34463128bf08d7782ff8130b5adc50'+'&code='+code;                    
        System.debug('tokenURI is:'+tokenURI);
                
        HttpRequest req = new HttpRequest();
        req.setEndpoint(tokenURI);
        req.setMethod('GET');
        req.setTimeout(60*1000);
        
        Http h = new Http();
        String response;
        if (code.equals('TEST')) {
            response = 'access_token=TEST&expires=3600';
        } else {
            HttpResponse res = h.send(req);
            response = res.getBody();
            responsestr=response;
        }
        tryPostingPost();
        }catch(Exception e){
            ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.error,'The Error occured' +e);
            ApexPages.addMessage(myMsg);
        
        }
       // return new pagereference('https://ap1.salesforce.com/apex/TestFacebookIntegration');
       return new pagereference('http://infosyslimited-developer-edition.ap1.force.com/TestFacebookIntegration');
    }
    
   public void tryPostingPost(){
        
     String accessToken = '';
        Integer expires = 3600;
        Integer acc = responsestr.indexOf('access_token');
        if ( acc == -1 ) {
            //throw new FacebookException('No access token in Facebook response: '+response);
        }
        Integer amp = responsestr.indexOf('&');
        if ( amp == -1 ) {
            accessToken = responsestr.substring(acc + 13, responsestr.length());
        } else {
            accessToken = responsestr.substring(acc + 13, amp);
        }
        Integer exp = responsestr.indexOf('expires');
        if ( exp != -1 ) {
            amp = responsestr.indexOf('&', exp);
            if ( amp == -1 ) {
                expires = Integer.valueOf(responsestr.substring(exp + 8, responsestr.length()));
            } else {
                expires = Integer.valueOf(responsestr.substring(exp + 8, amp));
            }
        }
       
        
         String tokenURI = 'https://graph.facebook.com/me?fields=id,name&access_token='+accessToken;                    
        System.debug('tokenURI is:'+tokenURI);
                
        HttpRequest req = new HttpRequest();
        req.setEndpoint(tokenURI);
        req.setMethod('GET');
        req.setTimeout(60*1000);
        
        Http h = new Http();
        String response;
      
            HttpResponse res = h.send(req);
            response = res.getBody();
            responsestr=response;
        
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.Error,responsestr));
            fromJSON jsonlist= fromJSON.parse(responsestr);
            String id='';
       
            Map<String, Object> m = (Map<String, Object>)JSON.deserializeUntyped(JSON.serialize(jsonlist));
           id=string.valueof(m.get('id')).unescapeHtml4();
     
                
        tokenURI = 'https://graph.facebook.com/'+id+'/feed?access_token='+accessToken;                    
        System.debug('tokenURI is:'+tokenURI);
         
        req = new HttpRequest();
        req.setEndpoint(tokenURI);
        req.setMethod('POST');
        req.setbody('message='+messagesCus);
        resquestURL=string.valueof(req);
        h = new Http();
        
        
            res = h.send(req);
            response = res.getBody();
            responsestr=response;
       if(responsestr.contains('ErrorCode')){} 
       else {
        ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.Confirm,'Sucessfully Posted on wall!!!');
            ApexPages.addMessage(myMsg);
            } 
        //return Null;
    } 
    
    
    
  
    
}