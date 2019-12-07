import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_login_crud/pages/powerPage.dart';
import 'package:flutter_login_crud/pages/vendedPage.dart';
import 'package:http/http.dart' as http;

void main() => runApp(LoginApp());

String username;

class LoginApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'flutter mysql',
      home: LoginPage(),
      routes: <String, WidgetBuilder>{
        '/powerPage': (BuildContext context) => new Power(),
        '/vendedPage': (BuildContext context) => new Vended(),
        '/loginPage': (BuildContext context) => LoginPage(),
      },
    );
  }
}

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController controllerUser = new TextEditingController();
  TextEditingController controllerPass = new TextEditingController();

  String Message = '';

  Future<List> login() async {
    final response = await http.post("http://10.10.1.21/coba", body: {
      "username": controllerUser.text,
      "password": controllerPass.text,
    });

    var datauser = json.decode(response.body);

    if (datauser.length == 0) {
      setState(() {
        Message = "apa ni ? ";
      });
    } else {
      if (datauser[0]['anjir'] == 'admin') {
        Navigator.pushReplacementNamed(context, '/powerPage');
      } else if (datauser[0]['anjir'] == 'super admin') {
        Navigator.pushReplacementNamed(context, 'vendedPage');
      }
      setState(() {
        username = datauser[0]['username'];
      });
    }
    return datauser;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      body: Form(
        child: Container(
          decoration: new BoxDecoration(color: Colors.black),
          child: Column(
            children: <Widget>[
              new Container(
                  padding: EdgeInsets.only(
                    top: 170.0,
                  ),
                  child: new CircleAvatar(
                    backgroundColor: Colors.black,
                    child: new Image(
                      width: 135,
                      height: 123,
                      image: new AssetImage('assets/images/users2.jpg'),
                    ),
                  ),
                  width: 400.0,
                  height: 400.0,
                  decoration: BoxDecoration(shape: BoxShape.circle)),
              Container(
                height: MediaQuery.of(context).size.height / 2,
                width: MediaQuery.of(context).size.width,
                padding: EdgeInsets.only(top: 50),
                child: Column(
                  children: <Widget>[
                    Container(
                      width: MediaQuery.of(context).size.width / 1.2,
                      padding: EdgeInsets.only(
                          top: 4, left: 16, right: 16, bottom: 4),
                      decoration: BoxDecoration(
                          borderRadius: new BorderRadius.only(
                            topLeft: new Radius.circular(20.0)
                          ),
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(color: Colors.black12, blurRadius: 5)
                          ]),
                      child: TextFormField(
                        controller: controllerUser,
                        decoration: InputDecoration(
                            icon: Icon(
                              Icons.tag_faces,
                              color: Colors.black,
                            ),
                            hintText: 'Nama Pengguna'),
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width / 1.2,
                      height: 50,
                      margin: EdgeInsets.only(top: 32),
                      padding: EdgeInsets.only(
                          top: 4, left: 16, right: 16, bottom: 4),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(100.0)),
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black12,
                              blurRadius: 5,
                            )
                          ]),
                      child: TextField(
                        controller: controllerPass,
                        obscureText: true,
                        decoration: InputDecoration(
                            icon: Icon(
                              Icons.vpn_key,
                              color: Colors.black,
                            ),
                            hintText: 'Sandi'),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
