public class createnewcontact{
Public List<SFAR__c> sfar = new list<SFAR__c>();
Public User user {get;set;}
Public User transferuser {get;set;}
Public userrole newrole{get;set;}
Public SFAR__c sfar1 {get;set;}
Public List<Account> accnt{get;set;}
Public List<Account> accnt1= new List<account>();
Public List<Contact> cntct{get;set;}
Public List<contact> cntct1= new List<contact>();
Public List<Opportunity> opp{get;set;}
Public List<Opportunity> opp1= new List<Opportunity>();
Public List<Lead> leads{get;set;}
Public List<Lead> lead1= new List<Lead>();
Public List<Case> cases{get;set;}
Public List<case> case1= new List<case>();
Public List<Groupmember> publicgroup{get;set;}
Public List<PermissionSetAssignment> psa{get;set;}
Public string DeactivateUserId {get;set;}
Public String userId{get;set;}
Public string sfarid{get;set;}
Public string newowner{get;set;}
Public string name{get;set;}
public createnewcontact(ApexPages.StandardController controller) 
{
sfarid= ApexPages.currentPage().getParameters().get('id');
sfar1=[select DeactivateUser__r.id,Transfer_Records_to__r.id,DeactivateUser__r.name from SFAR__c where id=:sfarid];
DeactivateUserId = sfar1.DeactivateUser__r.id;
name=sfar1.DeactivateUser__r.name;
newowner= sfar1.Transfer_Records_to__r.id;
user=[select id from User where id=:DeactivateUserId];
userid= user.id;
transferuser=[select id,name from User where id=:newowner];

}
Public void deactivate()
{
publicgroup=[select id from groupmember where UserOrGroupId=:userid];
if(publicgroup.size()>0)
{
delete(publicgroup);
}
user.UserRoleid='00E900000019biY';
user.profileid='00e90000001VSfG';
user.Isactive=false;
update user;
List<PermissionSetAssignment> psa1;
psa=[select id,PermissionSetId from PermissionSetAssignment where assigneeid=:userid and PermissionSet.IsOwnedByProfile = false];
if(psa.size()>0)
{
delete(psa);
}
//publicgroup=[select groupid,userorgroupId from groupmember where userorgroupId=:userId];


}
Public void transferRecords()
{
accnt=[Select id,Owner.id from account where ownerId=:userId]; //This query will return account ids and owner ids of all the ccounts owned by deactivated user

if( accnt.size()>0) {
for(account a1: accnt)
{
a1.ownerId= transferuser.Id;
accnt1.add(a1);
}
update accnt1;
}
cntct=[Select id from Contact where ownerId=:userId];
if(cntct.size()>0){
for(Contact c1: cntct)
{
c1.ownerId= transferuser.Id;
cntct1.add(c1);
}
update cntct1;
}
opp=[Select id from Opportunity where ownerId=:userId];
for(Opportunity o1: opp)
{
o1.ownerId= transferuser.Id;
opp1.add(o1);
}
cases=[Select id from case where ownerId=:userId];
if(cases.size()>0) {
for(Case ca1:cases)
{
ca1.ownerId= transferuser.Id;
case1.add(ca1);
}
update case1;
}
leads=[Select id from Lead where ownerId=:userId];
if(leads.size()>0)
{
for(Lead l1: leads)
{
l1.ownerId= transferuser.Id;
lead1.add(l1);
}
update lead1;
}

}

}