import 'package:flutter/material.dart';
import '../utils/password_model.dart';

class PasswordTile extends StatelessWidget {
  Password? password;
  PasswordTile(this.password, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color:Colors.black12,width: 1)
      ),
      padding: EdgeInsets.all(20),
      height: 100,
      // width: MediaQuery.of(context).size.width,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(Icons.vpn_key_outlined),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(15,0,15,0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(password!.name),
                  Text(password!.uname)
                ],
              ),
            ),
          ),
          ElevatedButton.icon(onPressed: (){},
            icon: Icon(Icons.remove_red_eye),
            label: Text("Detail"),)
        ],
      ),
    );
  }
}
