public class Product2Helper {

    /**
     * @name COLLABORATION_GROUP
     * @description List of CollaborationGroup used in both business and test logic
    **/
    static List<CollaborationGroup> COLLABORATION_GROUP = [
        SELECT Id
        FROM CollaborationGroup
        WHERE Name = :Constants.INVENTORY_ANNOUNCEMENTS
        OR Name = :('TEST'+Constants.INVENTORY_ANNOUNCEMENTS)
        LIMIT 1
    ];

    /**
     * @name afterUpdate
     * @description called by product2 Trigger on After Update
     * @param List<Product2> newList
     * @param List<Product2> oldList
    **/
    public static void AfterUpdate(List<Product2> newList,List<Product2> oldList){
        //ToDo: Declare a List of Product2 records named needsAnnouncement
        List<Product2> needsAnnouncement= new List<Product2>();
        
        //ToDo: Declare a Map of Strings to Inventory_Setting__mdt records
        Map<string,Inventory_Setting__mdt > intMap= new Map<string,Inventory_Setting__mdt>();
        
        //ToDo: Loop through a query of Inventory_Setting__mdt records and populate the Map with Name as the key
        for(Inventory_Setting__mdt is:[select id,DeveloperName,MasterLabel,Low_Quantity_Alert__c from Inventory_Setting__mdt limit 1000]){
            intMap.put(is.Masterlabel,is);
        }
        
        //ToDo: Loop through the Products in newList
        // Use the corresponding Inventory Setting record to determine the correct Low Quantity Alert
        // If the Product's Quantity Remaining has been changed to less than the Low Quantity Alert
        //      add it to the needsAnnouncement list
        for(integer i=0;i<newList.size();i++){
            if(newlist[i].Quantity_Remaining__c<intMap.get(newlist[i].Family).Low_Quantity_Alert__c  && newlist[i].Quantity_Remaining__c!=oldlist[i].Quantity_Remaining__c){
            needsAnnouncement.add(newlist[i]);
            }
        }
        PostAlerts(needsAnnouncement);
        //ToDo: Pass records to the postAlerts method
    }

    /**
     * @name postAlerts
     * @description called by product2 Trigger on After Update
     * @param List<Product2> productList
    **/
    public static void PostAlerts(List<Product2> productList){
        List<ConnectApi.AnnouncementInput> toPost = new List<ConnectApi.AnnouncementInput>();
        for ( Product2 p : productList ){
            // ToDo: Construct a new AnnouncementInput for the Chatter Group so that it:
            // expires in a day
            // does not notify users via email.
            // and has a text body that includes the name of the product followed by the INVENTORY_LEVEL_LOW constant
            ConnectApi.AnnouncementInput i= new ConnectApi.AnnouncementInput();
            ConnectApi.TextSegmentInput tSInput = new ConnectApi.TextSegmentInput();
            tSInput.text = p.Name + ' ' + Constants.INVENTORY_LEVEL_LOW;
            ConnectApi.MessageBodyInput messageBodyInput = new ConnectApi.MessageBodyInput();
            messageBodyInput.MessageSegments = new List<ConnectApi.MessageSegmentInput>();
            messageBodyInput.MessageSegments.add(tSInput);
            i.ExpirationDate = Date.today().addDays(1);
            i.SendEmails = false;
            i.ParentId = COLLABORATION_GROUP[0].Id;
            i.Body = messageBodyInput;
            toPost.add(i);

        }
        // ToDo: Create and enqueue an instance of the announcementQueuable class with the list of Products
        System.enqueueJob(new AnnouncementQueueable(toPost));
    }
}