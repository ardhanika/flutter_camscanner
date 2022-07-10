// dog_detail_page.dart

import 'package:flutter/material.dart';

import 'package:docscan/model/data_user_model.dart';

class UserDataDetail extends StatefulWidget {
  final UserDataResponse user;

  UserDataDetail(this.user);

  @override
  _UserDataDetailState createState() => _UserDataDetailState();
}

class _UserDataDetailState extends State<UserDataDetail> {
  // Arbitrary size choice for styles
  final double dogAvatarSize = 150.0;

  Widget get scannedImage {
    // Containers define the size of its children.
    return SingleChildScrollView(
      child: Center(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            // This is how you add an image to a Container's background.
            children: [
              Text(' ${widget.user.nama}',
                  style: Theme.of(context).textTheme.headline4),
              Text(
                widget.user.description,
                style: Theme.of(context).textTheme.subtitle1,
              ),
              Container(
                decoration: BoxDecoration(
                    border: Border.all(width: 5, color: Colors.blueAccent)),
                child: Image(
                  fit: BoxFit.cover,
                  image: NetworkImage(
                      "http://camscanner.putraprima.id/storage/${widget.user.image}"),
                  // width: 500,
                  // height: 475,
                ),
              ),
            ]),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // This is a new page, so you need a new Scaffold!
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Details Image'),
      ),
      body: scannedImage,
    );
  }
}
