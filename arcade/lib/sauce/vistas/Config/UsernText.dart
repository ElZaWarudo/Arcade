import 'dart:io';
import 'package:arcade/sauce/bloc/cuenta/bloc.dart';
import 'package:arcade/sauce/vistas/Partes/TextoNombre.dart';
import 'package:arcade/sauce/vistas/Partes/UserImage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';

class UsernText extends StatefulWidget {
  final String id,email;

  UsernText({Key key, this.id, this.email}) : super(key: key);

  @override
  _UsernTextState createState() => _UsernTextState(id,email);
}

class _UsernTextState extends State<UsernText> {
  final String id,email;
  File Photo;

  _UsernTextState(this.id, this.email);
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: UserImage(),
      title: TextoNombre(),
      subtitle: RichText(
          text: TextSpan(children: [
            WidgetSpan(
                child: Icon(
                  FontAwesomeIcons.cameraRetro,
                  size: 15,
                )),
            TextSpan(
                text: "  Cambiar",
                style: TextStyle(color: Colors.black)),
          ])),
      onTap: () {
        getImage(context);
      },
    );
  }

  Future getImage(BuildContext context) async {
    PickedFile temporal = await ImagePicker().getImage(
        source: ImageSource.gallery);
    setState(() {
      Photo = File(temporal.path);
    });
    await Future.delayed(Duration(milliseconds: 50));
    BlocProvider.of<CueBloc>(context).add(ChangeImage(Photo, email, id));
  }
}
