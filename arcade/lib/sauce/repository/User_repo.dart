import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class UserRepo {
  final FirebaseAuth _firebaseAuth;
  final GoogleSignIn _googleSignIn;

  //Constructor
  UserRepo({FirebaseAuth firebaseAuth, GoogleSignIn googleSignIn})
      : _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance,
        _googleSignIn = googleSignIn ?? GoogleSignIn();

  //Login con google
  Future<User> LoginConGoogle() async {
    final GoogleSignInAccount usuarioGoogle = await _googleSignIn.signIn();
    final GoogleSignInAuthentication autGoogle =
        await usuarioGoogle.authentication;
    final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: autGoogle.accessToken, idToken: autGoogle.idToken);

    await _firebaseAuth.signInWithCredential(credential);
    return _firebaseAuth.currentUser;
  }

  //Signin
  Future<void> signIn(String email, String password) {
    return _firebaseAuth.signInWithEmailAndPassword(
        email: email, password: password);
  }

  //Registro
  Future<void> signUp(String email, String password) async {
    return _firebaseAuth.createUserWithEmailAndPassword(
        email: email, password: password);
  }

  //Deslogueo
  Future<void> signOut() async {
    return Future.wait([_firebaseAuth.signOut(), _googleSignIn.signOut()]);
  }

  //Esta logueado?
  Future<bool> estaLogueado() async {
    final currentUser = await _firebaseAuth.currentUser;
    return currentUser != null;
  }

  //Obtener usuario
  Future<String> obUsuario() async {
    return (await _firebaseAuth.currentUser).email;
  }

  Future<bool> estaVerificado() async {
    final verified = await _firebaseAuth.currentUser.emailVerified;
    return verified != null;
  }

  Future<bool> enviarEmail() async {
    await _firebaseAuth.currentUser.sendEmailVerification();
  }

  Future<bool> Verificar(String codigo) async{
    try {
      await _firebaseAuth.checkActionCode(codigo);
      await _firebaseAuth.applyActionCode(codigo);

      _firebaseAuth.currentUser.reload();
    } on FirebaseAuthException catch (e) {
      if (e.code == 'invalid-action-code') {
        print('The code is invalid.');
      }
    }
  }
}
