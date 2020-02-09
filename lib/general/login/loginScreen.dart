import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:line_icons/line_icons.dart';
import 'package:provider/provider.dart';
import 'package:simper_walikota/bloc/loginBloc.dart';

import 'connectivityValidation.dart';

class LoginScreen extends StatelessWidget {

  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(10.0),
        child: ListView(
          children: <Widget>[
            SizedBox(height: 20.0),
            Container(
              padding: EdgeInsets.all(10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Container(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          decoration: BoxDecoration(
                            border: Border(
                              bottom: BorderSide(color: Colors.black54,width: 2, style: BorderStyle.solid)
                            )
                          ),
                          padding: EdgeInsets.only(bottom: 6.0),
                          child: Text("Selamat Datang",
                            style: TextStyle(
                                fontSize: 20.0, fontWeight: FontWeight.bold,)),
                        ),
                        SizedBox(height: 16.0),
                        Text("SIMPER",
                            style: TextStyle(
                                fontSize: 20.0, fontWeight: FontWeight.bold)),
                        SizedBox(height: 6.0),
                        Text("SISTEM INFORMASI PERSURATAN",
                            style: TextStyle(fontSize: 14.0))
                      ],
                    ),
                  ),
                  Container(
                    alignment: Alignment.topCenter,
                    child: Image.asset("assets/images/kendari.png",
                        height: 85.0, width: 85.0),
                  ),
                ],
              ),
            ),
            Divider(),

            SizedBox(
              height: 30.0,
            ),
            Container(
              padding: EdgeInsets.symmetric(vertical: 20.0),
              child: Column(
                children: <Widget>[
                  Card(
                    color: Colors.grey[100],
                    child: Container(
                      padding: EdgeInsets.all(10.0),
                      child: TextField(
                        controller: _usernameController,
                        decoration: InputDecoration(
                            prefixIcon: Icon(LineIcons.user, size: 20.0),
                            border: InputBorder.none,
                            hintText: "Username..."),
                      ),
                    ),
                  ),
                  SizedBox(height: 18.0),
                  Consumer<LoginBloc>(
                    builder: (context, loginBloc, _) => Card(
                      color: Colors.grey[100],
                      elevation: 1.0,
                      child: Container(
                        padding: EdgeInsets.all(6.0),
                        child: TextField(
                          controller: _passwordController,
                          obscureText: loginBloc.obscure,
                          decoration: InputDecoration(
                              prefixIcon:
                                  Icon(LineIcons.lock, size: 20.0),
                              border: InputBorder.none,
                              suffixIcon: IconButton(
                                padding: EdgeInsets.all(0.0),
                                icon: Icon(
                                    loginBloc.obscure
                                        ? LineIcons.eye_slash
                                        : LineIcons.eye,
                                    size: 22.0),
                                onPressed: () {
                                  loginBloc.obscure
                                      ? loginBloc.obscure = false
                                      : loginBloc.obscure = true;
                                },
                              ),
                              hintText: "Password..."),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 38.0),
                  Container(
                    padding: EdgeInsets.only(right: 6.0),
                    alignment: Alignment.topRight,
                    child: MaterialButton(
                      elevation: 1.0,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(4.0)),
                      onPressed: () {
                        // Navigator.of(context).pushReplacementNamed("/navbaropd");
                        getConnection(context, _usernameController.text, _passwordController.text);
                      },
                      color: Colors.lightBlue,
                      child: Text("Masuk",
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold)),
                    ),
                  ),
                  SizedBox(height: 20.0),
                  // FlatButton(
                  //   child: Text("Lupa Password?"),
                  //   onPressed: () {},
                  // )
                ],
              ),
            )
          ],
        ),
      ),
    //   bottomNavigationBar: Container(
    //     padding: EdgeInsets.all(30.0),
    //     child: Column(
    //       mainAxisAlignment: MainAxisAlignment.center,
    //       mainAxisSize: MainAxisSize.min,
    //       crossAxisAlignment: CrossAxisAlignment.center,
    //       children: <Widget>[
    //         Text("Powered By : "),
    //         SizedBox(height: 10.0),
    //         Image.asset("assets/images/ts.png", width: 120.0)
    //       ],
    //     ),
    //   ),
    );
  }
}
