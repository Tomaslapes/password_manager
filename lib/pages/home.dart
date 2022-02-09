import 'package:flutter/material.dart';
import 'package:password_manager/utils/db.dart';
import '../utils/password_model.dart';
import '../widgets/password_tile.dart';
import '../pages/create_form.dart';

class HomeScreen extends StatefulWidget {
  // List<Password> mock_data = [
  //   Password(
  //     name:"Google",uname:"TomasLapes"),
  //   Password(name:"Amazon",uname: "tomlap")
  // ];

  HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Přihlašovací údaje")),
      body: FutureBuilder<List<Password>>(
        future: DB.instance.getPasswordCredentials(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data!.isNotEmpty) {
              return Container(
                child: ListView.builder(
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                      child: PasswordTile(snapshot.data![index]),
                    );
                  },
                ),
              );
            } else {
              return Center(child: Text("Nemáte žádné přihlašovací údaje"));
            }
          } else if (snapshot.hasError) {
            return Text("Something went wrong");
          } else {
            return CircularProgressIndicator();
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => CreateForm())).then((value) => setState((){}));
        },
      ),
    );
  }
}
