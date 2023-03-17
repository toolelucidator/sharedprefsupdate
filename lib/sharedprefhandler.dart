import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:fluttertoast/fluttertoast.dart';

class PrefPage extends StatefulWidget {
  const PrefPage({Key? key}) : super(key: key);

  @override
  State<PrefPage> createState() => _PrefPageState();
}

class _PrefPageState extends State<PrefPage> {
  TextEditingController _controllerUser = TextEditingController();
  TextEditingController _controllerPass = TextEditingController();
  String _user = "";
  String _pass = "";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    CheckData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              _user,
              style: TextStyle(fontSize: 30, color: Colors.blue),
            ),
            Text(
              _pass,
              style: TextStyle(fontSize: 30, color: Colors.blue),
            ),
            TextField(
              controller: _controllerUser,
              decoration: const InputDecoration(
                hintText: 'Enter your name',
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            TextField(
              controller: _controllerPass,
              decoration: const InputDecoration(
                hintText: 'Enter your password',
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            MaterialButton(
              onPressed: () {
                SaveData(_controllerUser.text, _controllerPass.text);
              },
              child: Text("Guardar Datos"),
              color: Colors.redAccent,
            ),
            const SizedBox(
              height: 30,
            ),
            MaterialButton(
              onPressed: () {
                DeleteData();
              },
              child: Text("Eliminar Datos"),
              color: Colors.redAccent,
            ),
            const SizedBox(
              height: 30,
            ),
          ],
        ),
      ),
    );
  }

  Future<void> SaveData(String user, String pass) async {
    final sharedprefs = await SharedPreferences.getInstance();
    await sharedprefs.setString("user", user);
    await sharedprefs.setString("password", pass);
    setState(() {
      _user = user;
      _pass = pass;
    });
  }

  Future<void> CheckData() async {
    final sharedprefs = await SharedPreferences.getInstance();
    Object? user = await sharedprefs.getString("user");
    Object? pass = await sharedprefs.getString("password");

    print(user);
    print(pass);

    if (user == null || pass == null) {
      Fluttertoast.showToast(
          msg: "No hay datos",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.black,
          textColor: Colors.white);
    } else {
      Fluttertoast.showToast(
          msg: "USUARIO LOGUEADO",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.black,
          textColor: Colors.white);
      setState(() {
        _user = user.toString();
        _pass = pass.toString();
      });
    }
  }

  Future<void> DeleteData() async {
    final sharedprefs = await SharedPreferences.getInstance();
    if (sharedprefs.containsKey("user") &&
        sharedprefs.containsKey("password")) {
      await sharedprefs.remove("user");
      await sharedprefs.remove("password");
      Fluttertoast.showToast(
          msg: "Datos Eliminados",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.black,
          textColor: Colors.white);
    }
  }


}
