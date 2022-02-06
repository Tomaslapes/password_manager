import 'package:flutter_secure_storage/flutter_secure_storage.dart';


class LoginManager{
  // Create storage
  final storage = FlutterSecureStorage();

  Future<bool> isPassPresent() async{
    var value = await storage.read(key:"masterKey");
    return Future.delayed(const Duration(milliseconds: 3000), () {
      return value!=null ? true : false;;
    });
  }

  Future<bool> registerPassword() async{
    // Hash the password
    // Save it to secure storage
    // Return a bool to show the user if the operation was successful
    return Future.delayed(const Duration(milliseconds: 3000), () {
      return true;
    });
  }

}




