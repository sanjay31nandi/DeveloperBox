public class fromJSON{
    public String id;   //10209008937474294
    public String name; //Sanjay Nandi
    public static fromJSON parse(String json){
        return (fromJSON) System.JSON.deserialize(json, fromJSON.class);
    }
}