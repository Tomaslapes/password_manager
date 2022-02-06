import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:password_manager/utils/password_model.dart';

class PasswordDetailScreen extends StatefulWidget {
  Password password;

  PasswordDetailScreen(this.password, {Key? key}) : super(key: key);

  @override
  _PasswordDetailScreenState createState() => _PasswordDetailScreenState();
}

class _PasswordDetailScreenState extends State<PasswordDetailScreen> {
  void callback(){
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Detail: ${widget.password.name}",overflow: TextOverflow.ellipsis,),
      ),
      body: Container(
        padding: EdgeInsets.all(20),
        child: Center(
          child: Container(
            width: 325,
            height: 150,
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Název: "),
                    Flexible(child: Text(widget.password.name,overflow: TextOverflow.ellipsis))
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Uživatelské jméno: "),
                    Flexible(child: Text(widget.password.uname,overflow: TextOverflow.ellipsis,maxLines: 3))
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Heslo: "),
                    Flexible(child: Text(widget.password.password ?? "••••••••••",maxLines: 3,)),
                    IconButton(onPressed: (){
                      if(widget.password.password!=null){
                        setState(() {
                          widget.password.password = null;
                        });
                        return;
                      }
                      widget.password.loadPassword(callback);
                      print("Show password");
                    }, icon: Icon(
                      widget.password.password==null ?
                        Icons.remove_red_eye : Icons.visibility_off
                    )),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
