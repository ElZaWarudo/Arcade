import 'package:arcade/sauce/bloc/name/bloc.dart';
import 'package:arcade/sauce/models/name.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserImage extends StatefulWidget {
  @override
  _UserImageState createState() => _UserImageState();
}

class _UserImageState extends State<UserImage> {
  List<Name> NameList = [];

  _UserImageState();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NameBloc, NameState>(builder: (context, state) {
      if (state is SinUsername) {
        return CircularProgressIndicator();
      }
      if (state is Fallo) {
        return Text('Algo salió mal...');
      }
      if (state is Obtenido) {
        NameList = state.name;
        return Container(
          child: NameList.length == 0
              ? CircleAvatar(backgroundImage: NetworkImage("https://0.soompi.io/wp-content/uploads/sites/8/2016/02/14030437/mystery-Man-Soompi.jpg?s=900x600&e=t"),
          backgroundColor: Colors.white,
          )
              : CircleAvatar(backgroundImage: NetworkImage(NameList[0].urlImagen),
            backgroundColor: Colors.white,
          )
        );
      }
      return Container();
    });
  }
}
