import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:plot_frontend/constraints.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:plot_frontend/lease/leaseCard.dart';
import 'package:http/http.dart' as http;

int check=0;
class Lease extends StatefulWidget {
  const Lease({Key? key}) : super(key: key);

  @override
  State<Lease> createState() => _LeaseState();
}

class _LeaseState extends State<Lease> {

  @override
  void initState() {
    check=0;
    fetchLeases();
    super.initState();

  }

  late var data;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(scrollDirection: Axis.vertical,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 20,),
              Row(
                children: [
                  SizedBox(
                    width: 20,
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Icon(FontAwesomeIcons.arrowLeft),
                  ),
                  SizedBox(
                    width: 15,
                  ),
                  Text(
                    "Plot.",
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
                  )
                ],
              ),
              SizedBox(
                height: 30,
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(35, 0, 0, 0),
                child: Text("Lease",
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.w400)),
              ),
              SizedBox(height: 40,),
              if(check==1) ListView.builder(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemCount: data.length,itemBuilder: (BuildContext context,i){
                  return LeaseCard(data: data[i]);
              })
              else
              Center(child: CupertinoActivityIndicator()),
            ],
          ),
        ),
      ),
    );
  }



  void fetchLeases() async {
    final url = Uri.parse(api+"Lease/lands_for_lease");
    final response = await http.get(url, headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    });

    if (response.statusCode == 200) {
      setState(() {
        data = json.decode(response.body)["lands"];
        check=1;
      });
    }
  }
}
