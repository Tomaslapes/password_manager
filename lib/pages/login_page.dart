import 'package:flutter/material.dart';
import '../utils/utils.dart';
import '../widgets/register_widget.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final LoginManager _loginManager = LoginManager();
  
  @override
  Widget build(BuildContext context) {
    Future<bool> res = _loginManager.isPassPresent();

    return Scaffold(
      body: Center(
        child: FutureBuilder(
          future: res,
          builder: (context, snapshot){
            if(snapshot.hasData) {
              //Show either login or create new password
              if(snapshot.data == null){
                // null safety
                return Text("Something went wrong");
              }else if(snapshot.data == true){
                // Login screen
                return Text("Login");
              }else{
                // Register a new password
                return RegisterUserWidget(_loginManager);
              }

            }else if(snapshot.hasError){
              return Text("Something went wrong");
            }else{
              return CircularProgressIndicator();
            }
          },
        ),
      ),
    );
  }
}


