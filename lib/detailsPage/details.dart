import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:plot_frontend/detailsPage/detailsCarousal.dart';
import 'package:http/http.dart' as http;

int share=0;
int value=1;

class Details extends StatefulWidget {
  String name;
  String location;
  int price;
  int area;
  String description;
  int checkval;

  Details(
      {required this.name,
      required this.location,
      required this.price,
      required this.area,
      required this.description,required this.checkval});

  @override
  State<Details> createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
  @override
  void initState() {
    // TODO: implement initState
    share=widget.price;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: SizedBox(
        height: 900,
        width: 400,
        child: Scaffold(
          body: SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    SizedBox(
                      width: 20,
                    ),
                    InkWell(
                      borderRadius: BorderRadius.circular(50),
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Container(
                        child: Icon(FontAwesomeIcons.arrowLeft),
                        height: 50,
                        width: 50,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(
                              color: Colors.black,
                            ),
                            borderRadius:
                                BorderRadius.all(Radius.circular(50))),
                      ),
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    widget.checkval==1? Text(
                      "Invest",
                      style:
                          TextStyle(fontSize: 24, fontWeight: FontWeight.w500),
                    ):widget.checkval==2?Text(
                      "lease",
                      style:
                      TextStyle(fontSize: 24, fontWeight: FontWeight.w500),
                    ):Text(
                      "parking",
                      style:
                      TextStyle(fontSize: 24, fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
                SizedBox(height: 50),
                DetailsCarousal(),
                SizedBox(
                  height: 30,
                ),
                Container(
                  padding: EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.name,
                        style: TextStyle(
                            fontSize: 32, fontWeight: FontWeight.w400),
                      ),
                      Text(
                        widget.location,
                        style: TextStyle(
                            fontSize: 24, fontWeight: FontWeight.w400),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      SizedBox(
                        child: Text(widget.description),
                      ),
                      SizedBox(
                        height: 40,
                      ),
                      Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: Color(0xffD3F5F3)),
                        padding: EdgeInsets.all(30),
                        child: Row(
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Price",
                                  style: TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.w400),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  "₹" + widget.price.toString(),
                                  style: TextStyle(
                                      fontSize: 32,
                                      fontWeight: FontWeight.w400),
                                ),
                              ],
                            ),
                            Expanded(
                              child: Text(''),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 50,
                      ),
                      Container(
                        width: 300,
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(50, 0, 20, 0),
                          child: widget.checkval==1? NeumorphicButton(
                              onPressed: () async {
                                // setState(() {
                                //   arrow = false;
                                // });
                                // username_login();
                                print("object");
                                showDialog(context: context,builder: (BuildContext context){
                                  return Alertahne(price: widget.price,);

                                });
                              },
                              style: NeumorphicStyle(
                                color: Colors.grey[300],
                                shape: NeumorphicShape.flat,
                                boxShape: NeumorphicBoxShape.roundRect(
                                    BorderRadius.circular(20)),
                              ),
                              child: Center(child: Text("Request stocks"))):NeumorphicButton(
                              onPressed: () async {
                                // setState(() {
                                //   arrow = false;
                                // });
                                // username_login();
                                Map newUpdate = {
                                  "email": "adam@gmail.com",
                                  "_id": "635ae017e2c0c6fa58c65f3f",
                                };
                                final url = Uri.parse("https://plot-backend.herokuapp.com/lease/set_lease_true");

                                final response = await http.post(
                                  url,
                                  headers: {
                                    'Content-Type': 'application/json',
                                    'Accept': 'application/json',

                                  },
                                  body: jsonEncode(newUpdate),
                                );
                                print(response.body); showAlertDialog(context);
                              },
                              style: NeumorphicStyle(
                                color: Colors.grey[300],
                                shape: NeumorphicShape.flat,
                                boxShape: NeumorphicBoxShape.roundRect(
                                    BorderRadius.circular(20)),
                              ),
                              child: Center(child: Text("Book"))),

                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
    ;
  }
  showAlertDialog(BuildContext context) {
    // set up the buttons
    Widget retryButton = NeumorphicButton(
      style: NeumorphicStyle(
        boxShape: NeumorphicBoxShape.roundRect(BorderRadius.circular(34)),
        shape: NeumorphicShape.flat,
      ),
      child: Container(
        child: const Text(
          "Proceed",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        padding: const EdgeInsets.fromLTRB(25, 4, 25, 4),
      ),
      onPressed: () async {
        // Try reading data from the 'counter' key. If it doesn't exist, returns null.
        // Obtain shared preferences.

        Navigator.pop(context);
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      actionsAlignment: MainAxisAlignment.center,
      //contentPadding: EdgeInsets.fromLTRB(100, 10, 100, 10),
      content: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          Text(
            "Plot booked",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ],
      ),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      actions: [
        retryButton,
      ],
    );
    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Neumorphic(
          child: alert,
          style: NeumorphicStyle(
              depth: 0,
              shape: NeumorphicShape.flat,
              boxShape: NeumorphicBoxShape.roundRect(BorderRadius.circular(0))),
        );
      },
    );
  }

}


class Alertahne extends StatefulWidget {
  int price;
  Alertahne({required this.price});
  //const Alertahne({Key? key}) : super(key: key);

  @override
  State<Alertahne> createState() => _AlertahneState();
}

class _AlertahneState extends State<Alertahne> {
  @override
  Widget build(BuildContext context) {
    return  AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      title: Center(
          child: Text(
            "Confirm Request",
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
          )),
      content: Container(
          height: 200,
          child:
          Column(crossAxisAlignment: CrossAxisAlignment.center, children: [

            SizedBox(
              height: 15,
            ),
            Text(
              "₹${share}",
              style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  color: Color(0xff0063F5)),
            ),
            SizedBox(
              height: 5,
            ),
            Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                      child: Row(children: [
                        Container(
                            width: 20,
                            height: 20,
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.blue, width: 0.6),
                                shape: BoxShape.circle),
                            child: Center(
                                child: IconButton(
                                  padding: EdgeInsets.all(0),
                                  onPressed: () {
                                    setState(() {
                                      if (value > 1) {
                                        value -= 1;
                                        share -= widget.price;
                                      }
                                    });
                                  },
                                  color: Color(0xff0063F5),
                                  icon: Icon(
                                    CupertinoIcons.minus,
                                    size: 12,
                                  ),
                                ))),
                      ])),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Text(
                      "$value",
                      style: const TextStyle(
                        fontSize: 25,
                        color: Color(0xff0063F5),
                        fontFamily: 'Urbanist',
                      ),
                    ),
                  ),
                  Container(
                      width: 20,
                      height: 20,
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.blue, width: 0.6),
                          shape: BoxShape.circle),
                      child: Center(
                          child: IconButton(
                            padding: EdgeInsets.all(0),
                            onPressed: () {
                              setState(() {
                                value += 1;
                                share += widget.price;;
                              });
                            },
                            color: Color(0xff0063F5),
                            icon: Icon(
                              CupertinoIcons.add,
                              size: 12,
                            ),
                          ))),
                ]),
          ])),
      actions: [
        Center(
            child: Padding(
              padding: const EdgeInsets.only(top: 8, right: 8, left: 8, bottom: 15),
              child: Container(
                  width: double.infinity,
                  height: 40,
                  decoration: BoxDecoration(
                      color: Color(0xff0063F5),
                      borderRadius: BorderRadius.circular(5)),
                  child: TextButton(
                      onPressed: () async {
                        setState(() {
                          //buy_button_check = 1;
                        });
                      await Buymovie(widget.price);

                      },
                      child:
                      Text(
                        "request Now",
                        style: TextStyle(color: Colors.white),
                      ))),
            ))
      ],
    );
  }


  Future Buymovie(int price) async {
    Map newUpdate = {
      "tokenAmount": price,
      "tokenCount": value,
    };
    final url = Uri.parse("https://plot-backend.herokuapp.com/lease/buy");

    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',

      },
      body: jsonEncode(newUpdate),
    );
    print(response.body); showAlertDialog(context);


    // setState(() {
    //
    //   _isVisible = !_isVisible;
    // });
  }

  Future Buymovie2(int price) async {
    Map newUpdate = {
      "email": "adam@gmail.com",
      "_id": "635ae017e2c0c6fa58c65f3f",
    };
    final url = Uri.parse("https://plot-backend.herokuapp.com/lease/set_lease_true");

    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',

      },
      body: jsonEncode(newUpdate),
    );
    print(response.body); showAlertDialog(context);


    // setState(() {
    //
    //   _isVisible = !_isVisible;
    // });
  }

  showAlertDialog(BuildContext context) {
    // set up the buttons
    Widget retryButton = NeumorphicButton(
      style: NeumorphicStyle(
        boxShape: NeumorphicBoxShape.roundRect(BorderRadius.circular(34)),
        shape: NeumorphicShape.flat,
      ),
      child: Container(
        child: const Text(
          "Proceed",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        padding: const EdgeInsets.fromLTRB(25, 4, 25, 4),
      ),
      onPressed: () async {
        // Try reading data from the 'counter' key. If it doesn't exist, returns null.
        // Obtain shared preferences.

        Navigator.pop(context);
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      actionsAlignment: MainAxisAlignment.center,
      //contentPadding: EdgeInsets.fromLTRB(100, 10, 100, 10),
      content: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          Text(
            "Share bought",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ],
      ),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      actions: [
        retryButton,
      ],
    );
    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Neumorphic(
          child: alert,
          style: NeumorphicStyle(
              depth: 0,
              shape: NeumorphicShape.flat,
              boxShape: NeumorphicBoxShape.roundRect(BorderRadius.circular(0))),
        );
      },
    );
  }
}
//https://plot-backend.herokuapp.com/lease/set_lease_true