import 'dart:io';

import 'package:flutter/material.dart';
import 'package:docscan/network/api_service.dart';
import 'package:docscan/model/data_user_model.dart';

import '/model/update_data_user_request.dart';

final GlobalKey<ScaffoldState> _scaffoldState = GlobalKey<ScaffoldState>();

class FormAddScreen extends StatefulWidget {
  UserDataResponse datauser;

  FormAddScreen({required this.datauser});

  @override
  _FormAddScreenState createState() => _FormAddScreenState();
}

class _FormAddScreenState extends State<FormAddScreen> {
  bool _isLoading = false;
  ApiService _apiService = ApiService();
  late bool _isFieldNamaValid;
  late bool _isFieldDescriptionValid;
  late bool _isFieldImageValid;
  TextEditingController _controllerNama = TextEditingController();
  TextEditingController _controllerDescription = TextEditingController();
  TextEditingController _controllerImage = TextEditingController();

  @override
  void initState() {
    if (widget.datauser != null) {
      _isFieldNamaValid = true;
      _controllerNama.text = widget.datauser.nama;
      _isFieldDescriptionValid = true;
      _controllerDescription.text = widget.datauser.description;
      _isFieldImageValid = true;
      _controllerImage.text = widget.datauser.image;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldState,
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        title: Text(
          widget.datauser == null ? "Form Add" : "Change Data",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Stack(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                _buildTextFieldName(),
                _buildTextFieldEmail(),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: RaisedButton(
                    child: Text(
                      widget.datauser == null
                          ? "Submit".toUpperCase()
                          : "Update Data".toUpperCase(),
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    onPressed: () {
                      if (_isFieldNamaValid == null ||
                          _isFieldDescriptionValid == null ||
                          _isFieldImageValid == null ||
                          !_isFieldNamaValid ||
                          !_isFieldDescriptionValid ||
                          !_isFieldImageValid) {
                        _scaffoldState.currentState!.showSnackBar(
                          SnackBar(
                            content: Text("Please fill all field"),
                          ),
                        );
                        return;
                      }
                      setState(() => _isLoading = true);
                      String nama = _controllerNama.text.toString();
                      String description =
                          _controllerDescription.text.toString();
                      UpdateDataUserRequest dataUser = UpdateDataUserRequest(
                          idUser: 1, nama: nama, description: description);

                      dataUser =
                          dataUser.copyWith(idUser: widget.datauser.idUser);
                      _apiService
                          .updateDataUser(dataUser, widget.datauser.id)
                          .then((response) {
                        setState(() => _isLoading = false);
                        if (response.message == "success") {
                          Navigator.pop(
                              _scaffoldState.currentState!.context, true);
                        } else {
                          _scaffoldState.currentState!.showSnackBar(SnackBar(
                            content: Text("Update data failed"),
                          ));
                        }
                      });
                    },
                    color: Colors.orange[600],
                  ),
                )
              ],
            ),
          ),
          _isLoading
              ? Stack(
                  children: <Widget>[
                    Opacity(
                      opacity: 0.3,
                      child: ModalBarrier(
                        dismissible: false,
                        color: Colors.grey,
                      ),
                    ),
                    Center(
                      child: CircularProgressIndicator(),
                    ),
                  ],
                )
              : Container(),
        ],
      ),
    );
  }

  Widget _buildTextFieldName() {
    return TextField(
      controller: _controllerNama,
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
        labelText: "File Name",
        errorText: _isFieldNamaValid == null || _isFieldNamaValid
            ? null
            : "File name is required",
      ),
      onChanged: (value) {
        bool isFieldValid = value.trim().isNotEmpty;
        if (isFieldValid != _isFieldNamaValid) {
          setState(() => _isFieldNamaValid = isFieldValid);
        }
      },
    );
  }

  Widget _buildTextFieldEmail() {
    return TextField(
      controller: _controllerDescription,
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
        labelText: "Description",
        errorText: _isFieldDescriptionValid == null || _isFieldDescriptionValid
            ? null
            : "Description is required",
      ),
      onChanged: (value) {
        bool isFieldValid = value.trim().isNotEmpty;
        if (isFieldValid != _isFieldDescriptionValid) {
          setState(() => _isFieldDescriptionValid = isFieldValid);
        }
      },
    );
  }
}
