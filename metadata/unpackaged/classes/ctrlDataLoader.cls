public with sharing class ctrlDataLoader {
public Blob csvFileBody{get;set;}
public string csvAsString{get;set;}
public String[] csvFileLines{get;set;}
public string objectname{get;set;}
 public List<Schema.SObjectType> gd;
public Schema.SObjectType object_Selected;
public List<SelectOption> ObjectOptions{get;set;}
public List<account> acclist{get;set;}
  public ctrlDataLoader (){
    csvFileLines = new String[]{};
    acclist = New List<Account>(); 
    ObjectOptions=new list<selectoption>();
    gd= Schema.getGlobalDescribe().Values();       
     
   for(Schema.SObjectType f : gd)   {  
       ObjectOptions.add(new SelectOption(f.getDescribe().getname(),f.getDescribe().getlabel()));  
  } 
  ObjectOptions.sort();
  system.debug('The value of the objectOptions is '+ObjectOptions);
  }
  
  public void selection_Field(){
  system.debug('The value of selected list is '+objectname);
  for(Integer i=0;i<gd.size();i++){
  if(gd[i].getdescribe().getname()==objectname)
  object_Selected=gd[i];
  }
  
 /* Map<String, Schema.SObjectField> schemaFieldMap = Schema.SObjectType.objectname.fields.getMap();
  Map<String, Object> queriedFieldValues = new Map<String, Object>();
  for (String fieldName: schemaFieldMap.keySet()) {
    try { 
        queriedFieldValues.put(fieldName, account.get(fieldName)); 
    } catch (SObjectException e)    { 
        // Intentional capture 
    }
}
System.debug(queriedFieldValues);
  */
  }
   
  public void importCSVFile(){
       try{
           csvAsString = csvFileBody.toString();
           csvFileLines = csvAsString.split('\n'); 
            System.debug('The value of blob file is======'+csvFileBody);
            System.debug('The value of blob file is======'+csvAsString);
            System.debug('The value of blob file is======'+csvFileLines );
           for(Integer i=1;i<csvFileLines.size();i++){
               Account accObj = new Account() ;
               string[] csvRecordData = csvFileLines[i].split(',');
               accObj.name = csvRecordData[0] ;             
               accObj.accountnumber = csvRecordData[1];
               accObj.Type = csvRecordData[2];
               accObj.AccountSource = csvRecordData[3];   
               accObj.Industry = csvRecordData[4];                                                                             
               acclist.add(accObj);   
           }
        //insert acclist;
     
        }
        catch (Exception e)
        {
            ApexPages.Message errorMessage = new ApexPages.Message(ApexPages.severity.ERROR,'An error has occured while importin data Please make sure input csv file is correct');
            ApexPages.addMessage(errorMessage);
        }  
  }
}