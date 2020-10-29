import 'package:arcade/sauce/Vistas/Login/Splash.dart';
import 'file:///C:/Users/Mayor/Documents/GitHub/Arcade/arcade/lib/sauce/Vistas/Login/login_screen.dart';
import 'package:arcade/sauce/bloc/autenticacion/aut_bloc.dart';
import 'package:arcade/sauce/bloc/autenticacion/aut_event.dart';
import 'package:arcade/sauce/bloc/autenticacion/aut_state.dart';
import 'file:///C:/Users/Mayor/Documents/GitHub/Arcade/arcade/lib/sauce/bloc/delegates/reg_delegate.dart';
import 'package:arcade/sauce/repository/User_Repo.dart';
import 'package:arcade/sauce/vistas/APIs/Ads.dart';
import 'package:arcade/sauce/vistas/Home/HomeStf.dart';
import 'package:firebase_admob/firebase_admob.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_core/firebase_core.dart';

Future <void>main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  Bloc.observer = SimpleObserver();
  final UserRepo userRepo = UserRepo();
  var app = BlocProvider(
    create: (context) => AutBloc(userRepo: userRepo)
      ..add(AppStarted()),
    child: App(),
  );
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  runApp(app);
}

class App extends StatefulWidget {
  @override
  _AppState createState() => _AppState();
}



class _AppState extends State<App> {
  @override
  void initState() {
    super.initState();
    FirebaseAdMob.instance.initialize(appId: Ads.appId);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: BlocBuilder<AutBloc, AutState>(
        builder: (context, state) {
          if (state is NoInicializado) {
            return SplashScreen();
          }
          if (state is Autenticado) {
            return HomeStf(state.Email);
          }
          if (state is NoAutenticado) {
            return LoginScreen(userRepo: UserRepo());
          }
          return Container(color: Colors.orange);
        },
      ),
    );
  }
}
