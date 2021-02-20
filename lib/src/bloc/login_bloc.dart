import 'dart:async';

import 'package:login/src/bloc/validators.dart';
import 'package:rxdart/rxdart.dart';

class LoginBloc with Validators {
  final _passwordController = BehaviorSubject<String>();
  final _emailController = BehaviorSubject<String>();

  //Recuperar los datos del Stream
  Stream<String> get emailStream => _emailController.stream;
  Stream<String> get passwordStream =>
      _passwordController.stream.transform(validarPassword);

  Stream<bool> get formValidStream =>
      Rx.combineLatest2(emailStream, passwordStream, (a, b) => true);

  //Insertar valores al Stream
  Function(String) get changeEmail => _emailController.sink.add;
  Function(String) get changePassword => _passwordController.sink.add;

  //Obtener el ultimo valor ingresado de los Steams
  String get email => _emailController.value;
  String get password => _passwordController.value;
  dispose() {
    _emailController?.close();
    _passwordController?.close();
  }
}
