import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cafe/provider/cafe_provider.dart';
import 'package:cafe/screens/form_screen.dart';
import 'package:cafe/screens/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});


  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) {
          return CafeProvider();
        }),
      ],
      child: MaterialApp(
        title: 'Cafe App',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.pink),
          useMaterial3: true,
        ),
        home: const MyHomePage(),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    super.initState();
    Provider.of<CafeProvider>(context, listen: false).initData();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 2,
        child: Scaffold(
          body: TabBarView(
            children: [
              HomeScreen(),
              FormScreen(),
            ],
          ),
          bottomNavigationBar: TabBar(
            tabs: [
              Tab(text: "Home", icon: Icon(Icons.home),),
              Tab(text: "Cafe", icon: Icon(Icons.coffee),),
            ],
          ),
        ));
  }

  
}





// void main() {
//   runApp(const MyApp());
// }

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     return MultiProvider(
//       providers: [
//         ChangeNotifierProvider(create: (context) {
//           return TransactionProvider();
//         }),
//       ],
//       child: MaterialApp(
//         title: 'Flutter Demo',
//         theme: ThemeData(
//           colorScheme: ColorScheme.fromSeed(seedColor: Colors.pink),
//           useMaterial3: true,
//         ),
//         home: const MyHomePage(),
//       ),
//     );
//   }
// }

// class MyHomePage extends StatefulWidget {
//   const MyHomePage({super.key});

//   @override
//   State<MyHomePage> createState() => _MyHomePageState();
// }

// class _MyHomePageState extends State<MyHomePage> {
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     Provider.of<TransactionProvider>(context, listen: false).initData();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return DefaultTabController(
//         length: 2,
//         child: Scaffold(
//           body: TabBarView(
//             children: [
//               HomeScreen(),
//               FormScreen(),
//             ],
//           ),
//           bottomNavigationBar: TabBar(
//             tabs: [
//               Tab(text: "Home", icon: Icon(Icons.home),),
//               Tab(text: "Cafe", icon: Icon(Icons.coffee),),
//               Tab(text: "Near Me", icon: Icon(Icons.location_city_rounded),)
//             ],
//           ),
//         ));
//   }
// }
