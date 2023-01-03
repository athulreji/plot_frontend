import 'dart:convert';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:flutter/cupertino.dart';
import 'package:plot_frontend/constraints.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:plot_frontend/home/home.dart';
import 'package:plot_frontend/auth/login.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Signup extends StatefulWidget {
  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  late String? username;
  late String? password;
  late String name;
  late String token;
  late int uid;
  bool darkMode = false;
  bool arrow = true;

  final fieldText_username = TextEditingController();
  final fieldText_name = TextEditingController();
  final fieldText_password = TextEditingController();
  @override
  void initState() {
    // TODO: implement initState

    fieldText_password.clear();
    fieldText_username.clear();
    fieldText_name.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Container(
              margin: EdgeInsets.fromLTRB(20, 20, 20, 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: MediaQuery.of(context).size.height / 15),
                  Image.asset(
                    "animation/pic2.png",
                    height: 275,
                    width: 275,
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height / 25),
                  Neumorphic(
                    padding: EdgeInsets.all(5),
                    style: NeumorphicStyle(
                      shape: NeumorphicShape.concave,
                      boxShape:
                      NeumorphicBoxShape.roundRect(BorderRadius.circular(30)),
                      depth: -5,
                      lightSource: LightSource.topLeft,
                    ),
                    child: TextFormField(
                      cursorColor: Theme.of(context).primaryColor,
                      controller: fieldText_name,
                      keyboardType: TextInputType.name,
                      style: const TextStyle(fontSize: 16.0),
                      textAlign: TextAlign.center,
                      onSaved: (String? value) {},
                      textInputAction: TextInputAction.next,
                      decoration: const InputDecoration(
                        hintText: 'name',
                        hintStyle: TextStyle(fontWeight: FontWeight.w300),
                        border: InputBorder.none,
                      ),
                      onChanged: (value) {
                        name = value;
                        // print(username);
                      },
                    ),
                  ),
                  SizedBox(height: 25),
                  Neumorphic(
                    padding: EdgeInsets.all(5),
                    style: NeumorphicStyle(
                      shape: NeumorphicShape.concave,
                      boxShape:
                      NeumorphicBoxShape.roundRect(BorderRadius.circular(30)),
                      depth: -5,
                      lightSource: LightSource.topLeft,
                    ),
                    child: TextFormField(
                      cursorColor: Theme.of(context).primaryColor,
                      controller: fieldText_username,
                      keyboardType: TextInputType.name,
                      style: const TextStyle(fontSize: 16.0),
                      textAlign: TextAlign.center,
                      onSaved: (String? value) {},
                      textInputAction: TextInputAction.next,
                      decoration: const InputDecoration(
                        hintText: 'email id',
                        hintStyle: TextStyle(fontWeight: FontWeight.w300),
                        border: InputBorder.none,
                      ),
                      onChanged: (value) {
                        username = value;
                        // print(username);
                      },
                    ),
                  ),
                  SizedBox(height: 25),
                  Neumorphic(
                    padding: EdgeInsets.all(5),
                    style: NeumorphicStyle(
                      shape: NeumorphicShape.concave,
                      boxShape:
                      NeumorphicBoxShape.roundRect(BorderRadius.circular(30)),
                      depth: -5,
                      lightSource: LightSource.topLeft,
                    ),
                    child: TextFormField(
                      cursorColor: Theme.of(context).primaryColor,
                      controller: fieldText_password,
                      onSaved: (value) {
                        password = value;
                      },
                      keyboardType: TextInputType.name,
                      obscureText: true,
                      style: const TextStyle(fontSize: 16.0),
                      textAlign: TextAlign.center,
                      decoration: const InputDecoration(
                        hintText: 'password',
                        hintStyle: TextStyle(fontWeight: FontWeight.w300),
                        border: InputBorder.none,
                      ),
                      onChanged: (value) {
                        //    print(value);
                        password = value;
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),

                  const SizedBox(
                    height: 32,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      NeumorphicButton(
                          onPressed: () async {
                            setState(() {
                              arrow = false;
                            });
                            username_signup();
                          },
                          style: NeumorphicStyle(
                            color: darkMode ? Colors.grey[850] : Colors.grey[300],
                            shape: NeumorphicShape.flat,
                            boxShape: NeumorphicBoxShape.circle(),
                          ),
                          child: arrow
                              ? Icon(
                            FontAwesomeIcons.arrowRight,
                            color: Colors.black.withOpacity(0.6),
                          )
                              : CupertinoActivityIndicator()),
                    ],
                  )
                ],
              ),
            ),
          ),
        ));
  }


  Future username_signup() async {
    Map newUpdate2 = {
      "password": password,
      "email": username,
      "name" : name,
    };
    final url2 = Uri.parse(api+"auth/signup");

    final response2 = await http.post(
      url2,
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
      body: jsonEncode(newUpdate2),
    );
    print(response2.statusCode);
    if(response2.statusCode==201){
      final prefs = await SharedPreferences.getInstance();
      await prefs.setInt('uid', json.decode(response2.body)["user_id"]);
      uid = jsonDecode(response2.body)[uid];
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) =>  Home()),
      );
      setState(() {
        arrow = true;
      });
    }else{
      fieldText_username.clear();
      fieldText_password.clear();
      showAlertDialog(context);
      setState(() {
        arrow = true;
      });
    }
  }

  showAlertDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        content: const Text('Account already exist'),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Retry'),
          ),
        ],
      ),
    );
  }
}
