public inherited sharing class userPhotoGet {

    public string Photolink{get;set;}
    
    public userPhotoGet() {
        User u = [SELECT Id, SmallPhotoUrl FROM User WHERE id= :Userinfo.getUserid()];
        Photolink = u.SmallPhotoUrl;
    }
}