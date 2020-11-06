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
  double width;
  double height;
  String url, nombre;

  final flutterWebviewPlugin = new FlutterWebviewPlugin();
  _WebGameState(this.url, this.nombre);

  void initState() {
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.landscapeLeft, DeviceOrientation.landscapeRight]);
    SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.bottom]);
    flutterWebviewPlugin.launch(url, withJavascript: true, rect: new Rect.fromLTWH(0, 0, 645, 365), clearCache: true);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;
    flutterWebviewPlugin.resize(new Rect.fromLTWH(0, 0, width, height));
    Inyectar();
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
              .evalJavascript("function si() {return '$nombre';} function width() {return $width;} function height() {return $height;} redim();");
        }
      },
    );
  }

  Future<bool> Regresar() async{
    flutterWebviewPlugin.close();
    flutterWebviewPlugin.dispose();
    SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values);
    await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    Navigator.pop(context);
  }
}
