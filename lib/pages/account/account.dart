import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:docscan/component/theme.dart';

class AccountPage extends StatefulWidget {
  const AccountPage({Key? key}) : super(key: key);

  @override
  _AccountPageState createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
          child: SafeArea(
              child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                GestureDetector(
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                    child: Icon(Icons.arrow_back_ios)),
                Text(
                  'Account',
                  style: title,
                ),
              ],
            ),
            Padding(padding: EdgeInsets.only(top: 40)),
            Center(
              child: Column(
                children: [
                  Icon(
                    CupertinoIcons.profile_circled,
                    size: 80,
                    color: purple,
                  ),
                  Padding(padding: EdgeInsets.only(top: 10)),
                  Text(
                    "Change Profile Picture",
                    style: text,
                  )
                ],
              ),
            ),
            Padding(padding: EdgeInsets.only(top: 40)),
            menuAccount("Nama", "Jaya Mahendra"),
            Padding(padding: EdgeInsets.only(top: 20)),
            menuAccount("Email", "jayamahendra490@gmail.com"),
            Padding(padding: EdgeInsets.only(top: 20)),
            menuAccount("No Telepon", "082337709390"),
            Padding(padding: EdgeInsets.only(top: 20)),
            menuAccount2("Jenis Kelamin", "Laki-Laki"),
            Padding(padding: EdgeInsets.only(top: 20)),
            menuAccount2("Tanggal Lahir", "29 Februari 1997"),
            Padding(padding: EdgeInsets.only(top: 20)),
          ],
        ),
      ))),
    );
  }

  Row menuAccount2(String data, data1) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              data,
              style: text,
            ),
            Text(
              data1,
              style: desc,
            )
          ],
        ),
      ],
    );
  }

  Row menuAccount(String data, data1) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              data,
              style: text,
            ),
            Text(
              data1,
              style: desc,
            )
          ],
        ),
        Icon(
          CupertinoIcons.pencil_circle_fill,
          size: 45,
          color: purple,
        ),
      ],
    );
  }
}
