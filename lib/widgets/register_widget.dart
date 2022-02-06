import 'dart:async';

import 'package:flutter/material.dart';
import '../utils/utils.dart';

class RegisterUserWidget extends StatefulWidget {
  LoginManager? loginManager;

  RegisterUserWidget(LoginManager this.loginManager, {Key? key})
      : super(key: key);

  @override
  _RegisterUserWidgetState createState() => _RegisterUserWidgetState();
}

class _RegisterUserWidgetState extends State<RegisterUserWidget> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text("Create a new password"),
          Form(
            key: _formKey,
            child: TextFormField(
              autocorrect: false,
              enableSuggestions: false,
              decoration: InputDecoration(label: Text("Master password")),
              validator: (String? value){
                if(value?.isEmpty??true){
                  return "Password is missing";
                }
              },
              onSaved: (String? value) {
                print(value ?? "");
              },
            ),
          ),
          ElevatedButton(
              onPressed: () {
                // TODO FIXME this is a bit confusing - refactor needed
                // Validate the form
                bool res = _formKey.currentState?.validate() ?? false;
                if (!res) {
                  print("_formkey is null");
                  return;
                }

                // Register the user
                showDialog(context: context, builder: (_){
                  return AlertDialog(
                    content: Container(
                      height: 100,
                      width: 100,
                      child: FutureBuilder(
                        future:  widget.loginManager!.registerPassword(),
                        builder: (context, snapshot){
                          if(snapshot.hasData){
                            if(snapshot.data==true){
                              //Success
                              Timer(Duration(seconds: 2), ()=>Navigator.pushReplacement(context,
                                MaterialPageRoute(builder: (context)=>(
                                    Text("HOME")
                                )),
                              ));
                              
                              return Center(
                                child: Icon(Icons.check_circle_rounded,
                                  color: Colors.lightGreenAccent,
                                  size: 50,
                                ),
                              );
                            }else{
                              return Text("Something went wrong.");
                            }
                          }else if(snapshot.hasError){
                            return Text("Something went wrong.");
                          }else{
                            return Center(child: CircularProgressIndicator());
                          }
                          ;
                        },
                      ),
                    )
                  );
                });

                _formKey.currentState
                    ?.save(); // will always succeeds but the linter does not see it
              },
              child: Text("Create new Password"))
        ],
      ),
    );
  }
}
