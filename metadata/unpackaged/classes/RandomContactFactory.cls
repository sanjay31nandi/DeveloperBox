public class  RandomContactFactory{
public static integer counter=0;
public static List<contact> generateRandomContacts(integer size, string s){
    List<contact> conlist= new List<contact>();
    for(integer i=0; i<size;i++){
        contact con= new contact();
        con.firstname='Test'+counter+i;
        con.lastName=s;
        conlist.add(con);
    }
    counter=size;
    return conlist;
}


}