import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import 'bloc/loginBloc.dart';
import 'bloc/mailBloc.dart';
import 'bloc/noticationCount.dart';
import 'general/splash/splashScreen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
      ),
    );

    return MultiProvider(
      providers: [
        ChangeNotifierProvider<LoginBloc>(
          create: (context) => LoginBloc(),
        ),
        ChangeNotifierProvider<DetailMailBloc>(
          create: (context) => DetailMailBloc(),
        ),
        ChangeNotifierProvider<DetailMailDisposisiBloc>(
          create: (context) => DetailMailDisposisiBloc(),
        ),
        ChangeNotifierProvider<AddDispositionBloc>(
            create: (context) => AddDispositionBloc()),
        ChangeNotifierProvider<CheckPDF>(create: (context) => CheckPDF()),
        ChangeNotifierProvider<AddMailInBloc>(
          create: (context) => AddMailInBloc(),
        ),
        ChangeNotifierProvider<ChangeCommandDisposistion>(
          create: (context) => ChangeCommandDisposistion(),
        ),
        ChangeNotifierProvider<NotificationCount>(
          create: (context) => NotificationCount(),
        )
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: "Simper App",
        home: SplashScreen(),
        theme: ThemeData(
          scaffoldBackgroundColor: Colors.white,
          primaryColor: Colors.blueAccent,
          fontFamily: 'SanFrancisco',
        ),
      ),
    );
  }
}
