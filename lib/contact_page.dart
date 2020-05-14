import 'package:flutter/material.dart';
import 'package:phone_book4/add_contact_page.dart';
import 'package:phone_book4/model/contact.dart';

import 'database/db_helper.dart';

//statelessWidget durum bilgisi tutmadığı için yeni eklenen verilerde kendini yenilemez. Ama ben yeni eklediğim
//kişilerin listede görünmesini istiyorum bu yüzden StatefullWidget yapacağız.
class ContactPage extends StatefulWidget {
  @override
  _ContactPageState createState() => _ContactPageState();
}

class _ContactPageState extends State<ContactPage> {
  //burada tanımlananlar (class içinde)alttaki her widgetta görülür
  List<Contact> contacts;
  DbHelper _dbHelper;
  @override
  void initState() {
    //statefull methodu çalıştığında otomatik olarak ilk bunu çağırır
    _dbHelper = DbHelper();
    //contacts = Contact.contacts;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    /*Contact.contacts.sort(//rehberi alfabetik sıralar. Bunu initStatede yaparsan sadece ilk çalışmada bu işlemi yapar ama ben yeni kişi ekledikçe yapsın istiyorum o yüzden her build context yapıldığında bu işlem çalışsın dedim
      (Contact a, Contact b) => a.name[0].toLowerCase().compareTo(b.name[0].toLowerCase()),
    );*/

    return Scaffold(
      appBar: AppBar(
        title: Text("Phone Book"),
        //actions: <Widget>[IconButton(icon: Icon(Icons.add), onPressed: () {})], floatingActionButtonu yazdık aşağı. Buna ihtiyaç yok artık
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => AddContactPage()));
        },
        child: Icon(Icons.add),
      ),
      body: FutureBuilder(
        future: _dbHelper.getContacts(),
        builder: (BuildContext context, AsyncSnapshot<List<Contact>> snapshot) {
          if (!snapshot.hasData) return CircularProgressIndicator();
          if (snapshot.data.isEmpty) return Text("Your contact list empty");
          return ListView.builder(
              itemCount: snapshot.data.length,
              itemBuilder: (BuildContext context, int index) {
                Contact contact = snapshot.data[index];
                return Dismissible(
                  key: UniqueKey(),
                  background: Container(
                    color: Colors.red,
                  ),
                  onDismissed: (direction) async {
                    _dbHelper.removeContact(contact.id);

                    setState(() {});

                    Scaffold.of(context).showSnackBar(SnackBar(
                      content: Text("${contact.name} has been deleted"),
                      action: SnackBarAction(
                        label: "UNDO",
                        onPressed: () async {
                          await _dbHelper.insertContact(contact);

                          setState(() {});
                        },
                      ),
                    ));
                  },
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundImage: AssetImage(
                        contact.avatar.isEmpty
                            ? "assets/img/user.png"
                            : contact.avatar,
                      ),
                      child: Text(
                        contact.name[0].toUpperCase(),
                        style: TextStyle(
                            fontSize: 24, fontWeight: FontWeight.bold),
                      ),
                    ),
                    title: Text(contact.name),
                    subtitle: Text(contact.phoneNumber),
                  ),
                );
              });
        },
      ),
    );
  }
}
/*
class ContactPage1 extends StatelessWidget{
  final List<Contact> contacts = Contact.contacts;
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("Phone Book"),
        //actions: <Widget>[IconButton(icon: Icon(Icons.add), onPressed: () {})], floatingActionButtonu yazdık aşağı. Buna ihtiyaç yok artık
      ),
      floatingActionButton: FloatingActionButton(onPressed: (){
        print(Contact.contacts.length); //consola kaç kişi olduğunu yazar denemek için yazdım
        Navigator.push(context, MaterialPageRoute(builder: (context)=>AddContactPage()));
      },child: Icon(Icons.add),),
      body: ListView.builder(
          itemCount: contacts.length,
          itemBuilder: (BuildContext context, int index) {
            Contact contact = contacts[index];
            return Container(
              padding: EdgeInsets.all(5),
              child: Column(
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      CircleAvatar(
                        backgroundImage: NetworkImage(
                          "https://placekitten.com/200/200",
                        ),
                        child: Text(
                          contact.name[0],
                          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 8),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(contact.name),
                            Text(contact.phoneNumber),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Divider(
                      height: 2,
                    ),
                  ),
                ],
              ),
            );
          }),
    );
  
  }

}*/
