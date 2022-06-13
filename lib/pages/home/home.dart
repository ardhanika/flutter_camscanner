// import 'package:docscan/bloc/Auth_bloc.dart';
// import 'package:docscan/pages/document.dart';
// import 'package:docscan/pages/scan.dart';
// import 'package:docscan/pages/settings.dart';
// import 'package:docscan/repository/auth_repository.dart';

// import '../theme.dart';
// import 'package:flutter/material.dart';

// class HomePage extends StatefulWidget {
//   final AuthBloc authBloc;

//   const HomePage({Key? key, required this.authBloc}) : super(key: key);
//   @override
//   _HomePageState createState() => _HomePageState();
// }

// class _HomePageState extends State<HomePage> {
//   final AuthRepository authRepository = AuthRepository();
//   AuthBloc get _authBloc => widget.authBloc;
//   int _currentIndex = 0;

//   void _onItemTapped(int index) {
//     setState(() {
//       _currentIndex = index;
//     });
//   }

//   final screen = [
//     const Document(),
//     Scan(),
//     SettingPage(),
//   ];

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: screen[_currentIndex],
//       bottomNavigationBar: BottomNavigationBar(
//         selectedIconTheme: IconThemeData(color: purple, size: 35),
//         showSelectedLabels: false,
//         showUnselectedLabels: false,
//         backgroundColor: const Color(0xffF4F6F9),
//         unselectedItemColor: const Color(0xFFB7BEF5),
//         // currentIndex: _currentIndex,
//         items: const <BottomNavigationBarItem>[
//           BottomNavigationBarItem(
//             icon: Icon(Icons.folder_sharp),
//             label: 'Document',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.camera_alt),
//             label: 'Scan',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.settings),
//             label: 'Setting',
//           ),
//         ],
//         currentIndex: _currentIndex,
//         onTap: _onItemTapped,
//       ),
//     );
//   }
// }

import 'package:docscan/pages/login/bloc/auth_bloc.dart';
import 'package:docscan/pages/document/document.dart';
import 'package:docscan/pages/scan/scan.dart';
import 'package:docscan/pages/setting/setting.dart';

import '/component/theme.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  final screen = [
    const Document(),
    const Scan(),
    const SettingPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: screen[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        selectedIconTheme: IconThemeData(color: purple, size: 35),
        showSelectedLabels: false,
        showUnselectedLabels: false,
        backgroundColor: const Color(0xffF4F6F9),
        unselectedItemColor: const Color(0xFFB7BEF5),
        // currentIndex: _currentIndex,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.folder_sharp),
            label: 'Document',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.camera_alt),
            label: 'Scan',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Setting',
          ),
        ],
        currentIndex: _currentIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}
