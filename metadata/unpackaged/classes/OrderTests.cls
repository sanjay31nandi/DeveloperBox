@isTest
public class OrderTests {

  @testSetup static void SetupTestData(){
    TestDataFactory.InsertTestData(1);
  }


  @isTest
    private static void orderUpdate_UnitTest() {
        Order o = [SELECT Id FROM Order LIMIT 1];
        Product2 oldProduct = [SELECT Id, Family, Name, Quantity_Ordered__c, Quantity_Remaining__c FROM Product2 LIMIT 1];

        o.Status = Constants.ACTIVATED_ORDER_STATUS;

        Test.startTest();

            update o;

        Test.stopTest();

        Product2 newProduct = [SELECT Quantity_Ordered__c FROM Product2 WHERE Id = :oldProduct.Id];
        TestDataFactory.verifyQuantityOrdered(oldProduct, newProduct, Constants.DEFAULT_ROWS);
    }

    @isTest
    private static void orderExtension_UnitTest() {
    PageReference pageRef = Page.OrderEdit;
    Test.setCurrentPage(pageRef);
    Order ord = [SELECT Id, Status FROM Order LIMIT 1];
    ApexPages.StandardController sc = new ApexPages.StandardController(ord);
    OrderExtension ext = new OrderExtension(sc);
    ext.OnFieldChange();
    ext.SelectFamily();
    ext.Save();
    ext.First();
    ext.Next();
    ext.Previous();
    ext.Last();
    ext.GetHasPrevious();
    ext.GetHasNext();
    ext.GetTotalPages();
    ext.GetPageNumber();
    List<SelectOption> options = ext.GetFamilyOptions();
    
    }
}