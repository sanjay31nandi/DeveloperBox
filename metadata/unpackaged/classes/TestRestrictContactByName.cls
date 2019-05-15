@istest
private class TestRestrictContactByName{

   @istest static void testverifyDateMethod(){
    
    VerifyDate v= new VerifyDate();
    verifyDate.CheckDates(date.today(), date.today()+1);
   // verifyDate.SetEndOfMonthDate(date.today());
    verifyDate.CheckDates(date.today(), date.today()+60);
    //verifyDate.SetEndOfMonthDate(date.today()+60);
    contact con= new contact(lastname='INVALIDNAME');
    try{insert con;}
    catch(exception e){}
    }

}