public class ctrlsajaytestmultiadd {

    public ctrlsajaytestmultiadd() {
products1= new List<innerClass>();
    }

List<Product2> products;
public list<innerclass> products1{get;set;}
public ctrlsajaytestmultiadd(ApexPages.StandardController ctlr)
    {
    
        
        
        
    }
    public List<Product2> getProducts() {

        if(Products== null) 
        Products= [select name,Color__c,Application__c,Product__C from Product2 where color__C != NULL];

        return Products;

    }

public class innerclass{
public product2 prod{get;set;}
public innerclass(){
prod= new product2();
}
}
}