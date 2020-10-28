import 'dart:io';
import 'package:arcade/sauce/bloc/autenticacion/bloc.dart';
import 'package:arcade/sauce/bloc/cuenta/bloc.dart';
import 'package:arcade/sauce/bloc/verificacion/bloc.dart';
import 'package:arcade/sauce/repository/Cue_repo.dart';
import 'package:arcade/sauce/repository/User_Repo.dart';
import 'package:arcade/sauce/vistas/Config/UsernText.dart';
import 'package:arcade/sauce/vistas/Config/verificacion.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

class Configuracion extends StatefulWidget {
  @override
  final String id,email;
  File Photo;
  Configuracion(this.id,this.email);
  _ConfiguracionState createState() => _ConfiguracionState(id,email);
}

class _ConfiguracionState extends State<Configuracion> {
  final String id, email;
  File Photo;

  _ConfiguracionState(this.id, this.email);

  final TextStyle headerStyle = TextStyle(
    color: Colors.grey.shade800,
    fontWeight: FontWeight.bold,
    fontSize: 20.0,
  );

  @override
  Widget build(BuildContext context) {
    return BlocProvider<CueBloc>(
      create: (context) =>
      CueBloc(cueRepo: CueRepo(email))
        ..add(BuscarName()),
      child: BlocProvider<VeriBloc>(
        create: (context) => VeriBloc(userRepo: UserRepo()),
        child: Scaffold(
          backgroundColor: Colors.grey.shade200,
          appBar: AppBar(
            backgroundColor: Colors.deepPurple,
            title: Text(
              'Configuración',
            ),
          ),
          body: SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  "Cuenta",
                  style: headerStyle,
                ),
                const SizedBox(height: 10.0),
                Card(
                  elevation: 0.5,
                  margin: const EdgeInsets.symmetric(
                    vertical: 4.0,
                    horizontal: 0,
                  ),
                  child: Column(
                    children: <Widget>[
                      UsernText(id: id,email: email,),
                      _buildDivider(),
                    ],
                  ),
                ),
                const SizedBox(height: 20.0),
                Card(
                  margin: const EdgeInsets.symmetric(
                    vertical: 8.0,
                    horizontal: 0,
                  ),
                  child: Column(
                    children: <Widget>[
                      Verificacion(),
                      ListTile(
                        leading: Icon(Icons.exit_to_app),
                        title: Text("Logout"),
                        onTap: () {
                          BlocProvider.of<AutBloc>(context).add(LoggedOut());
                          Navigator.pop(context);
                        },
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 60.0),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Container _buildDivider() {
    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: 8.0,
      ),
      width: double.infinity,
      height: 1.0,
      color: Colors.grey.shade300,
    );
  }

}
