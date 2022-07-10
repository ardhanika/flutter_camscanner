import 'package:flutter/material.dart';
import 'package:docscan/network/api_service.dart';
import 'package:docscan/model/data_user_model.dart';

import 'package:docscan/pages/update/form_update.dart';
import 'package:docscan/pages/document/document_detail.dart';

class Document extends StatefulWidget {
  const Document({Key? key}) : super(key: key);

  @override
  _DocumentState createState() => _DocumentState();
}

class _DocumentState extends State<Document> {
  @override
  late BuildContext context;
  late ApiService apiService;

  @override
  void initState() {
    super.initState();
    apiService = ApiService();
  }

  @override
  Widget build(BuildContext context) {
    this.context = context;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Document'),
      ),
      body: SafeArea(
        child: FutureBuilder(
          future: apiService.getDataUser(),
          builder: (BuildContext context,
              AsyncSnapshot<List<UserDataResponse>> snapshot) {
            if (snapshot.hasError) {
              return Center(
                child: Text(
                    "Something wrong with message: ${snapshot.error.toString()}"),
              );
            } else if (snapshot.connectionState == ConnectionState.done) {
              List<UserDataResponse>? datauser = snapshot.data;
              return _buildListView(datauser!);
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ),
      ),
    );
  }

  Widget _buildListView(List<UserDataResponse> datauser) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      child: ListView.builder(
        itemBuilder: (context, index) {
          UserDataResponse profile = datauser[index];
          return Card(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.max,
                    children: <Widget>[
                      InkWell(
                        child: Container(
                          child: Image(
                            height: 100,
                            width: 100,
                            image: NetworkImage(
                                "http://camscanner.putraprima.id/storage/${profile.image}"),
                          ),
                        ),
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              // builder methods always take context!
                              builder: (context) {
                                return UserDataDetail(profile);
                              },
                            ),
                          );
                        },
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              profile.nama,
                              style: Theme.of(context).textTheme.headline6,
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Text(profile.description),
                            SizedBox(
                              width: 5,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          FlatButton(
                            onPressed: () {
                              showDialog(
                                  context: context,
                                  builder: (context) {
                                    return AlertDialog(
                                      title: const Text("Warning"),
                                      content: Text(
                                          "Are you sure want to delete data profile ${profile.nama}?"),
                                      actions: <Widget>[
                                        FlatButton(
                                          child: const Text("Yes"),
                                          onPressed: () {
                                            Navigator.pop(context);
                                            apiService
                                                .deleteDataUser(profile.id)
                                                .then((response) {
                                              if (response.message ==
                                                  "success") {
                                                setState(() {});
                                                Scaffold.of(this.context)
                                                    .showSnackBar(const SnackBar(
                                                        content: Text(
                                                            "Delete data success")));
                                              } else {
                                                Scaffold.of(this.context)
                                                    .showSnackBar(const SnackBar(
                                                        content: Text(
                                                            "Delete data failed")));
                                              }
                                            });
                                          },
                                        ),
                                        FlatButton(
                                          child: const Text("No"),
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                        )
                                      ],
                                    );
                                  });
                            },
                            child: const Text(
                              "Delete",
                              style: TextStyle(color: Colors.red),
                            ),
                          ),
                          FlatButton(
                            onPressed: () async {
                              var result = await Navigator.push(context,
                                  MaterialPageRoute(builder: (context) {
                                return FormAddScreen(datauser: profile);
                              }));
                              if (result != null) {
                                setState(() {});
                              }
                            },
                            child: const Text(
                              "Edit",
                              style: TextStyle(color: Colors.blue),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
        itemCount: datauser.length,
      ),
    );
  }
}
