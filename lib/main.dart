import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:docscan/bloc/auth/auth_repository.dart';
import 'package:docscan/bloc/auth/auth_state.dart';
import 'package:docscan/pages/home.dart';
import 'package:docscan/pages/login.dart';
import 'bloc/auth/auth_bloc.dart';
import 'bloc/auth/auth_event.dart';

void main() {
  final AuthRepository authRepository = AuthRepository();
  runApp(BlocProvider(
    create: (context) {
      return AuthBloc(authRepository: authRepository);
    },
    child: MyApp(
      authRepository: authRepository,
      authBloc: AuthBloc(authRepository: authRepository),
    ),
  ));
}

class MyApp extends StatelessWidget {
  final AuthRepository authRepository;
  final AuthBloc authBloc;

  const MyApp({Key? key, required this.authRepository, required this.authBloc})
      : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: BlocBuilder(
        bloc: authBloc,
        builder: (context, AuthState state) {
          if (state is AuthInit) {
            authBloc.add(AuthCheck());
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (state is AuthHasToken || state is AuthData) {
            return HomePage(
                // authBloc: authBloc,
                );
          }
          if (state is AuthFailed || state is LoginFailed) {
            return LoginPage(
              authBloc: authBloc,
            );
          }
          if (state is AuthLoading) {
            return Container(
              color: Colors.white,
              child: const Center(
                child: CircularProgressIndicator(),
              ),
            );
          }

          return Container();
        },
      ),
    );
  }
}

//TESTTT

// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:docscan/pages/bloc_test.dart';
// import 'package:docscan/service/document_service.dart';
// import 'package:docscan/service/connectivity_service.dart';

// void main() {
//   runApp(const MyApp());
// }

// class MyApp extends StatelessWidget {
//   const MyApp({Key? key}) : super(key: key);

//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//         title: 'Flutter Demo',
//         theme: ThemeData(
//           // This is the theme of your application.
//           //
//           // Try running your application with "flutter run". You'll see the
//           // application has a blue toolbar. Then, without quitting the app, try
//           // changing the primarySwatch below to Colors.green and then invoke
//           // "hot reload" (press "r" in the console where you ran "flutter run",
//           // or simply save your changes to "hot reload" in a Flutter IDE).
//           // Notice that the counter didn't reset back to zero; the application
//           // is not restarted.
//           primarySwatch: Colors.blue,
//         ),
//         home: MultiRepositoryProvider(
//           providers: [
//             RepositoryProvider(
//               create: (context) => DocumentService(),
//             ),
//             RepositoryProvider(
//               create: (context) => ConnectivityService(),
//             )
//           ],
//           child: HomePage(),
//         ));
//   }
// }
