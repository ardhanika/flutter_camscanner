import 'package:docscan/pages/account.dart';
import 'package:docscan/theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({Key? key}) : super(key: key);

  @override
  _SettingPageState createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  void _launchURL() async {
    const url = 'http://127.0.0.1:8000';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
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
                  children: [
                    Icon(
                      CupertinoIcons.profile_circled,
                      size: 80,
                      color: purple,
                    ),
                    const Padding(
                      padding: EdgeInsets.only(left: 30),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Jaya Mahendra',
                          style: text,
                        ),
                        Text(
                          "Lorem ipsum ",
                          style: desc,
                        )
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
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const AccountPage()),
                          );
                        },
                        child: menuSetting(
                            'Account', 'Lorem ipsum dolor sit amet'),
                      ),
                      const Padding(padding: EdgeInsets.only(top: 25)),
                      GestureDetector(
                        onTap: _launchURL,
                        child: menuSetting(
                            'Go To Website', 'Lorem ipsum dolor sit amet'),
                      ),
                      const Padding(padding: EdgeInsets.only(top: 25)),
                      menuSetting('About App', 'Lorem ipsum dolor sit amet'),
                      const Padding(padding: EdgeInsets.only(top: 25)),
                      menuSetting('Log Out', 'Lorem ipsum dolor sit amet'),
                    ]),
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
        Icons.circle_rounded,
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
