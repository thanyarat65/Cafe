import 'dart:io';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sembast/sembast.dart';
import 'package:sembast/sembast_io.dart';
import 'package:cafe/models/cafe.dart';

class CafeDB {
  String dbName;

  CafeDB({required this.dbName});

  // เปิดฐานข้อมูล
  Future<Database> openDatabase() async {
    Directory appDirectory = await getApplicationDocumentsDirectory();
    String dbLocation = join(appDirectory.path, dbName);
    DatabaseFactory dbFactory = databaseFactoryIo;
    Database db = await dbFactory.openDatabase(dbLocation);
    return db;
  }

  // เพิ่มคาเฟ่ลงฐานข้อมูล
  Future<int> insertCafe(Cafe cafes) async {
    var db = await openDatabase();
    var store = intMapStoreFactory.store('cafes'); // ชื่อของ store ที่เปลี่ยนเป็น 'cafes'
    
    var keyID = await store.add(db, {
      "name": cafes.name,
      "menu": cafes.menu,
      "details": cafes.details,
      "feeling": cafes.feeling,
      "imagePath": cafes.imagePath,
    });
    
    db.close(); // ปิดฐานข้อมูลหลังใช้งานเสร็จ
    return keyID;
  }

  // โหลดข้อมูลคาเฟ่ทั้งหมด
  Future<List<Cafe>> loadAllCafes() async {
    var db = await openDatabase();
    var store = intMapStoreFactory.store('cafes'); // ชื่อของ store
    var snapshot = await store.find(db);

    List<Cafe> cafes = [];
    for (var record in snapshot) {
      cafes.add(Cafe(
        keyID: record.key,
        name: record['name'].toString(),
        menu: record['menu'].toString(),
        details: record['details'].toString(),
        feeling: record['feeling'].toString(), // ใช้ 'feeling' แทน 'review'
        imagePath: record['imagePath'].toString(),
      ));
    }

    db.close(); // ปิดฐานข้อมูลหลังใช้งานเสร็จ
    return cafes;
  }

  // อัปเดตข้อมูลคาเฟ่
  Future<void> updateCafe(int keyID, Cafe cafes) async {
    var db = await openDatabase();
    var store = intMapStoreFactory.store('cafes');
    await store.record(keyID).update(db, {
      "name": cafes.name,
      "menu": cafes.menu,
      "details": cafes.details,
      "feeling": cafes.feeling,
      "imagePath": cafes.imagePath,
    });

    db.close(); // ปิดฐานข้อมูลหลังใช้งานเสร็จ
  }

  // ลบคาเฟ่
  Future<void> deleteCafe(int keyID) async {
    var db = await openDatabase();
    var store = intMapStoreFactory.store('cafes');
    await store.record(keyID).delete(db);

    db.close(); // ปิดฐานข้อมูลหลังใช้งานเสร็จ
  }
}





// import 'dart:io';
// import 'package:path/path.dart';
// import 'package:path_provider/path_provider.dart';
// import 'package:sembast/sembast.dart';
// import 'package:sembast/sembast_io.dart';
// import 'package:cafe/models/cafe.dart';


// class CafeDB {
//   String dbName;

//   CafeDB({required this.dbName});

//   Future<Database> openDatabase() async {
//     Directory appDirectory = await getApplicationDocumentsDirectory();
//     String dbLocation = join(appDirectory.path, dbName);
//     DatabaseFactory dbFactory = databaseFactoryIo;
//     Database db = await dbFactory.openDatabase(dbLocation);
//     return db;
//   }

//   Future<int> insertCafe(Cafe cafes) async {
//     var db = await this.openDatabase();
//     var store = intMapStoreFactory.store('cafe');


//     var keyID = await store.add(db, {
//       "name": cafes.name,
//       "menu": cafes.menu,
//       "details": cafes.details,
//       "feeling": cafes.feeling,
//       "imagePath": cafes.imagePath,
//     });
//     db.close();
//     return keyID;
//   }

//   Future<List<Cafe>> loadAllCafes() async {
//     var db = await this.openDatabase();
//     var store = intMapStoreFactory.store('cafes');
//     var snapshot = await store.find(db);
//     List<Cafe> cafes = [];
//     for (var record in snapshot) {
//       cafes.add(Cafe(
//         keyID: record.key,
//         name: record['name'].toString(),
//         menu: record['menu'].toString(),
//         details: record['details'].toString(),
//         feeling: record['review'].toString(),
//         imagePath: record['imagePath'].toString(),
//       ));
//     }
//     db.close();
//     return cafes;
//   }

//   Future<void> updateCafe(int keyID, Cafe cafes) async {
//     var db = await this.openDatabase();
//     var store = intMapStoreFactory.store('cafes');
//     await store.record(keyID).update(db, {
//       "name": cafes.name,
//       "menu": cafes.menu,
//       "details": cafes.details,
//       "feeling": cafes.feeling,
//       "imagePath": cafes.imagePath,
//     });
//     db.close();
//   }

//   Future<void> deleteCafe(int keyID) async {
//     var db = await this.openDatabase();
//     var store = intMapStoreFactory.store('cafes');
//     await store.record(keyID).delete(db);
//     db.close();
//   }
// }