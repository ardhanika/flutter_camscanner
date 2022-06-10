import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:docscan/repository/auth_repository.dart';
import 'package:docscan/state/auth_state.dart';
import 'package:docscan/pages/home.dart';
import 'package:docscan/pages/login.dart';
import 'blocs/Auth_bloc.dart';
import 'event/auth_event.dart';

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
