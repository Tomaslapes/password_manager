import 'package:flutter/material.dart';
import '../utils/password_model.dart';
import '../widgets/password_tile.dart';

class HomeScreen extends StatefulWidget {
  List<Password> mock_data = [
    Password(
      "Google","TomasLapes"),
    Password("Amazon", "tomlap")
  ];

  HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Přihlašovací údaje")),
      body: Container(
        padding: EdgeInsets.all(0),
        child: ListView.builder(
          itemCount: widget.mock_data.length,
            itemBuilder: (context, index){
          return Padding(
            padding: const EdgeInsets.fromLTRB(10,10,10,0),
            child: PasswordTile(widget.mock_data[index]),
          );
        },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: (){},
      ),
    );
  }
}
