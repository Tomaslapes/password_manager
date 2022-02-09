import 'package:flutter/material.dart';
import '../utils/db.dart';
import '../utils/password_model.dart';

class CreateForm extends StatefulWidget {
  const CreateForm({Key? key}) : super(key: key);

  @override
  _CreateFormState createState() => _CreateFormState();
}

class _CreateFormState extends State<CreateForm> {
  String? _name;
  String? _uname;
  String? _password;

  double password_strength = 0.0;

  // Formfield helper methods
  Widget _buildName(){
    return TextFormField(
      decoration: const InputDecoration(
          labelText: "Name"
      ),
      validator: (String? value){
        if (value == null){
          return "Name is required";
        }
        if(value.isEmpty) {
          return "Name field cannot be left empty";
        }
      },
      onSaved: (String? value){
        _name = value;
        print(_name);
      },
    );
  }

  Widget _buildUName(){
    return TextFormField(
      decoration: const InputDecoration(
          labelText: "Username"
      ),
      validator: (String? value){
        if (value == null){
          return "Username is required";
        }
        if(value.isEmpty) {
          return "Username field cannot be left empty";
        }
      },
      onSaved: (String? value){
        _uname = value;
        print(_uname);
      },
    );
  }
  Widget _buildPassword(){
    return TextFormField(
      decoration: const InputDecoration(
          labelText: "Password"
      ),
      validator: (String? value){
        if (value == null){
          return "Password is required";
        }
        if(value.isEmpty) {
          return "Password field cannot be left empty";
        }
      },
      onChanged: (value){
        setState(() {
          password_strength = 0.0;
          if (RegExp(
              r"(?=.*?[A-Z])" //At least one upper case
          ).hasMatch(value)){
            password_strength += 0.2;
          }
          if (RegExp(
              r"(?=.*?[a-z])" //At least one lower case
          ).hasMatch(value)){
            password_strength += 0.2;
          }
          if (RegExp(
              r"(?=.*?[0-9])" //At least one digit
          ).hasMatch(value)){
            password_strength += 0.2;
          }
          if (RegExp(
              r"(?=.*?[#?!@$%^&*-])" //At least one special character
          ).hasMatch(value)){
            password_strength += 0.2;
          }
          if (RegExp(
              r".{8,}" //min 8 chars
          ).hasMatch(value)){
            password_strength += 0.2;
          }

          print(password_strength);
        });
      },
      onSaved: (String? value){
        _password = value;
        print(_password);
      },
    );
  }


  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("New password"),
      ),
      body: Container(
        padding: EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              _buildName(),
              _buildUName(),
              _buildPassword(),
              SizedBox(height: 20,),
              Text("Password Strength"),
              LinearProgressIndicator(
                value: password_strength
              ),
              SizedBox(height: 40,),
              ElevatedButton(onPressed: (){
                bool res = _formKey.currentState?.validate() ?? false;
                if (!res){
                  print("_formkey is null");
                  return;
                }

                _formKey.currentState?.save(); // will always succeeds but the linter does not see it

                Password password = Password(
                  name: _name!, // Both name and uname should be validated by the form
                  uname:_uname!, // so null check is not necessary here
                  password:_password
                );
                DB.instance.savePassword(password,()=>Navigator.pop(context));

              }, child: Text("Ulozit"))
            ],
          ),
        ),
      ),
    );
  }
}
