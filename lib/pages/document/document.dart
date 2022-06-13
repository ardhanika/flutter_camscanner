import 'package:docscan/model/store_data_user_request.dart';
import 'package:flutter/material.dart';
import 'package:docscan/network/api_service.dart';
import 'package:docscan/model/data_user_model.dart';

import '../update/form_update.dart';

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
    return SafeArea(
      child: FutureBuilder(
        future: apiService.getDataUser(),
        builder: (BuildContext context, AsyncSnapshot<UserResponse> snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text(
                  "Something wrong with message: ${snapshot.error.toString()}"),
            );
          } else if (snapshot.connectionState == ConnectionState.done) {
            List<UserDataResponse>? datauser = snapshot.data?.data;
            return _buildListView(datauser!);
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }

  Widget _buildListView(List<UserDataResponse> datauser) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      child: ListView.builder(
        itemBuilder: (context, index) {
          UserDataResponse profile = datauser[index];
          return Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      profile.nama,
                      style: Theme.of(context).textTheme.headline6,
                    ),
                    Text(profile.description),
                    Text(profile.image),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
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
                                              .deleteDataUser(
                                            StoreDataUserRequest(
                                              idUser: profile.idUser,
                                              nama: profile.nama,
                                              description: profile.description,
                                              image: profile.image,
                                            ),
                                          )
                                              .then((response) {
                                            if (response.isSuccess) {
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
              ),
            ),
          );
        },
        itemCount: datauser.length,
      ),
    );
  }
}

// II
// import 'dart:convert';
// import 'package:docscan/network/api_service.dart';
// import 'package:flutter/material.dart';
// import 'package:docscan/theme.dart';
// import 'package:http/http.dart' as http;

// import '../model/data_user_model.dart';

// class Document extends StatefulWidget {
//   const Document({Key? key}) : super(key: key);

//   @override
//   _DocumentState createState() => _DocumentState();
// }

// class _DocumentState extends State<Document> {
//   final ApiService _apiService = ApiService();
//   final String apiUrl = "http://127.0.0.1:8000/api/scanner/";
//   Future<List<dynamic>> _fecthDataUsers() async {
//     var result = await http.get(Uri.parse(apiUrl));
//     return json.decode(result.body)['data'];
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Your Document'),
//       ),
//       body: Container(
//         child: FutureBuilder<dynamic>(
//           future: _apiService.getDataUser(1),
//           builder: (BuildContext context, AsyncSnapshot snapshot) {
//             if (snapshot.hasData) {
//               final _userResponse = snapshot.data as UserResponse;
//               return ListView.builder(
//                   padding: EdgeInsets.all(10),
//                   itemCount: _userResponse.data.length,
//                   itemBuilder: (BuildContext context, int index) {
//                     return ListTile(
//                       leading: CircleAvatar(
//                         radius: 30,
//                         backgroundImage:
//                             NetworkImage(_userResponse.data[index].image),
//                       ),
//                       title: Text(_userResponse.data[index].nama),
//                       subtitle: Text(_userResponse.data[index].description),
//                     );
//                   });
//             } else {
//               return Center(child: CircularProgressIndicator());
//             }
//           },
//         ),
//       ),
//     );
//   }
// }


//I
  // Widget build(BuildContext context) {
  //   return SafeArea(
  //     child: FutureBuilder<List<dynamic>>(
  //       future: _fecthDataUsers(),
  //       builder: (BuildContext context, AsyncSnapshot snapshot) => Padding(
  //         padding: const EdgeInsets.all(20),
  //         child: Column(
  //           crossAxisAlignment: CrossAxisAlignment.start,
  //           children: [
  //             Text(snapshot.data[index]['nama']),
  //             Container(
  //               padding: EdgeInsets.only(top: 10),
  //               child: Text(
  //                 'Your Document \nFiles',
  //                 style: title,
  //               ),
  //             ),
  //             Container(
  //               padding: const EdgeInsets.fromLTRB(20, 5, 5, 5),
  //               margin: const EdgeInsets.all(30),
  //               decoration: BoxDecoration(
  //                   color: const Color(0x1a34395E),
  //                   borderRadius: BorderRadius.circular(50)),
  //               child: const TextField(
  //                 decoration: InputDecoration(
  //                     icon: Icon(Icons.search),
  //                     enabledBorder: InputBorder.none,
  //                     focusedBorder: InputBorder.none,
  //                     hintText: "Search data",
  //                     hintStyle: TextStyle(fontSize: 12)),
  //               ),
  //             ),
  //             Image.asset("assets/images/undraw_home.png"),
  //             Column(
  //               children: [
  //                 Container(
  //                   padding: const EdgeInsets.all(10),
  //                 ),
  //                 Text(
  //                   "You don't have any documents!",
  //                   style: text,
  //                 ),
  //                 Container(
  //                   padding: const EdgeInsets.all(10),
  //                 ),
  //                 Center(
  //                     child: Text(
  //                   "Scan now to save your documents and storage efficiency",
  //                   style: desc,
  //                   textAlign: TextAlign.center,
  //                 ))
  //               ],
  //             ),
  //           ],
  //         ),
  //       ),
  //     ),
  //   );
  // }
// }