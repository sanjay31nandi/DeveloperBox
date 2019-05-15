public class multiplerows{
Public list<object> l{get;set;} 
public list<string> s{get;set;}
public void multiplerows()
{
s=(list<string>)l.add(new list<object>());
}
Public void addrow()
{
l.add(new list<object>());
}
}