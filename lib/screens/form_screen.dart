import 'package:cafe/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:cafe/provider/cafe_provider.dart';
import 'package:provider/provider.dart';
import 'package:image_picker/image_picker.dart';
import 'package:cafe/models/cafe.dart';
import 'dart:io';
import '../main.dart';

class FormScreen extends StatefulWidget {
  final bool isEdit; // ตัวแปรบอกว่าเป็นการแก้ไขหรือเพิ่มข้อมูลใหม่
  final Cafe? cafe;  // คาเฟ่ที่จะทำการแก้ไข ถ้าเป็นการเพิ่มจะเป็น null

  FormScreen({this.isEdit = false, this.cafe});

  @override
  _FormScreenState createState() => _FormScreenState();
}

class _FormScreenState extends State<FormScreen> {
  final formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final menuController = TextEditingController();
  final detailsController = TextEditingController();
  final feelingController = TextEditingController();
  File? imagePath;
  final picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    if (widget.isEdit && widget.cafe != null) {
      nameController.text = widget.cafe!.name;
      menuController.text = widget.cafe!.menu;
      detailsController.text = widget.cafe!.details;
      feelingController.text = widget.cafe!.feeling;
      imagePath = File(widget.cafe!.imagePath);
    }
  }

  Future<void> _pickImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    setState(() {
      imagePath = pickedFile != null ? File(pickedFile.path) : null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.isEdit ? 'แก้ไขคาเฟ่' : 'เพิ่มคาเฟ่')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: formKey,
          child: ListView(
            padding: EdgeInsets.all(16.0),
            children: [
              TextFormField(
                controller: nameController,
                decoration: InputDecoration(labelText: 'ชื่อคาเฟ่'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'กรุณาใส่ชื่อคาเฟ่';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: menuController,
                decoration: InputDecoration(labelText: 'เมนู'),
              ),
              TextFormField(
                controller: detailsController,
                decoration: InputDecoration(labelText: 'รายละเอียดคาเฟ่'),
              ),
              TextFormField(
                controller: feelingController,
                decoration: InputDecoration(labelText: 'ความรู้สึก'),
              ),
              SizedBox(height: 16),
              imagePath != null
                  ? Image.file(imagePath!)
                  : Text('ยังไม่ได้เลือกรูปภาพ'),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: _pickImage,
                child: Text('เลือกรูปภาพ'),
              ),
              ElevatedButton(
                child: const Text('บันทึก'),
                onPressed: () {
                  if (formKey.currentState!.validate()) {
                    if (imagePath == null || !File(imagePath!.path).existsSync()) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('กรุณาเลือกภาพ')),
                      );
                      return;
                    }

                    var cafes = Cafe(
                      keyID: widget.isEdit ? widget.cafe!.keyID : null, 
                      name: nameController.text,
                      menu: menuController.text,
                      details: detailsController.text,
                      feeling: feelingController.text,
                      imagePath: imagePath!.path,
                    );

                    var provider = Provider.of<CafeProvider>(context, listen: false);

                    if (widget.isEdit) {
                      provider.editCafe(cafes.keyID!, cafes.name, cafes.menu, cafes.details, cafes.feeling, cafes.imagePath);
                    } else {
                      provider.addCafe(cafes);
                    }

                    // นำทางกลับไปยังหน้า HomeScreen และรีเฟรชข้อมูล
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (context) => HomeScreen()),
                      (Route<dynamic> route) => false,
                    );
                  }
                },
              ),


            ],
          ),
        ),
      ),
    );
  }
}




// import 'package:flutter/material.dart';
// import 'package:cafe/provider/cafe_provider.dart';
// import 'package:provider/provider.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:cafe/models/cafe.dart';
// import 'dart:io';
// import '../main.dart';

// class FormScreen extends StatefulWidget {
//   final bool isEdit; // ตัวแปรบอกว่าเป็นการแก้ไขหรือเพิ่มข้อมูลใหม่
//   final Cafe? cafe;  // คาเฟ่ที่จะทำการแก้ไข ถ้าเป็นการเพิ่มจะเป็น null

//   FormScreen({this.isEdit = false, this.cafe});

//   @override
//   _FormScreenState createState() => _FormScreenState();
// }

// class _FormScreenState extends State<FormScreen> {
//   final formKey = GlobalKey<FormState>();
//   final nameController = TextEditingController();
//   final menuController = TextEditingController();
//   final detailsController = TextEditingController();
//   final feelingController = TextEditingController();
//   File? imagePath;
//   final picker = ImagePicker();

//   // @override
//   // void initState() {
//   //   super.initState();
//   //   if (widget.isEdit && widget.cafe != null) {
//   //     nameController.text = widget.cafe!.name;
//   //     menuController.text = widget.cafe!.menu;
//   //     detailsController.text = widget.cafe!.details;
//   //     feelingController.text = widget.cafe!.feeling;
//   //     imagePath = widget.cafe!.imagePath;
//   //   }
//   // }

//   Future<void> _pickImage() async {
//     final pickedFile = await picker.pickImage(source: ImageSource.gallery);
//     setState(() {
//       imagePath = pickedFile != null ? File(pickedFile.path) : null;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text(widget.isEdit ? 'แก้ไขคาเฟ่' : 'เพิ่มคาเฟ่')),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Form(
//           key: formKey,
//           child: ListView(
//             padding: EdgeInsets.all(16.0),
//             children: [
//               TextFormField(
//                 controller: nameController,
//                 decoration: InputDecoration(labelText: 'ชื่อคาเฟ่'),
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'กรุณาใส่ชื่อคาเฟ่';
//                   }
//                   return null;
//                 },
//               ),
//               TextFormField(
//                 controller: menuController,
//                 decoration: InputDecoration(labelText: 'เมนู'),
//               ),
//               TextFormField(
//                 controller: detailsController,
//                 decoration: InputDecoration(labelText: 'รายละเอียดคาเฟ่'),
//               ),
//               TextFormField(
//                 controller: feelingController,
//                 decoration: InputDecoration(labelText: 'ความรู้สึก'),
//               ),
//               SizedBox(height: 16),
//               imagePath != null
//                   ? Image.file(imagePath!)
//                   : Text('ยังไม่ได้เลือกรูปภาพ'),
//               SizedBox(height: 16),
//               ElevatedButton(
//                 onPressed: _pickImage,
//                 child: Text('เลือกรูปภาพ'),
//               ),
//               ElevatedButton(
//                   child: const Text('บันทึก'),
//                   onPressed: () {
//                     if (formKey.currentState!.validate()) {
//                       if (imagePath == null) {
//                         ScaffoldMessenger.of(context).showSnackBar(
//                           SnackBar(content: Text('กรุณาเลือกภาพ')),
//                         );
//                         return;
//                       }
                      
//                       var cafes = Cafe(
//                         keyID: widget.isEdit ? widget.cafe!.keyID : null,  // ถ้าเป็นการแก้ไขให้ใช้ key เดิม
//                         name: nameController.text,
//                         menu: menuController.text,
//                         details: detailsController.text,
//                         feeling: feelingController.text,
//                         imagePath: imagePath!.path,
//                       );

//                       var provider = Provider.of<CafeProvider>(context, listen: false);
                      
//                       if (widget.isEdit) {
//                         provider.editCafe(cafes.keyID!, cafes.name, cafes.menu, cafes.details, cafes.feeling, cafes.imagePath);
//                       } else {
//                         provider.addCafe(cafes);
//                       }

//                       Navigator.pushAndRemoveUntil(
//                         context,
//                         MaterialPageRoute(builder: (context) => MyHomePage()),
//                         (Route<dynamic> route) => false,
//                       );
//                     }
//                   },
//                 )

//               // ElevatedButton(
//               //   child: const Text('บันทึก'),
//               //   onPressed: () {
//               //     if (formKey.currentState!.validate()) {
//               //       if (imagePath == null) {
//               //         ScaffoldMessenger.of(context).showSnackBar(
//               //           SnackBar(content: Text('กรุณาเลือกภาพ')),
//               //         );
//               //         return;
//               //       }
//               //       var cafes = Cafe(
//               //         keyID: null,
//               //         name: nameController.text,
//               //         menu: menuController.text,
//               //         details: detailsController.text,
//               //         feeling: feelingController.text,
//               //         imagePath: imagePath!.path,
//               //       );

//               //       // เรียกใช้ provider ในการเพิ่มข้อมูลคาเฟ่
//               //       var provider =
//               //           Provider.of<CafeProvider>(context, listen: false);
//               //       provider.addCafe(cafes);

//               //       // นำทางกลับไปยังหน้าแรกของแอพ
//               //       Navigator.pushAndRemoveUntil(
//               //         context,
//               //         MaterialPageRoute(builder: (context) => MyHomePage()),
//               //         (Route<dynamic> route) => false,
//               //       );
//               //     }
//               //   },
//               // ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }



// import 'package:flutter/material.dart';
// import 'package:cafe/provider/cafe_provider.dart';
// import 'package:provider/provider.dart';
// import 'package:cafe/models/cafe.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:cafe/screens/home_screen.dart';
// import 'dart:io';

// class FormScreen extends StatefulWidget {
//   final bool isEdit; // ตัวแปรบอกว่าเป็นการแก้ไขหรือเพิ่มข้อมูลใหม่
//   final Cafe? cafe;  // คาเฟ่ที่จะทำการแก้ไข ถ้าเป็นการเพิ่มจะเป็น null

//   FormScreen({this.isEdit = false, this.cafe});

//   @override
//   _FormScreenState createState() => _FormScreenState();
// }

// class _FormScreenState extends State<FormScreen> {
//   final formKey = GlobalKey<FormState>();
//   final nameController = TextEditingController();
//   final menuController = TextEditingController();
//   final detailsController = TextEditingController();
//   final feelingController = TextEditingController();
//   String? imagePath;
//   final picker = ImagePicker();

//   @override
//   void initState() {
//     super.initState();
//     if (widget.isEdit && widget.cafe != null) {
//       // ถ้าเป็นการแก้ไข ให้ใส่ข้อมูลเดิมในฟอร์ม
//       nameController.text = widget.cafe!.name;
//       menuController.text = widget.cafe!.menu;
//       detailsController.text = widget.cafe!.details;
//       feelingController.text = widget.cafe!.feeling;
//       imagePath = widget.cafe!.imagePath;
//     }
//   }

//   Future<void> pickImage() async {
//     final pickedFile = await picker.pickImage(source: ImageSource.gallery);
//     if (pickedFile != null) {
//       setState(() {
//         imagePath = pickedFile.path;
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text(widget.isEdit ? 'แก้ไขคาเฟ่' : 'เพิ่มคาเฟ่')),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Form(
//           key: formKey,
//           child: ListView(
//             padding: EdgeInsets.all(16.0),
//             children: [
//               TextFormField(
//                 controller: nameController,
//                 decoration: InputDecoration(labelText: 'ชื่อคาเฟ่'),
//               ),
//               TextFormField(
//                 controller: menuController,
//                 decoration: InputDecoration(labelText: 'เมนู'),
//               ),
//               TextFormField(
//                 controller: detailsController,
//                 decoration: InputDecoration(labelText: 'รายละเอียดคาเฟ่'),
//               ),
//               TextFormField(
//                 controller: feelingController,
//                 decoration: InputDecoration(labelText: 'ความรู้สึก'),
//               ),
//               SizedBox(height: 16),
//               imagePath != null
//                   ? Image.file(File(imagePath!)) // แสดงภาพที่เลือก
//                   : Text('ยังไม่ได้เลือกรูปภาพ'),
//               SizedBox(height: 16),
//               ElevatedButton(
//                 onPressed: pickImage, // เรียกฟังก์ชันการเลือกรูปภาพ
//                 child: Text('เลือกรูปภาพ'),
//               ),
//               ElevatedButton(
//                 child: Text(widget.isEdit ? 'บันทึกการแก้ไข' : 'เพิ่มคาเฟ่'),
//                 onPressed: () {
//                   if (formKey.currentState!.validate()) {
//                     if (imagePath == null) {
//                       ScaffoldMessenger.of(context).showSnackBar(
//                         SnackBar(content: Text('กรุณาเลือกภาพ')),
//                       );
//                       return;
//                     }

//                     var provider = Provider.of<CafeProvider>(context, listen: false);

//                     if (widget.isEdit && widget.cafe != null) {
//                       // แก้ไขคาเฟ่
//                       provider.editCafe(
//                         widget.cafe!.keyID,
//                         nameController.text,
//                         menuController.text,
//                         detailsController.text,
//                         feelingController.text,
//                         imagePath ?? '',
//                       );
//                     } else {
//                       // เพิ่มคาเฟ่ใหม่
//                       provider.addCafe(
//                         nameController.text,
//                         menuController.text,
//                         detailsController.text,
//                         feelingController.text,
//                         imagePath ?? '',
//                       );
//                     }

//                     // นำทางกลับไปยังหน้าแรกของแอพและลบเส้นทางก่อนหน้านี้
//                     Navigator.pushAndRemoveUntil(
//                       context,
//                       MaterialPageRoute(builder: (context) => HomeScreen()),
//                       (Route<dynamic> route) => false,
//                     );
//                   }
//                 }
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
