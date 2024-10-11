import 'package:cafe/databases/cafe_db.dart';
import 'package:flutter/foundation.dart';
import 'package:cafe/models/cafe.dart';

class CafeProvider with ChangeNotifier {
  List<Cafe> cafe_pv = [];

  // โหลดข้อมูลคาเฟ่ทั้งหมดจากฐานข้อมูล
  void initData() async {
    var db = CafeDB(dbName: 'cafe_pv.db');
    cafe_pv = await db.loadAllCafes();
    notifyListeners();  // แจ้งเตือนให้ UI อัปเดต
  }

  // เพิ่มคาเฟ่ใหม่
  Future<void> addCafe(Cafe cafes) async {
    var db = CafeDB(dbName: 'cafe_pv.db');
    await db.insertCafe(cafes);
    cafe_pv = await db.loadAllCafes(); // โหลดข้อมูลใหม่
    notifyListeners();  // แจ้งเตือนให้ UI อัปเดต
  }

  // แก้ไขข้อมูลคาเฟ่
  void editCafe(int keyID, String name, String menu, String details, String feeling, String imagePath) async {
    var cafe = Cafe(
      keyID: keyID,
      name: name,
      menu: menu,
      details: details,
      feeling: feeling,
      imagePath: imagePath,
    );
    var db = CafeDB(dbName: 'cafe_pv.db');
    await db.updateCafe(keyID, cafe);
    cafe_pv = await db.loadAllCafes(); // โหลดข้อมูลใหม่
    notifyListeners();  // แจ้งเตือนให้ UI อัปเดต
  }


  void deleteCafe(int? keyID) async {
    var db = CafeDB(dbName: 'cafe_pv.db');
    await db.deleteCafe(keyID!);
    cafe_pv = await db.loadAllCafes();
    notifyListeners();
  }

  // คืนค่าลิสต์คาเฟ่
  List<Cafe> getCafes() {
    return cafe_pv;
  }
}



// import 'package:cafe/databases/cafe_db.dart';
// import 'package:flutter/foundation.dart';
// import 'package:cafe/models/cafe.dart';

// class CafeProvider with ChangeNotifier {
//   List<Cafe> cafe_pv = [];


//   // โหลดข้อมูลคาเฟ่ทั้งหมดจากฐานข้อมูล
//   void initData() async {
//     var db = CafeDB(dbName: 'cafe_pv.db');
//     cafe_pv = await db.loadAllCafes();
//     notifyListeners();  // แจ้งเตือนให้ UI อัปเดต
//   }

//   // เพิ่มคาเฟ่ใหม่
//   void addCafe(Cafe cafes) async {
//     var db = CafeDB(dbName: 'cafe_pv.db');
//     await db.insertCafe(cafes);
//     cafe_pv = await db.loadAllCafes();
//     notifyListeners();  // แจ้งเตือนให้ UI อัปเดต
//   }

//   void editCafe(int keyID, String name, String menu, String details, String feeling, String imagePath) async {
//     var cafe = Cafe(
//       keyID: keyID,
//       name: name,
//       menu: menu,
//       details: details,
//       feeling: feeling,
//       imagePath: imagePath,
//     );
//     var db = CafeDB(dbName: 'cafe_pv.db');
//     await db.updateCafe(keyID, cafe);
//     cafe_pv = await db.loadAllCafes();
//     notifyListeners();  // แจ้งเตือนให้ UI อัปเดต
//   }

//   void deleteCafe(int? keyID) async {
//     var db = CafeDB(dbName: 'cafe_pv.db');
//     await db.deleteCafe(keyID!);
//     cafe_pv = await db.loadAllCafes();
//     notifyListeners();
//   }


//   // คืนค่าลิสต์คาเฟ่
//   List<Cafe> getCafes() {
//     return cafe_pv;
//   }
// }





// import 'package:cafe/databases/cafe_db.dart';
// import 'package:flutter/foundation.dart';
// import 'package:cafe/models/cafe.dart';

// class CafeProvider with ChangeNotifier {
//   List<Cafe> cafes = [];

//   List<Cafe> getCafes() {
//     return cafes;
//   }

//   void initData() async {
//     var db = CafeDB(dbName: 'cafes.db');
//     cafes = await db.loadAllCafes();
//     notifyListeners();
//   }

//   void addCafe(Cafe cafe) async {
//     var db = CafeDB(dbName: 'cafes.db');
//     await db.insertCafe(cafe);
//     cafes = await db.loadAllCafes();
//     notifyListeners();
//   }

//   void updateCafe(int keyID, Cafe cafe) async {
//     var db = CafeDB(dbName: 'cafes.db');
//     await db.updateCafe(keyID, cafe);
//     cafes = await db.loadAllCafes();
//     notifyListeners();
//   }

//   void deleteCafe(int? keyID) async {
//     var db = CafeDB(dbName: 'cafes.db');
//     await db.deleteCafe(keyID);
//     cafes = await db.loadAllCafes();
//     notifyListeners();
//   }
// }




// import 'package:flutter/material.dart';
// import 'package:cafe/models/cafe.dart';
// import 'package:cafe/databases/cafe_db.dart';

// class CafeProvider with ChangeNotifier {
//   List<Cafe> cafes = [];

//   List<Cafe> 

//   void initData() {
//     // โหลดข้อมูลในตอนเริ่มต้น
//     _cafes = [
//       // ใส่ข้อมูลเริ่มต้นหากต้องการ
//     ];
//   }

//   void addCafe(String name, String menu, String details, String feeling, String imagePath) {
//     final newCafe = Cafe(
//       keyID: DateTime.now().toString(), // ใช้เวลาปัจจุบันเป็น ID เพื่อความ unique
//       name: name,
//       menu: menu,
//       details: details,
//       feeling: feeling,
//       imagePath: imagePath,
//     );
//     _cafes.add(newCafe);
//     notifyListeners();  // แจ้งให้ UI อัปเดต
//   }

//   void editCafe(String keyID, String name, String menu, String details, String feeling, String imagePath) {
//     final cafeIndex = _cafes.indexWhere((cafe) => cafe.keyID == keyID);
//     if (cafeIndex >= 0) {
//       _cafes[cafeIndex] = Cafe(
//         keyID: keyID, // ใช้ keyID เดิม
//         name: name,
//         menu: menu,
//         details: details,
//         feeling: feeling,
//         imagePath: imagePath,
//       );
//       notifyListeners();  // แจ้งให้ UI อัปเดต
//     }
//   }

//   void deleteCafe(String keyID) {
//     _cafes.removeWhere((cafe) => cafe.keyID == keyID);
//     notifyListeners();  // แจ้งให้ UI อัปเดต
//   }
// }






