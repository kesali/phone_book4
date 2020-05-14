import 'dart:async';

import 'package:phone_book4/model/contact.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DbHelper{
  static Database _db;//değişken önüne _ koymak onu private yapmaktır

  Future<Database> get db async{ //db ye get fonk tanımladık
  if (_db!=null)
    return _db;
  _db= await initDb();
        return _db;
    
      }
      initDb() async {
        var dbFolder=await getDatabasesPath();// databasenin yazılacağı klasörün yolunu vermek için
        String path=join(dbFolder,'Contact.db'); //yol ile database yi kaydedeceğimiz dosyanın adını birleştirme

       return await openDatabase(path,onCreate:_onCreate,version: 1);
              }

       FutureOr<void> _onCreate(Database db, int version) async {//database olusturduktan sonra olacaklar
    return await db.execute("CREATE TABLE Contact(id INTEGER PRIMARY KEY, name TEXT, phoneNumber TEXT, avatar TEXT)");
  }

  //listemizdeki kişileri çektiğimiz getContact methodu oluşturalım
  Future <List<Contact>> getContacts() async{
    var dbClient=await db; //bu dbClient ile databaseden veri çekme işlemini gerçekleştiricez

    var result=await dbClient.query("Contact",orderBy: "name");//veri çekme işlemi için query kullanılır.
                                              // order isme göre sıralama yapacak. ve çekme işlemi böyle gelecek
                                              //await sorgudan datayı döndürecek
    //query sorguyu map olarak döndürür bu yüzden return result yazamam. Bizim map ten Contact List e çevirmem gerekli                                          
    return result.map((data)=>Contact.fromMap(data)).toList();
    //artık Contact sayfasındaki kişileri çekebilirim
  }
    Future<int> insertContact(Contact contact) async{ //yeni kişi ekleme metodu
    var dbClient = await db;
    return await dbClient.insert("Contact", contact.toMap());
  }

  Future<void> removeContact(int id) async{ //silme işlemi
    var dbClient=await db;
    return await dbClient.delete("Contact",where:"id=?",whereArgs:[id]);

  }
  
}