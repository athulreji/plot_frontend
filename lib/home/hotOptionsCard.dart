import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;

class HotOptionsCArd extends StatefulWidget {
  String title;
  String location;
  HotOptionsCArd({required this.title,required this.location});


  @override
  State<HotOptionsCArd> createState() => _HotOptionsCArdState();
}

class _HotOptionsCArdState extends State<HotOptionsCArd> {
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
    return Container(
      padding: EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(widget.title,style: TextStyle(fontWeight: FontWeight.w600,fontSize: 18),),
          SizedBox(
            height: 10,
          ),
          Text(widget.location),
          SizedBox(height: 40,),Padding(
          padding: EdgeInsets.fromLTRB(100, 0, 0, 0),
          child:Image.asset("animation/thaze.png",width: 115,))
        ],
      ),
      decoration: BoxDecoration(
          color: Color(0xffD3F5F3),
          borderRadius: BorderRadius.circular(20)),
      width: 244,
      height: 210,
    );
  }

  dynamic fetchToknens() async {
    final url = Uri.parse("https://plot-backend.herokuapp.com/land/hotoptions");

    final response = await http.get(url, headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    });
    // print(response.body);
    if (response.statusCode == 200) {
      setState(() {
        data = json.decode(response.body)["result"];
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
      return data;
    }
  }
}
