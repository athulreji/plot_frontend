import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:plot_frontend/detailsPage/detailCarousalCard.dart';
// import 'package:flutter/src/widgets/container.dart';
// import 'package:flutter/src/widgets/framework.dart';

class DetailsCarousal extends StatefulWidget {
  const DetailsCarousal({super.key});

  @override
  State<DetailsCarousal> createState() => _DetailsCarousalState();
}

class _DetailsCarousalState extends State<DetailsCarousal> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: CarouselSlider(
      options: CarouselOptions(
        enlargeCenterPage: true,
        viewportFraction: 0.75,
        autoPlay: true,
      ),
      items: [1,2,3,4,5].map((i) {
      return Builder(
        builder: (BuildContext context) {
          return detailCarousalCard();
        },
      );
      }).toList(),
    ),
    );

  }
}