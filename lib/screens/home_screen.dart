import 'package:cafe/models/cafe.dart';
import 'package:flutter/material.dart';
import 'package:cafe/provider/cafe_provider.dart';
import 'package:provider/provider.dart';
import 'dart:io';
import 'package:cafe/screens/cafe_details_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<CafeProvider>(context, listen: false).initData(); // โหลดข้อมูลเมื่อหน้าจอถูกสร้าง
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Cafe List')),
      body: Consumer<CafeProvider>(
        builder: (context, provider, child) {
          if (provider.cafe_pv.isEmpty) {
            return const Center(child: Text('ไม่มีรายการคาเฟ่'));
          } else {
            return ListView.builder(
              itemCount: provider.cafe_pv.length,
              itemBuilder: (context, index) {
                Cafe cafes = provider.cafe_pv[index];
                return Card(
                  elevation: 5,
                  margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 8),
                  child: ListTile(
                    title: Text(cafes.name),
                    subtitle: Text(cafes.menu),
                    leading: cafes.imagePath != null && File(cafes.imagePath).existsSync()
                        ? Image.file(File(cafes.imagePath))
                        : Icon(Icons.image_not_supported),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => CafeDetailsScreen(cafe: cafes),
                        ),
                      );
                    },
                    trailing: IconButton(
                      icon: Icon(Icons.delete),
                      onPressed: () {
                        provider.deleteCafe(cafes.keyID); // ลบคาเฟ่
                      },
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}




// import 'package:cafe/models/cafe.dart';
// import 'package:flutter/material.dart';
// import 'package:cafe/provider/cafe_provider.dart';
// import 'package:provider/provider.dart';
// import 'dart:io';
// import 'package:cafe/screens/cafe_details_screen.dart';

// class HomeScreen extends StatefulWidget {
//   @override
//   _HomeScreenState createState() => _HomeScreenState();
// }

// class _HomeScreenState extends State<HomeScreen> {

//  @override
//   void initState() {
//     super.initState();
//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       Provider.of<CafeProvider>(context, listen: false).initData();
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text('Cafe List')),
//       body: Consumer<CafeProvider>(
//         builder: (context, provider, child) {
//           if (provider.cafe_pv.isEmpty) {
//             return const Center(child: Text('ไม่มีรายการคาเฟ่'));
//           } else {
//             return ListView.builder(
//               itemCount: provider.cafe_pv.length,
//               itemBuilder: (context, index) {
//                 Cafe cafes = provider.cafe_pv[index];
//                 return Card(
//                   elevation: 5,
//                   margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 8),
//                   child: ListTile(
//                     title: Text(cafes.name),
//                     subtitle: Text(cafes.menu),
//                     leading: cafes.imagePath != null && File(cafes.imagePath).existsSync()
//                         ? Image.file(File(cafes.imagePath))
//                         : Icon(Icons.image_not_supported),
//                     onTap: () {
//                       // ไปยังหน้าแสดงรายละเอียด
//                       Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                           builder: (context) => CafeDetailsScreen(cafe: cafes),
//                         ),
//                       );
//                     },
//                     trailing: IconButton(
//                       icon: Icon(Icons.delete),
//                       onPressed: () {
//                         provider.deleteCafe(cafes.keyID);
//                       },
//                     ),
//                   ),
//                 );
//               },
//             );
//           }
//         },
//       ),
//     );
//   }
// }






// import 'package:cafe/provider/cafe_provider.dart';
// import 'package:cafe/screens/cafe_details_screen.dart';
// import 'package:cafe/screens/form_screen.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:intl/intl.dart';
// import 'package:cafe/models/cafe.dart';
// import 'dart:io';

// class HomeScreen extends StatefulWidget {
//   @override
//   _HomeScreenState createState() => _HomeScreenState();
// }

// class _HomeScreenState extends State<HomeScreen> {
//   @override
//   void initState() {
//     super.initState();
//     // เรียก initData() ใน initState แทน
//     final cafeProvider = Provider.of<CafeProvider>(context, listen: false);
//     cafeProvider.initData();
//   }

  

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text('Cafe')),
//       body: Consumer<CafeProvider>(
//         builder: (context, provider, child) {
//           if (provider.cafes.isEmpty) {
//             return Center(child: Text('ไม่มีรายการคาเฟ่'));
//           } else {
//             return ListView.builder(
//               itemCount: provider.cafes.length,
//               itemBuilder: (context, index) {
//                 var cafe = provider.cafes[index];
//                 return Card(
//                   child: ListTile(
//                     title: Text(cafe.name),
//                     subtitle: Text(cafe.menu),
//                     leading: cafe.imagePath != null && File(cafe.imagePath).existsSync()
//                         ? Image.file(File(cafe.imagePath))
//                         : Icon(Icons.image_not_supported), // แสดงไอคอนเมื่อไม่มีภาพ
//                     trailing: IconButton(
//                       icon: Icon(Icons.delete),
//                       onPressed: () {
//                         Provider.of<CafeProvider>(context, listen: false).deleteCafe(cafe.keyID);
//                       },
//                     ),
//                     onTap: () {
//                       // เมื่อผู้ใช้แตะรายการ เปิด FormScreen เพื่อแก้ไข
//                       Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                           builder: (context) => CafeDetailsScreen(cafe: cafe),
//                         ),
//                       );
//                     },
//                   ),
//                 );
//               },
//             );
//           }
//         },
//       ),
//     );
//   }
// }
