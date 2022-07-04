import 'package:docscan/component/splash3.dart';
import 'package:docscan/pages/login/bloc/auth_bloc.dart';
import 'theme.dart';
import 'package:flutter/material.dart';

class Splash2 extends StatelessWidget {
  late final AuthBloc authBloc = authBloc;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                  Container(
                    padding: const EdgeInsets.only(top: 40, bottom: 20),
                    child: Image.asset("assets/images/mobileweb.png"),
                  ),
                  Text("Progressive App", style: desc),
                  Text("You can view all data on both devices.", style: title),
                  const Padding(padding: EdgeInsets.only(top: 30)),
                  SizedBox(
                    child: Container(
                      height: 50,
                      width: 500,
                      child: TextButton(
                        style: TextButton.styleFrom(
                            backgroundColor: const Color(0xFF6777EF),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            )),
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>Splash3()
                                ),
                              );
                        },
                        child: const Text(
                          "Next",
                          style: TextStyle(
                            color: Color(0xffffffff),
                          ),
                        ),
                      ),
                    ),
                  ),
                ]))));
  }
}