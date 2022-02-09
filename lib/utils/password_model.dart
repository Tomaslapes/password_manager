import 'package:password_manager/utils/db.dart';


class Password{
  final int? id;
  final String name;
  final String uname;
  String? password;
  Password({ required this.name,required this.uname, this.id, this.password});

  factory Password.fromMap(Map<String, dynamic> _map){
    // TODO FIXME probably check for nulls
    return Password(name: _map["name"]!, uname: _map["uname"]!, id: _map["id"]);
  }

  Map<String, String> toMap(){
    // This is used when inserting to DB ie. we don't need id and password
    return{
      "name":name,
      "uname":uname,
    };
  }

  void loadPassword(Function callback) async{
    if(id != null) {
      password = await DB.instance.getPassword(id!);
      // Call the callback to trigger a redraw
      callback();
    }
  }


}