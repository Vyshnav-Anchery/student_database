part of 'login_bloc.dart';

class LoginState {}

class LoginActionState extends LoginState {}

class LoginInitial extends LoginState {}

class LoginSuccessfullActionState extends LoginActionState {}

class LoginLoadingActionState extends LoginActionState {}
class LoginErrorActionState extends LoginActionState {}
