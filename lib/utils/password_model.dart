class Password{
  final int? id;
  final String name;
  final String uname;
  final String? password;
  Password({ required this.name,required this.uname, this.id, this.password});

  factory Password.fromMap(Map<String, dynamic> _map){
    // TODO FIXME probably check for nulls
    return Password(name: _map["name"]!, uname: _map["uname"]!);
  }

  Map<String, String> toMap(){
    return{
      "name":name,
      "uname":uname,
    };
  }


}