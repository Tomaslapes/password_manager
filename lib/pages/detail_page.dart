import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:password_manager/utils/password_model.dart';
import 'package:flutter/services.dart';

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

  Widget CopyToClipboard(String data){
    return IconButton(onPressed: () {
      Clipboard.setData(ClipboardData(text: data));
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Row(children: [
          Icon(Icons.check_circle_rounded,color: Colors.lightGreenAccent,),
          Text("Zkopírováno do schránky!")
        ],)),
      );
    }, icon: Icon(Icons.copy));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Detail: ${widget.password.name}",overflow: TextOverflow.fade,maxLines: 1,),
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
                    Expanded(child: Text(widget.password.name,overflow: TextOverflow.ellipsis,maxLines: 1,)),
                    CopyToClipboard(widget.password.name)
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Uživatelské jméno: "),
                    Expanded(child: Text(widget.password.uname,overflow: TextOverflow.ellipsis,maxLines: 3)),
                    CopyToClipboard(widget.password.uname)
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Heslo: "),
                    Expanded(child: Text(widget.password.password ?? "••••••••••",maxLines: 3,)),
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
                    if(widget.password.password!=null) ...[
                      CopyToClipboard(widget.password.password!)
                      ],
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
