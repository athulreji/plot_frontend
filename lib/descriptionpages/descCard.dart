import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:plot_frontend/detailsPage/details.dart';
import 'package:page_transition/page_transition.dart';

class descCard extends StatefulWidget {
  String title;
  String location;
  var dataa;
  int checkval;

  descCard({required this.title,required this.location,required this.dataa,required this.checkval});


  @override
  State<descCard> createState() => _descCardState();
}

class _descCardState extends State<descCard> {

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        Navigator.push(context, PageTransition(type: PageTransitionType.rightToLeft, child: Details(name: widget.dataa["name"],location: widget.dataa["location"],description: widget.dataa["description"],area: widget.dataa["area"],price: widget.dataa["price"],checkval: widget.checkval,)));
      },
      child: Container(
        padding: EdgeInsets.all(20),
        width: 160,
        height: 210,
        decoration: BoxDecoration(
          color: Color(0xffD3F5F3),
          borderRadius: BorderRadius.circular(20)
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(widget.title, style: TextStyle(fontSize: 24, fontWeight: FontWeight.w400),),
            Text(widget.location),
          ],
        ),
      ),
    );
  }
}