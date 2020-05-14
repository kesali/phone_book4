class Contact {
  int id;
  String name;
  String phoneNumber;
  String avatar;




  static List<Contact> contacts = [
    Contact(name: "Ali Kemal", phoneNumber: "0555 555 55 55"),
    Contact(name: "Dali", phoneNumber: "0555 555 55 55"),
    Contact(name: "Emma", phoneNumber: "0555 555 55 55"),
    Contact(name: "Ergun", phoneNumber: "0555 555 55 55"),
    Contact(name: "Esra", phoneNumber: "0555 555 55 55"),
    Contact(name: "Fatih", phoneNumber: "0555 555 55 55"),
    Contact(name: "Kadir", phoneNumber: "0555 555 55 55"),
    Contact(name: "Kübra", phoneNumber: "0555 555 55 55"),
    Contact(name: "Mehmet", phoneNumber: "0555 555 55 55"),
    Contact(name: "Münire", phoneNumber: "0555 555 55 55"),
    Contact(name: "Sema", phoneNumber: "0555 555 55 55"),
    Contact(name: "Yasir", phoneNumber: "0555 555 55 55"),
    Contact(name: "Zeynep", phoneNumber: "0555 555 55 55"),
  ];

  Contact({this.name, this.phoneNumber,this.avatar});
  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    map["name"] = name; 
    map["phoneNumber"]=phoneNumber;
    map["avatar"] = avatar;
   
   
    return map;
  }

  Contact.fromMap(Map<String, dynamic> map) {
    id = map["id"];
    name = map["name"];
    phoneNumber = map["phoneNumber"];   
    avatar = map["avatar"];
    
  }

}