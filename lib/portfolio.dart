import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import 'constraints.dart';

int check=0;

class Portfolio extends StatefulWidget {

  @override
  State<Portfolio> createState() => _PortfolioState();
}

class _PortfolioState extends State<Portfolio> {

  @override
  int _selectedIndex = 1;
  void initState() {
    // TODO: implement initState

    check=0;
    dataFuture = fetchToknens();
    super.initState();

  }

  late var data;
  late var dataFuture;
  @override
  Widget build(BuildContext context) {
    return check==1? Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Row(
              children: [
                SizedBox(
                  width: 20,
                ),
                Container(
                  child: Icon(FontAwesomeIcons.longArrowLeft),
                  height: 50,
                  width: 50,

                ),
                SizedBox(
                  width: 15,
                ),
                Text(
                  "Plot.",
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.w500),
                )
              ],
            ),

            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                
                Padding(
                  padding: const EdgeInsets.fromLTRB(30, 20, 0, 0),
                  child: Text("@"+data['name'], style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),),
                ),
                SizedBox(width: 150,),
                Image.asset("animation/pic6.png",width: 100,),


              ],
            ),
      SizedBox(height: 50,),
      Container(
        padding: EdgeInsets.all(20),
        width: 335,
        height: 150,
        decoration: BoxDecoration(
            color: Color(0xffD3F5F3),
            borderRadius: BorderRadius.circular(20)
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("₹${data["portfolio"]} in Holdings", style: TextStyle(fontSize: 24, fontWeight: FontWeight.w400),),
            SizedBox(height: 30,),
            Text("₹${data["money"]} in plot wallet"),
          ],
        ),
      ),
SizedBox(height: 30,),


          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.monetization_on_sharp),
            label: 'Portfolio',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.amber[800],
        onTap: _onItemTapped,
      ),
    ):Center(child: CupertinoActivityIndicator());
  }
  void _onItemTapped(int index) {
    Navigator.pop(context);

  }


  dynamic fetchToknens() async {
    final prefs = await SharedPreferences.getInstance();
    final int? uid = prefs.getInt('uid');
    Map newUpdate = {"id": uid};
    final url = Uri.parse(api+"auth/user");

    final response = await http.post(url, headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',

    }, body: jsonEncode(newUpdate),);
    // print(response.body);
    if (response.statusCode == 201) {
      setState(() {
        data = json.decode(response.body)['user1'];
        print("///");
        print(data);
      });
      // print(data);
      // widget.sum = 0;
      // for (int i = 0; i < data.length; i++) {
      //   //find sum
      //
      //   widget.sum += data[i]["tokenAmount"] as int;
      //   widget.percentage_top += data[i]["movie"]["percentage"];
      // }
      // return data;
      setState(() {
        check=1;
      });
      return data;
    }
  }

}
//https://plot-backend.herokuapp.com/auth/user