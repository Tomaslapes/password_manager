import 'package:flutter/material.dart';
import '../utils/utils.dart';

class RegisterUserWidget extends StatefulWidget {
  late final LoginManager loginManager;

  RegisterUserWidget(this.loginManager, {Key? key})
      : super(key: key);

  @override
  _RegisterUserWidgetState createState() => _RegisterUserWidgetState();
}

class _RegisterUserWidgetState extends State<RegisterUserWidget> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String? _password;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Text("Create a new password"),
          Form(
            key: _formKey,
            child: TextFormField(
              autocorrect: false,
              enableSuggestions: false,
              decoration: const InputDecoration(label: Text("Master password")),
              validator: (String? value){
                if(value?.isEmpty??true){
                  return "Password is missing";
                }
              },
              onSaved: (String? value) {
                _password = value;
                // print(value ?? "");
              },
            ),
          ),
          ElevatedButton(
              onPressed: () {
                // TODO FIXME this is a bit confusing - refactor needed
                // Validate the form
                bool res = _formKey.currentState?.validate() ?? false;
                if (!res) {
                  // print("_formkey is null");
                  return;
                }

                // Register the user
                showDialog(context: context, builder: (_){
                  return AlertDialog(
                    content: Container(
                      height: 100,
                      width: 100,
                      child: FutureBuilder(
                        future:  widget.loginManager.registerPassword(_password!),
                        builder: (context, snapshot){
                          if(snapshot.hasData){
                            if(snapshot.data==true){
                              //Success
                              widget.loginManager.goHome(context);
                              
                              return const Center(
                                child: Icon(Icons.check_circle_rounded,
                                  color: Colors.lightGreenAccent,
                                  size: 50,
                                ),
                              );
                            }else{
                              return const Text("Something went wrong.");
                            }
                          }else if(snapshot.hasError){
                            return const Text("Something went wrong.");
                          }else{
                            return const Center(child: CircularProgressIndicator());
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
              child: const Text("Create new Password"))
        ],
      ),
    );
  }
}
