import 'package:flutter/material.dart';
import 'package:cafe/models/cafe.dart';
import 'package:cafe/provider/cafe_provider.dart';
import 'package:provider/provider.dart';
import 'form_screen.dart';
import 'dart:io';

class CafeDetailsScreen extends StatelessWidget {
  final Cafe cafe;

  CafeDetailsScreen({required this.cafe});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(cafe.name),
        actions: [
          IconButton(
            icon: Icon(Icons.edit),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => FormScreen(isEdit: true, cafe: cafe),
                ),
              );
            },
          ),
          IconButton(
            icon: Icon(Icons.delete),
            onPressed: () {
              var deleteCafe = Provider.of<CafeProvider>(context, listen: false).deleteCafe(cafe.keyID);
              Navigator.pop(context); // กลับไปยังหน้า HomeScreen หลังลบเสร็จ
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          padding: EdgeInsets.all(16.0),
          children: [
            Text('ชื่อคาเฟ่: ${cafe.name}', style: TextStyle(fontSize: 18)),
            SizedBox(height: 10),
            Text('เมนู: ${cafe.menu}', style: TextStyle(fontSize: 16)),
            SizedBox(height: 10),
            Text('รายละเอียด: ${cafe.details}', style: TextStyle(fontSize: 16)),
            SizedBox(height: 10),
            Text('ความรู้สึก: ${cafe.feeling}', style: TextStyle(fontSize: 16)),
            SizedBox(height: 10),
            cafe.imagePath != null
                ? Image.file(File(cafe.imagePath))
                : Text('ไม่มีภาพ'),
          ],
        ),
      ),
    );
  }
}




// import 'package:flutter/material.dart';
// import 'package:cafe/models/cafe.dart';
// import 'package:cafe/provider/cafe_provider.dart';
// import 'package:provider/provider.dart';
// import 'form_screen.dart';
// import 'dart:io';

// class CafeDetailsScreen extends StatelessWidget {
//   final Cafe cafe;

//   CafeDetailsScreen({required this.cafe});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(cafe.name),
//         actions: [
//           IconButton(
//             icon: Icon(Icons.edit),
//             onPressed: () {
//               // ไปยังหน้าฟอร์มเพื่อแก้ไข
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(
//                   builder: (context) => FormScreen(isEdit: true, cafe: cafe),
//                 ),
//               );
//             },
//           ),
//           IconButton(
//             icon: Icon(Icons.delete),
//             onPressed: () {
//               // ลบข้อมูลคาเฟ่
//               Provider.of<CafeProvider>(context, listen: false).deleteCafe(cafe.keyID);
//               Navigator.pop(context); // กลับไปยังหน้าหลักหลังลบเสร็จ
//             },
//           ),
//         ],
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text('ชื่อคาเฟ่: ${cafe.name}', style: TextStyle(fontSize: 18)),
//             SizedBox(height: 10),
//             Text('เมนู: ${cafe.menu}', style: TextStyle(fontSize: 16)),
//             SizedBox(height: 10),
//             Text('รายละเอียด: ${cafe.details}', style: TextStyle(fontSize: 16)),
//             SizedBox(height: 10),
//             Text('ความรู้สึก: ${cafe.feeling}', style: TextStyle(fontSize: 16)),
//             SizedBox(height: 10),
//             cafe.imagePath != null
//                 ? Image.file(File(cafe.imagePath))
//                 : Text('ไม่มีภาพ'),
//           ],
//         ),
//       ),
//     );
//   }
// }
