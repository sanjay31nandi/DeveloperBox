public class ctrlPermissionSetCloning {

    public PageReference cancel() {
    
        String urlCode = String.valueof(URL.getSalesforceBaseUrl().toExternalForm());
        //Site s = [SELECT s.Subdomain FROM Site s LIMIT 1 ];
        
        //system.debug('The value of urcode is '+ ApiEndpointResolver.podProtocolAndHost());
        pagereference pr= new pagereference('https://ap1.salesforce.com/home/home.jsp');
        return pr;
    }

public list<selectoption>FromToCloning{get;set;}
public string processSelectedOption{get;set;}
public string profileselected{get;set;}
public string permissionseleted{get;set;}
public boolean objSetReq{get;set;}
public boolean classPageReq{get;set;}
public boolean fldSetReq{get;set;}
public boolean section1{get;set;}
public boolean section2{get;set;}
public boolean section3{get;set;}
public boolean section4{get;set;}
public boolean section6{get;set;}
public string permissionsetAselected{get;set;}
public string permissionsetBselected{get;set;}
public SelectOption[] selectedObjects { get; set; }  
public SelectOption[] allObjects  { get; set; }
public SelectOption[] profileselectOption{get;set;}
public SelectOption[] permissionsetselectOption{get;set;}
private String queryFPermisSet=',(SELECT id, SobjectType, Field, PermissionsRead, PermissionsEdit FROM FieldPerms WHERE SobjectType in '; 
private String queryOPermisSet=',(SELECT id,ParentId,SobjectType, PermissionsCreate, PermissionsDelete,PermissionsEdit,PermissionsModifyAllRecords,PermissionsRead,PermissionsViewAllRecords FROM ObjectPerms WHERE SobjectType in ';
private String queryPageClass='(SELECT Id, ParentId, Parent.Name, SetupEntityId FROM SetupEntityAccess WHERE ParentId=:p.id and SetupEntityType in ';

public ctrlPermissionSetCloning (){

   selectedObjects = new List<SelectOption>();
   allObjects = new List<SelectOption>(); 
   FromToCloning=new list<selectoption>();
   profileselectOption= new List<SelectOption>();
   permissionsetselectOption= new List<SelectOption>();  
   Map<String, Schema.SObjectType> AllObjmap = New Map<String, Schema.SObjectType>();
    AllObjmap = Schema.getGlobalDescribe();
    
    List<selectoption> objList = new List<selectoption>();
    for(string s: AllObjmap.keyset()){
         if(AllObjmap.get(s).getdescribe().isCustom() && (!AllObjmap.get(s).getdescribe().isCustomSetting())){
            allObjects.add(new selectoption(s,AllObjmap.get(s).getDescribe().getLabel()));
        }
    }
    
   List<ObjectsAPI__c> stdObj = ObjectsAPI__c.getall().values();
   for(ObjectsAPI__c o:stdObj ){
   allObjects.add(new selectoption(o.name,o.name));
   }
   allObjects.sort();  
   // move to function
   FromToCloning.add(new SelectOption('ProfiletoPermission','Profile to Permission Set'));
   FromToCloning.add(new SelectOption('PermissiontoPermission','Permission Set A to Permission Set B'));
      profiletoPermissionset();
   
 }  
 
 public void profiletoPermissionset(){
      list<Profile>ProfileList= new list<Profile>();
      profileList=[ select id, name from profile];
      for(profile p: profileList){
        profileselectOption.add(new selectoption(p.id,p.name));
      }
 
     List<permissionset> permissionsetList= new List<permissionset>();
     permissionsetlist=[select id,name,IsOwnedByProfile,label,profileid from Permissionset where IsOwnedByProfile=false];
     if(permissionsetlist.size()>0){
         for(permissionset p: permissionsetlist){
                      permissionsetselectOption.add(new selectoption(p.id,p.name));
              }
         }
 
 }
 
 Public void testing(){
 
 if(string.isnotempty(processSelectedOption)){
     if(processSelectedOption=='ProfiletoPermission'){
         section1=true;
         section2=true;
         section3=false;
         section4=false;
         section6=false;
      }
     else if(processSelectedOption=='PermissiontoPermission'){
         section1=true;
         section2=false;
         section3=true;
         section4=false;
         section6=false;
      }
      else{
       section2=false;
       section3=False;
       section4=false;
       section6=false;
      }
   }
   
   if(objSetReq==true|| fldSetReq==true){
     if(processSelectedOption=='ProfiletoPermission'){
        section4=true;
        section6=false;
      }
     else if(processSelectedOption=='PermissiontoPermission'){
        section4=true;
        section6=false;
      }
      else{
         section4=true;
         section6=false;
      }
   }
 }
 
 
 Public boolean Validate(){
     boolean result=true;
     if(string.isblank(processSelectedOption)){
      ApexPages.addmessage(new ApexPages.message(ApexPages.severity.ERROR,'Please Select Operation Required'));
      result=false;
      section6=false;
       }
      
     else if(objSetReq==false && fldSetReq==False && classPageReq==false){
      ApexPages.addmessage(new ApexPages.message(ApexPages.severity.ERROR,'Please Select Process'));
      result=false;
      section6=false;
       }
     
     else if((objSetReq==true|| fldSetReq==true) && selectedObjects.size()==0) {
     ApexPages.addmessage(new ApexPages.message(ApexPages.severity.ERROR,'Please Select Object'));
     result=false;
     section6=false;
     }
    else
        result=true;
    
    return result;
       
  }
  
  public void Cloning(){
      if(Validate()){
          if((objSetReq || fldSetReq)){
              FLSOPCloning();          
          }
         if(classPageReq){
             computeApexClassVFPage();
          } 
          
          ApexPages.addmessage(new ApexPages.message(ApexPages.severity.Confirm,'Cloning Completed'));
      }
  }
  
  
 public void FLSOPCloning(){
         profiletoPermissionset();
        set<String> idsobject1 =new set<String>();
        string idsobject='(';
        List<FieldPermissions> fpermisonInsert= new List<FieldPermissions>();
        Map<string,FieldPermissions> fpermisonUpdate= new map<string,FieldPermissions>();
        Map<string,FieldPermissions> fpermisonAll= new map<string,FieldPermissions>();
        Map<string,ObjectPermissions> fpermisonAll1= new map<string,ObjectPermissions>();
        List<FieldPermissions> fpermisontobeupdated= new List<FieldPermissions>();
        List<ObjectPermissions> fpermisonFinalDeletedList1= new List<ObjectPermissions>();
        List<FieldPermissions> fpermisonFinalDeletedList= new List<FieldPermissions>();
        List<ObjectPermissions> fpermisonInsert1= new List<ObjectPermissions>();
        Map<string,ObjectPermissions> fpermisonUpdate1= new map<string,ObjectPermissions>();
        List<ObjectPermissions> fpermisontobeupdated1= new List<ObjectPermissions>();      
        List<FieldPermissions> fpermison= new List<FieldPermissions>();
        List<ObjectPermissions> fpermison1= new List<ObjectPermissions>();
        list<PermissionSet>permissionsetListExisting= new List<PermissionSet>();
        list<PermissionSet>permissionsetList= new List<PermissionSet>();
        
        
     for(integer i=0;i<selectedObjects.size();i++){
         idsobject1.add(selectedObjects[i].getvalue());
     }
     List<String> objectNames= new List<String>(idsobject1);
     for(integer i=0; i<objectNames.size();i++){
        idsobject+='\''+objectNames[i]+'\'';
      if(i!=objectNames.size()-1)
        idsobject+=',';
      else
        idsobject+=')';
       }
   system.debug('the object selected are '+idsobject);
        String queryString='SELECT id,PermissionsEditReadonlyFields,profileid ';
        queryString+=objSetReq?(queryOPermisSet+idsobject+')'):'';
        queryString+=fldSetReq?(queryFPermisSet+idsobject+')'):'';
        queryString+=' FROM PermissionSet WHERE ';

      
    if(processSelectedOption=='ProfiletoPermission'){
        queryString+= 'profileID IN (\''+profileselected+'\')';
        system.debug('the query string is '+queryString);
        permissionsetList=Database.query(queryString);
   
      }
      else{
       
        queryString+='id IN (\''+permissionsetAselected+'\')';
         permissionsetList=Database.query(queryString );    
      }  
       
       
        for(PermissionSet p:permissionsetList){
         
            if(p.FieldPerms.size()>0 && fldSetReq){
                List<FieldPermissions> fp= new List<FieldPermissions>();
                fp=p.FieldPerms;
                for(FieldPermissions f: fp)
                fpermison.add(f);
            }
            system.debug('the permission set selected id is '+p.ObjectPerms.size() + '---------'+objSetReq );
           if(p.ObjectPerms.size()>0 && objSetReq){
                List<ObjectPermissions> fp1= new List<ObjectPermissions>();
                fp1=p.ObjectPerms;
                for(ObjectPermissions f: fp1)
                fpermison1.add(f);
            }
        }

       
        queryString='SELECT id,Name, Label,UserLicenseId,PermissionsEditReadonlyFields,profileid ';
        queryString+=objSetReq?(queryOPermisSet+idsobject+')'):'';
        queryString+=fldSetReq?(queryFPermisSet+idsobject+')'):'';
        queryString+=' FROM PermissionSet WHERE id IN (\''+permissionsetBselected+'\')';
        //system.debug('the permission set selected id is '+permissionsetBselected);
        
        permissionsetListExisting=Database.query(queryString );
         
        if(permissionsetListExisting.size()>0){
            for(PermissionSet p:permissionsetListExisting){
                system.debug('the permission set selected id is '+p.FieldPerms.size() + '---------'+fldSetReq );
                if(p.FieldPerms.size()>0 && fldSetReq){
                    List<FieldPermissions> fp= new List<FieldPermissions>();
                    fp=p.FieldPerms;
                    for(FieldPermissions f: fp)
                        fpermisonUpdate.put(f.field, f);
                }
                if(p.ObjectPerms.size()>0 && objSetReq){
                    List<ObjectPermissions> fp1= new List<ObjectPermissions>();
                    fp1=p.ObjectPerms;
                    for(ObjectPermissions f: fp1)
                        fpermisonUpdate1.put(f.SobjectType, f);
              }
            }
        }
        
        if(fpermison.size()>0){
            For(FieldPermissions fp1: fpermison){
                Integer flag=0;
                if(fpermisonUpdate.size()>0?(fpermisonUpdate.containsKey(fp1.Field)?true:false):false){
                 
                        if(fp1.PermissionsRead!=fpermisonUpdate.get(fp1.Field).PermissionsRead || fp1.PermissionsEdit!=fpermisonUpdate.get(fp1.Field).PermissionsEdit) {
                            fpermisonUpdate.get(fp1.Field).PermissionsRead= fp1.PermissionsRead;
                            fpermisonUpdate.get(fp1.Field).PermissionsEdit= fp1.PermissionsEdit;
                            fpermisontobeupdated.add(fpermisonUpdate.get(fp1.Field));
                            fpermisonAll.put(fp1.Field,fpermisonUpdate.get(fp1.Field));
                            flag=0;
                        }
                        else{
                            flag=0;
                            fpermisonAll.put(fp1.Field,fpermisonUpdate.get(fp1.Field));
                            }
                    }
                    else{
                        flag=1;
                    }
                            
                if(flag==1){
                    fpermisonInsert.add(new FieldPermissions(SobjectType=fp1.SobjectType,Field=fp1.Field,PermissionsRead=fp1.PermissionsRead,PermissionsEdit=fp1.PermissionsEdit,ParentId=permissionsetListExisting[0].id));
                }

            }
        }
               
        if(fpermisonUpdate.size()>0){
            for(string fp2: fpermisonUpdate.keyset()){
                if(fpermisonAll.size()>0?(!fpermisonAll.containsKey(fp2)?true:false):true){
                fpermisonFinalDeletedList.add(fpermisonUpdate.get(fp2));
                }
            }
        }    
        if(fpermisontobeupdated.size()>0){
            update fpermisontobeupdated;
        }
        if(fpermisonInsert.size()>0){
            insert fpermisonInsert;
        }
        if(fpermisonFinalDeletedList.size()>0){
            delete fpermisonFinalDeletedList;
        }
        system.debug('delete'+fpermisonFinalDeletedList1.size()+'insert'+fpermisonInsert.size()+'update'+fpermisonFinalDeletedList.size());
        
        
        if(fpermison1.size()>0){
            For(ObjectPermissions fp1: fpermison1){
                Integer flag=0;
                if(fpermisonUpdate1.size()>0?(fpermisonUpdate1.containsKey(fp1.SobjectType)?true:false):false){
               
                    fpermisonUpdate1.get(fp1.SobjectType).PermissionsCreate=fp1.PermissionsCreate;
                    fpermisonUpdate1.get(fp1.SobjectType).PermissionsDelete=fp1.PermissionsDelete;
                    fpermisonUpdate1.get(fp1.SobjectType).PermissionsEdit=fp1.PermissionsEdit;
                    fpermisonUpdate1.get(fp1.SobjectType).PermissionsModifyAllRecords=fp1.PermissionsModifyAllRecords;
                    fpermisonUpdate1.get(fp1.SobjectType).PermissionsRead=fp1.PermissionsRead;
                    fpermisonUpdate1.get(fp1.SobjectType).PermissionsViewAllRecords=fp1.PermissionsViewAllRecords;
                    fpermisontobeupdated1.add(fpermisonUpdate1.get(fp1.SobjectType));
                    flag=1;
                    fpermisonAll1.put(fp1.SobjectType,fp1);
                }
                if(flag==0){
                    fpermisonInsert1.add(new ObjectPermissions(PermissionsCreate=fp1.PermissionsCreate, PermissionsDelete=fp1.PermissionsDelete,PermissionsModifyAllRecords=fp1.PermissionsModifyAllRecords,PermissionsViewAllRecords=fp1.PermissionsViewAllRecords,SobjectType=fp1.SobjectType,PermissionsRead=fp1.PermissionsRead,PermissionsEdit=fp1.PermissionsEdit,ParentId=permissionsetListExisting[0].id));
                }

            }
        }   
        
        if(fpermisonUpdate1.size()>0){
            for(string fp2: fpermisonUpdate1.keyset()){
                if(fpermisonAll.size()>0?(!fpermisonAll1.containsKey(fp2)?true:false):true){
                fpermisonFinalDeletedList1.add(fpermisonUpdate1.get(fp2));
                }
            }
        }  
        
        if(fpermisontobeupdated1.size()>0){
            update fpermisontobeupdated1;
        }
                                
        if(fpermisonInsert1.size()>0){
            insert fpermisonInsert1;
           }
        
        if(fpermisonFinalDeletedList1.size()>0){
            delete fpermisonFinalDeletedList1;
           }        
        
     }
     
     
    Public void computeApexClassVFPage(){
       
        List<SetupEntityAccess> SetEntityRecs= new List<SetupEntityAccess>();
        List<SetupEntityAccess> SetEntityRecsExisting= new List<SetupEntityAccess>();
        Map<id,SetupEntityAccess> exsSetEntityRecMap= new Map<id,SetupEntityAccess>();
        List<SetupEntityAccess> SetEntityRecstobeDel= new List<SetupEntityAccess>();
        map<id,SetupEntityAccess> SetEntityRecstobeExt= new map<id,SetupEntityAccess>();
        List<SetupEntityAccess> SetEntityRecstobeIns= new List<SetupEntityAccess>();
        String queryString='SELECT Id, ParentId, Parent.Name, SetupEntityId FROM SetupEntityAccess WHERE ';
        String addOnString=' and SetupEntityType in (\'ApexPage\''+','+'\'ApexClass\')';
        String qString='';
        if(processSelectedOption=='ProfiletoPermission'){
        
            qString=queryString+'Parent.profileId IN (\''+profileselected+'\')'+addOnString;
            SetEntityRecs=Database.query(qString );
        
        }
        else{
       
            qString=queryString+'Parent.id IN (\''+permissionsetAselected+'\')'+addOnString;
            SetEntityRecs=Database.query(qString );    
        }
        
        
        qString =queryString+'Parent.id IN (\''+permissionsetBselected+'\')'+addOnString; 
        
        system.debug('The value is '+ qString );
        SetEntityRecsExisting=Database.query(qString );
        system.debug('The value is '+ SetEntityRecsExisting.size());
        for(SetupEntityAccess s:SetEntityRecsExisting){
            exsSetEntityRecMap.put(s.SetupEntityId,s);
        }
        
        for(integer i=0;i<SetEntityRecs.size();i++){
            if(exsSetEntityRecMap.size()>0?(exsSetEntityRecMap.containsKey(SetEntityRecs[i].SetupEntityId)?true:false):false){
             SetEntityRecstobeExt.put(SetEntityRecs[i].SetupEntityId,SetEntityRecs[i]);
            }
            else{
            SetEntityRecstobeIns.add(new SetupEntityAccess(parentID=permissionsetBselected,SetupEntityId=SetEntityRecs[i].SetupEntityId ) );
            }
        }
        
        for(SetupEntityAccess s:SetEntityRecsExisting){
            if(!SetEntityRecstobeExt.containsKey(s.SetupEntityId)){
                SetEntityRecstobeDel.add(s);
            }
        }
        
        if(SetEntityRecstobeIns.size()>0)
        insert SetEntityRecstobeIns;
        
        if(SetEntityRecstobeDel.size()>0)
        delete SetEntityRecstobeDel;
    }
 }