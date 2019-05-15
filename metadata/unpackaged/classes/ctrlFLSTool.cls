public with sharing class ctrlFLSTool {
    public Map <String, Schema.SObjectType> schemaMap = Schema.getGlobalDescribe();
    public List <SelectOption> objectNames{public get; private set;}
    public set<String> Ids;
    public set<String> idsobject;
    public Profile  pro;
    public String xmlString;
    public String PackageFile;
    public list<schema.sobjecttype> templist{get;set;}
    public ctrlFLSTool(){
    templist= new list<schema.sobjecttype>();
        objectNames=initObjNames();
    }
    private List<SelectOption> initObjNames() {
        List<SelectOption> objNames = new List<SelectOption>();
        Map<String, Schema.SObjectType> AllObjmap = New Map<String, Schema.SObjectType>();
        AllObjmap = Schema.getGlobalDescribe();
    
    for(string s: AllObjmap.keyset()){
         if(AllObjmap.get(s).getdescribe().isCustom() && (!AllObjmap.get(s).getdescribe().isCustomSetting())){
            objNames.add(new selectoption(s,AllObjmap.get(s).getDescribe().getLabel()));
        }
    }
    
   List<ObjectsAPI__c> stdObj = ObjectsAPI__c.getall().values();
   for(ObjectsAPI__c o:stdObj ){
   objNames.add(new selectoption(o.name,o.name));
   }
   objNames.sort();  
      
    
        return objNames;
    }
    
    public void ExtractedData(){
    pro= new profile();
    String ProfileName= pro.name;
    pro=[Select id,name from profile where id='00e90000000JzDk'];
        list<PermissionSet>permissionsetList= new List<PermissionSet>();
        permissionsetList=[SELECT PermissionsEditReadonlyFields,profileid,
                        (SELECT SobjectType, Field, PermissionsRead, PermissionsEdit
                            FROM FieldPerms
                            WHERE SobjectType in :idsobject  order by Field asc)
                            FROM PermissionSet
              WHERE profileID in :ids];
        List<FieldPermissions> fpermison= new List<FieldPermissions>();
        for(PermissionSet p:permissionsetList){
            List<FieldPermissions> fp= new List<FieldPermissions>();
            fp=p.FieldPerms;
            for(FieldPermissions f: fp)
                fpermison.add(f);   
        }
        xmlString= '<?xml version="1.0" encoding="UTF-8"?>'+'\n'+'<Profile xmlns="http://soap.sforce.com/2006/04/metadata">';
        for(FieldPermissions f:fpermison){
            boolean ReadonlyAccess;
            boolean EditAcess;
            if(f.PermissionsEdit==true)
            EditAcess=true;
            
            if(f.PermissionsRead==true){
             EditAcess=false;
             ReadonlyAccess=true;
            }
          xmlString+='\n';
          xmlString+='<fieldPermissions>'+'\n';
          xmlString+='<editable>'+EditAcess+'</editable>'+'\n';
          xmlString+='<field>'+f.Field+'</field>'+'\n';
          xmlString+='<readable>'+ReadonlyAccess+'</readable>'+'\n';
          xmlString+='</fieldPermissions>';  
        }   

        xmlString+='</Profile>';

        PackageFile+='<?xml version="1.0" encoding="UTF-8"?>'+'\n';
        PackageFile+='<Package xmlns="http://soap.sforce.com/2006/04/metadata">'+'\n';
        PackageFile+='<types>'+'\n';
        PackageFile+='<members>'+Pro.name+'</members>'+'\n';
        PackageFile+='<name>Profile</name>'+'\n';   
        PackageFile+='</types>'+'\n'; 
        PackageFile+='<version>33.0</version>';
        PackageFile+='</Package>';      
           blob xmlBlob = Blob.valueOf(PackageFile);
              blob profileBlob = Blob.valueOf(xmlString);
    }
    public void testin(){
    ExtractedData();
    Contact c=[Select id from contact where id='0039000001PKf53' limit 1];
    blob profileBlob = Blob.valueOf(xmlString);
    blob pckgBlob = Blob.valueOf(PackageFile);
    Attachment attachmentObj = new Attachment(parentId = c.id, name='package' + '.xml', body = pckgBlob );
        INSERT attachmentObj;
    Attachment attachmentObj1 = new Attachment(parentId = c.id, name=pro.name+'.profile', body = profileBlob);
        INSERT attachmentObj1;
    }
}