import 'package:docscan/pages/account/account.dart';
import 'package:docscan/component/theme.dart';
import 'package:docscan/pages/login/bloc/auth_bloc.dart';
import 'package:docscan/pages/login/bloc/auth_repository.dart';
import 'package:docscan/pages/login/login.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({Key? key}) : super(key: key);

  @override
  _SettingPageState createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  late final AuthBloc authBloc = AuthBloc(authRepository: AuthRepository());

  void _launchURL() async {
    const url = 'http://camscanner.putraprima.id';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  logOut() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      preferences.remove("token_sanctum");
    });

    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => LoginPage(authBloc: authBloc)));
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Setting',
                style: title,
              ),
              Container(
                padding: const EdgeInsets.only(top: 30, left: 30),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(
                      children: [
                        Icon(
                          Icons.folder_rounded,
                          size: 80,
                          color: purple,
                        ),
                        Text(
                          'Camscanner',
                          style: text,
                        ),
                        Text(
                          "Tugas Akhir Camscanner",
                          style: desc,
                        ),
                      ],
                    )
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.only(left: 20, top: 40),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // GestureDetector(
                      //   onTap: () {
                      //     Navigator.push(
                      //       context,
                      //       MaterialPageRoute(
                      //           builder: (context) => const AccountPage()),
                      //     );
                      //   },
                      //   child: menuSetting(
                      //       'Account', 'Details about your account'),
                      // ),
                      const Padding(padding: EdgeInsets.only(top: 50)),
                      GestureDetector(
                        onTap: _launchURL,
                        child: menuSetting('Go To Website', 'Open website'),
                      ),
                      // const Padding(padding: EdgeInsets.only(top: 25)),
                      // menuSetting('About App', 'Lorem ipsum dolor sit amet'),
                      const Padding(padding: EdgeInsets.only(top: 25)),
                      GestureDetector(
                        onTap: () async {
                          SharedPreferences pref =
                              await SharedPreferences.getInstance();
                          await pref.clear();
                          Navigator.of(context).pushAndRemoveUntil(
                              MaterialPageRoute(
                                builder: (context) =>
                                    LoginPage(authBloc: authBloc),
                              ),
                              (route) => false);
                        },
                        child: menuSetting('Logout', 'Logout App'),
                      ),
                    ]),
              ),
              const Padding(padding: EdgeInsets.only(top: 150)),
              const Align(
                alignment: Alignment.bottomCenter,
                child: Text("©Ardhanika Jaya 2022"),
              )
            ],
          ),
        ),
      ),
    );
  }

  Row menuSetting(String data, String data1) {
    return Row(children: [
      Icon(
        Icons.document_scanner,
        color: purple,
        size: 40,
      ),
      Container(
        padding: const EdgeInsets.only(left: 10),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [Text(data, style: text), Text(data1, style: desc)]),
      ),
    ]);
  }
}
