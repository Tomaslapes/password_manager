import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import '../pages/home.dart';



class LoginManager{
  /// Helper class to do login checks and create a new password

  // Create storage
  final storage = FlutterSecureStorage();
  final String masterKeyField = "masterKey"; // Name of the field in DB
  bool userLoggedIn = false;

  Future<bool> isPassPresent() async{
    var value = await storage.read(key:masterKeyField);
    return Future.delayed(const Duration(milliseconds: 500), () {// TODO remove the delay!
      return value!=null ? true : false;;
    });
  }

  Future<bool> registerPassword(String password) async{
    // Save it to secure storage
    await storage.write(key: masterKeyField, value: password);
    // Return a bool to show the user if the operation was successful
    return Future.delayed(const Duration(milliseconds: 500), () { // TODO remove the delay!
      return true;
    });
  }

  void goHome(context){
    Timer(Duration(seconds: 1), (){
      Navigator.of(context).popUntil((route) => route.isFirst);
      Navigator.pushReplacement(context,
        MaterialPageRoute(builder: (context)=>HomeScreen()),
      );
    }
    );
  }

  Future<bool> loginUser(String password) async{
    String? stored_pass = await storage.read(key: masterKeyField);
    if(password != stored_pass){
      return Future.delayed(const Duration(milliseconds: 1000), () {// TODO remove the delay!
        return false;
      });
    }
    return Future.delayed(const Duration(milliseconds: 1000), () {// TODO remove the delay!
      return true;
    });
  }

}




