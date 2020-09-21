import 'package:arcade/sauce/bloc/juegos/jue_bloc.dart';
import 'package:arcade/sauce/bloc/cuenta/bloc.dart';
import 'package:arcade/sauce/repository/Juego_repo.dart';
import 'package:arcade/sauce/repository/Cue_repo.dart';
import 'package:arcade/sauce/repository/User_Repo.dart';
import 'package:arcade/sauce/vistas/Config/configuracion.dart';
import 'package:arcade/sauce/vistas/Partes/Tarjetas.dart';
import 'package:arcade/sauce/vistas/Partes/TextoNombre.dart';
import 'package:arcade/sauce/vistas/Partes/UserImage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Home extends StatelessWidget {
  final String name;
  final JueRepo _jueRepo = JueRepo();
  CueRepo cueRepo;
  Home({Key key, @required this.name,}) : cueRepo=CueRepo(name), super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<JueBloc>(
      create: (context) => JueBloc(jueRepo: _jueRepo)..add(LoadJue()),
      child: BlocProvider<CueBloc>(
        create: (context) => CueBloc(cueRepo: cueRepo)..add(BuscarName()),
        child:Scaffold(
          appBar: AppBar(
            title: Text('¡VArcade!',
              style: TextStyle(fontFamily: 'Audiowide'),
            ),
            backgroundColor: Colors.deepPurple,
            actions: <Widget>[
              IconButton(
                icon: const Icon(Icons.search, color: Colors.white,),
                onPressed: () {},
              ),
            ],
          ),
          drawer: Drawer(
            child: ListView(
              padding: EdgeInsets.zero,
              children: <Widget>[
                UserAccountsDrawerHeader(
                    accountName: TextoNombre(),
                    accountEmail: Text(name),
                    decoration: BoxDecoration(color: Colors.deepPurple),
                    currentAccountPicture: UserImage()
                ),
                ListTile(
                  title: Text('Records'),
                ),
                ListTile(
                    title: Text('Cuenta'),
                    onTap: (){
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => Configuracion(cueRepo, UserRepo())));
                    }
                ),
              ],
            ),
          ),
          body: Container(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Tarjetas(name),
          ),
        ),
      ),
    );
  }
}