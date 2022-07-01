
import 'package:docscan/pages/home/home.dart';
import 'package:flutter/material.dart';
import 'package:docscan/pages/login/bloc/auth_state.dart';
import 'package:url_launcher/url_launcher.dart';
import '/component/theme.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:docscan/pages/login/bloc/auth_bloc.dart';
import 'package:docscan/pages/login/bloc/auth_event.dart';

class LoginPage extends StatefulWidget {
  final AuthBloc authBloc;

  const LoginPage({Key? key, required this.authBloc}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  AuthBloc get _authBloc => widget.authBloc;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _authBloc,
      child: LoginForm(
        authBloc: _authBloc,
      ),
    );
  }
}

class LoginForm extends StatefulWidget {
  final AuthBloc authBloc;

  const LoginForm({Key? key, required this.authBloc}) : super(key: key);

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  void _launchURL() async {
    const url = 'http://camscanner.putraprima.id/register';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  final TextEditingController emailController = TextEditingController(text: "");

  final TextEditingController passwordController =
      TextEditingController(text: "");

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      bloc: widget.authBloc,
      listener: (context, state) {
        if (state is AuthHasToken) {
          Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: ((context) => HomePage())));
        }
      },
      child: BlocBuilder(
        bloc: widget.authBloc,
        builder: (context, state) {
          return Scaffold(
            resizeToAvoidBottomInset: false,
            backgroundColor: Colors.white,
            body: Container(
              padding: const EdgeInsets.all(20),
              child: SafeArea(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Image.asset(
                          "assets/images/document_logo.png",
                          height: 40,
                          width: 40,
                        ),
                        Container(
                          margin: const EdgeInsets.only(left: 15),
                        ),
                        Text(
                          "Scanner App",
                          style: text,
                        )
                      ],
                    ),
                    const Padding(
                      padding: EdgeInsets.only(top: 80),
                    ),
                    Text(
                      "Login",
                      style: title,
                    ),
                    Container(
                      padding: const EdgeInsets.fromLTRB(10, 20, 10, 10),
                      child: TextFormField(
                        cursorColor: const Color(0x1a34395E),
                        controller: emailController,
                        keyboardType: TextInputType.emailAddress,
                        autofocus: false,
                        decoration: InputDecoration(
                          icon: const Icon(Icons.email),
                          iconColor: purple,
                          hintText: 'email',
                          contentPadding:
                              const EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20.0)),
                        ),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.fromLTRB(10, 10, 10, 30),
                      child: TextFormField(
                        cursorColor: const Color(0x1a34395E),
                        controller: passwordController,
                        obscureText: true,
                        autofocus: false,
                        decoration: InputDecoration(
                          icon: const Icon(Icons.key),
                          iconColor: purple,
                          hintText: 'password',
                          contentPadding:
                              const EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20.0)),
                        ),
                      ),
                    ),
                    Row(
                      children: [
                        const Text(
                          "Dont have an account?",
                          style: TextStyle(fontSize: 16),
                        ),
                        GestureDetector(
                            onTap: _launchURL,
                            child: Text(" Create One",
                                style: TextStyle(
                                  color: purple,
                                  fontSize: 16,
                                )))
                      ],
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 30),
                      height: 50,
                      width: 500,
                      child: TextButton(
                        style: TextButton.styleFrom(
                            backgroundColor: const Color(0xFF6777EF),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            )),
                        // onPressed: () {},
                        onPressed: _login,
                        child: const Text(
                          "Sign In",
                          style: TextStyle(
                            color: Color(0xffffffff),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    (state is LoginFailed) ? Text(state.error) : const Text(""),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  void _login() {
    widget.authBloc.add(LoginProcess(
      email: emailController.text,
      password: passwordController.text,
    ));
  }
}
// import 'package:docscan/pages/home.dart';
// import 'package:flutter/material.dart';
// import '../theme.dart';

// class LoginPage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     TextEditingController nameController = TextEditingController();
//     TextEditingController passwordController = TextEditingController();
//     return Scaffold(
//       resizeToAvoidBottomInset: false,  
//         backgroundColor: Colors.white,
//         body: Container(
//             padding: EdgeInsets.all(20),
//             child: SafeArea(
//                 child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                   Row(
//                     children: [
//                       Image.asset(
//                         "assets/images/document_logo.png",
//                         height: 40,
//                         width: 40,
//                       ),
//                       Container(
//                         margin: EdgeInsets.only(left: 15),
//                       ),
//                       Text(
//                         "Scanner App",
//                         style: text,
//                       )
//                     ],
//                   ),
//                   Padding(
//                     padding: EdgeInsets.only(top: 80),
//                   ),
//                   Text(
//                     "Login",
//                     style: title,
//                   ),
//                   // Container(
//                   //   padding: const EdgeInsets.all(10),
//                   //   child: TextField(
//                   //     controller: passwordController,
//                   //     decoration: const InputDecoration(
//                   //       border: ,
//                   //       labelText: 'Password',
//                   //     ),
//                   //   ),
//                   // ),
//                   Container(
//                     padding: EdgeInsets.fromLTRB(10, 20, 10, 10),
//                     child: TextFormField(
//                       cursorColor: Color(0x1a34395E),
//                       controller: nameController,
//                       keyboardType: TextInputType.emailAddress,
//                       autofocus: false,
//                       decoration: InputDecoration(
//                         icon: Icon(Icons.email), iconColor: purple,
//                         hintText: 'email',
//                         contentPadding:
//                             EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
//                         border: OutlineInputBorder(
//                             borderRadius: BorderRadius.circular(20.0)),
//                       ),
//                     ),
//                   ),
//                   Container(
//                     padding: EdgeInsets.fromLTRB(10, 10, 10, 30),
//                     child: TextFormField(
//                       cursorColor: Color(0x1a34395E),
//                       controller: passwordController,
//                       obscureText: true,
//                       autofocus: false,
//                       decoration: InputDecoration(
//                         icon: Icon(Icons.key),iconColor: purple,
//                         hintText: 'password',
//                         contentPadding:
//                             EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
//                         border: OutlineInputBorder(
//                             borderRadius: BorderRadius.circular(20.0)),
//                       ),
//                     ),
//                   ),
//                   Row(
//                     children: [
//                       const Text("Dont have an account?", style: TextStyle(fontSize: 16),),
//                       Text(" Create One", style: TextStyle(color: purple, fontSize: 16,))
//                     ],
//                   ),
//                   Container(
//                     margin: EdgeInsets.only(top: 30),
//                     height: 50,
//                     width: 500,
//                     child: TextButton(
//                       style: TextButton.styleFrom(
//                           backgroundColor: const Color(0xFF6777EF),
//                           shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(20),
//                           )),
//                       // onPressed: () {},
//                       onPressed: () {
//                         Navigator.push(
//                           context,
//                           MaterialPageRoute(builder: (context) => HomePage()),
//                         );
//                       },
//                       child: const Text(
//                         "Sign In",
//                         style: TextStyle(
//                           color: Color(0xffffffff),
//                         ),
//                       ),
//                     ),
//                   ),
//                 ]))));
//   }
// }