import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:page_transition/page_transition.dart';
import 'package:plot_frontend/home/Hometop.dart';
import 'package:plot_frontend/home/hotOptions.dart';
import 'package:http/http.dart' as http;
import 'package:plot_frontend/portfolio.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _selectedIndex = 0;
  @override
  void initState() {
    // TODO: implement initState
    dataFuture = fetchToknens();

    super.initState();
  }

  late var data;
  late var dataFuture;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            child: Column(
              children: [
                SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    SizedBox(
                      width: 20,
                    ),
                    Container(
                      child: Icon(FontAwesomeIcons.infinity),
                      height: 50,
                      width: 50,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(
                            color: Colors.black,
                          ),
                          borderRadius: BorderRadius.all(Radius.circular(50))),
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
                SizedBox(
                  height: MediaQuery.of(context).size.height / 15,
                ),
                HomeTop(),
                SizedBox(height: 20,),
                GestureDetector(
                  onTap: ()async{
                    fetchToknens();
                  },
                    child: HotOptions()),
                SizedBox(height: 30,),
              ],
            ),
            decoration: BoxDecoration(color: Colors.white),
          ),
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
    );
  }

  void _onItemTapped(int index) {
    Navigator.push(context, PageTransition(type: PageTransitionType.rightToLeft, child: Portfolio()));

  }
  dynamic fetchToknens() async {
    final url =
    Uri.parse("https://plot-backend.herokuapp.com/land/hotoptions");

    final response = await http.get(url, headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',

    });
    // print(response.body);
    if (response.statusCode == 200) {
      setState(() {
       data=json.decode(response.body)["result"];
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
    }
  }
}
