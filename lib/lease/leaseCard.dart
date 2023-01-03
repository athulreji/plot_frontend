import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:plot_frontend/detailsPage/details.dart';

class LeaseCard extends StatefulWidget {
  final data;
  const LeaseCard({required this.data});
  @override
  _LeaseCardState createState() => _LeaseCardState();
}

class _LeaseCardState extends State<LeaseCard> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(20),
      child: InkWell(
        onTap: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => Details(id: widget.data['id'], name: widget.data["name"],location: widget.data["location"],description: widget.data["description"],area: widget.data["area"],price: widget.data["price"],checkval: 2,)));
        },
        child: Container(
          decoration: BoxDecoration(
            color: Color.fromRGBO(211, 245, 243, 1),
            borderRadius: BorderRadius.circular(10),
          ),
          padding: EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(widget.data['name'],
                style: TextStyle(
                  fontSize: 24, fontWeight: FontWeight.w600)),
              SizedBox(height: 40),
              Row(
                children: [
                  FaIcon(FontAwesomeIcons.locationDot, size: 14),
                  SizedBox(width: 5),
                  Text(widget.data['location'])
                ],
              )
        ]))
    )
    );
  }
}
