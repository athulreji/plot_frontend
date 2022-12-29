import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:page_transition/page_transition.dart';
import 'package:plot_frontend/home/hotOptionsCard.dart';
import 'package:http/http.dart' as http;

import '../descriptionpages/descCard.dart';

var check=0;
class HotOptions extends StatefulWidget {
  const HotOptions({super.key});

  @override
  State<HotOptions> createState() => _HotOptionsState();
}

class _HotOptionsState extends State<HotOptions> {

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
      margin: EdgeInsets.fromLTRB(18, 0, 18, 0),
      child: Column(
        children: [
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Hot Options", style: TextStyle(fontSize: 24, fontWeight: FontWeight.w700),),
              Text("see all", style: TextStyle(color: Color(0xff2A2A2A)),)
            ],
          ),
          SizedBox(height: 15,),
          CarouselSlider(
            options: CarouselOptions(
              viewportFraction: 0.75,
              autoPlay: true,
            ),
            items: ["1","2","3","4","5"].map((i) {
              return Builder(
                builder: (BuildContext context) {
                  return check==1? HotOptionsCArd(title: data[i]["title"],location:data[i]["location"] ,):Center(child: CupertinoActivityIndicator());
                },
              );
            }).toList(),
          ),
        ],
      ),
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
      setState(() {
        check=1;;
      });
      return data;
    }
  }
}