import 'package:arcade/sauce/bloc/juegos/jue_bloc.dart';
import 'package:arcade/sauce/repository/Juego_repo.dart';
import 'package:arcade/sauce/vistas/Home/Tarjetas.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Home extends StatelessWidget {
  final String name;
  final JueRepo _jueRepo = JueRepo();
  Home({Key key, @required this.name,}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<JueBloc>(
      create: (context) => JueBloc(jueRepo: _jueRepo)..add(LoadJue()),
      child: Scaffold(
        appBar: AppBar(
          title: Text('Home'),
          backgroundColor: Colors.deepPurple,
          actions: <Widget>[
            IconButton(
              icon: const Icon(Icons.search, color: Colors.white),
              onPressed: () {},
            ),
          ],
        ),
        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              UserAccountsDrawerHeader(
                accountName: Text(name),
                accountEmail: Text('sapoperro@sapoperro.com'),
                decoration: BoxDecoration(color: Colors.deepPurple),
                currentAccountPicture:
                    CircleAvatar(backgroundColor: Colors.white),
              ),
              ListTile(
                title: Text('Records'),
              ),
              ListTile(
                title: Text('Cuenta'),
              ),
              ListTile(
                title: Text('Cerrar sesion'),
              ),
            ],
          ),
        ),
        body: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Tarjetas(),
        ),
      ),
    );
  }
}
//BlocProvider.of<AutBloc>(context).add(LoggedOut());
