import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';

class WebGame extends StatefulWidget {
  final String url, nombre;

  WebGame(this.url, this.nombre);

  @override
  _WebGameState createState() => _WebGameState(url, nombre);
}

class _WebGameState extends State<WebGame> {
  String url, nombre;

  final flutterWebviewPlugin = new FlutterWebviewPlugin();
  _WebGameState(this.url, this.nombre);

  @override
  void initState() {
    flutterWebviewPlugin.launch(url, rect: new Rect.fromLTWH(0, 0, 645, 365));
    Inyectar();
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.landscapeLeft, DeviceOrientation.landscapeRight]);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: Regresar,
      child: Container(),
    );
  }

  Future<String> Inyectar() async {
    flutterWebviewPlugin.onStateChanged.listen(
      (viewState) async {
        if (viewState.type == WebViewState.finishLoad) {
          flutterWebviewPlugin
              .evalJavascript("function si() {return '$nombre';}");
        }
      },
    );
  }

  Future<bool> Regresar() async{
    flutterWebviewPlugin.close();
    flutterWebviewPlugin.dispose();
    await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    Navigator.pop(context);
  }
}