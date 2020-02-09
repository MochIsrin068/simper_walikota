import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:line_icons/line_icons.dart';
import 'package:simper_walikota/general/account/AccountScreen.dart';
import 'package:simper_walikota/ui/home/homeScreen.dart';
import 'package:simper_walikota/ui/mailDispositioned.dart/mailDispositionedScreen.dart';
import 'package:simper_walikota/ui/mailIn/mailInScreen.dart';


class NavigationBar extends StatefulWidget {
  final String username;
  final String password;

  NavigationBar({this.username, this.password});

  @override
  _NavigationBarState createState() => _NavigationBarState();
}

class _NavigationBarState extends State<NavigationBar>
    with SingleTickerProviderStateMixin {
  TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(length: 4, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
      ),
    );

    return Scaffold(
      body: TabBarView(
        physics: NeverScrollableScrollPhysics(),
        controller: _tabController,
        children: <Widget>[
          HomeScreen(
            username: widget.username,
            password: widget.password,
          ),
          MailInScreen(),
          MailDispositioned(),
          // MailDataInScreen(),
          AccountScreen()
        ],
      ),
      bottomNavigationBar: Material(
        elevation: 10.0,
        color: Colors.white,
        child: TabBar(
          labelStyle: TextStyle(fontSize: 10.0, fontWeight: FontWeight.w600),
          indicatorColor: Colors.transparent,
          unselectedLabelColor: Colors.grey,
          labelColor: Colors.lightBlue,
          controller: _tabController,
          tabs: <Widget>[
            Tab(icon: Icon(LineIcons.home), text: "Home",),
            Tab(icon: Icon(LineIcons.envelope), text : "Surat Masuk"),
            Tab(icon: Icon(LineIcons.check_circle), text: "Surat Terdisposisi",),
            Tab(icon: Icon(LineIcons.user), text : "Akun"),
          ],
        ),
      ),
    );
  }
}
