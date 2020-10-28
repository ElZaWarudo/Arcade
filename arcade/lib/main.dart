import 'package:arcade/sauce/Vistas/Login/Splash.dart';
import 'file:///C:/Users/Mayor/Documents/GitHub/Arcade/arcade/lib/sauce/Vistas/Login/login_screen.dart';
import 'package:arcade/sauce/bloc/autenticacion/aut_bloc.dart';
import 'package:arcade/sauce/bloc/autenticacion/aut_event.dart';
import 'package:arcade/sauce/bloc/autenticacion/aut_state.dart';
import 'file:///C:/Users/Mayor/Documents/GitHub/Arcade/arcade/lib/sauce/bloc/delegates/reg_delegate.dart';
import 'package:arcade/sauce/repository/User_Repo.dart';
import 'package:arcade/sauce/vistas/Home/HomeStf.dart';
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
    child: App(userRepo: userRepo),
  );
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  runApp(app);
}

class App extends StatelessWidget {
  final UserRepo _userRepo;

  App({Key key, @required UserRepo userRepo})
      : assert (userRepo != null),
        _userRepo = userRepo,
        super(key: key);

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
            return LoginScreen(userRepo: _userRepo,);
          }
          return Container(color: Colors.orange);
        },
      ),
    );
  }
}