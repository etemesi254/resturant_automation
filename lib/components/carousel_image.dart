import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

final List<String> imgList = [
  "assets/images/breakfast.jpg",
  "assets/images/lunch.jpg",
  "assets/images/dinner.jpg",
  "assets/images/celebrations.jpg"
];

final captions = {
  "assets/images/breakfast.jpg": "From Breakfast",
  "assets/images/lunch.jpg": "To Lunch",
  "assets/images/dinner.jpg": "From dinners",
 "assets/images/celebrations.jpg": "To parties"
//  "We got you"
};

final List<Widget> imageSliders = imgList
    .map((item) => SizedBox(
          child: Container(
            margin: const EdgeInsets.all(0),
            child: ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(5.0)),
                child: Stack(
                  children: <Widget>[
                    Image.asset(item, fit: BoxFit.cover, width: 1000.0),
                    Positioned(
                      bottom: 0.0,
                      left: 0.0,
                      right: 0.0,
                      child: Container(
                        decoration: const BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              Color.fromARGB(200, 0, 0, 0),
                              Color.fromARGB(0, 0, 0, 0)
                            ],
                            begin: Alignment.bottomCenter,
                            end: Alignment.topCenter,
                          ),
                        ),
                        padding: const EdgeInsets.symmetric(
                            vertical: 1.0, horizontal: 2.0),
                        child: Text(
                          '${captions[item]}',
                          style:const TextStyle(
                            color: Colors.white,
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                )),
          ),
        ))
    .toList();

Widget showCarousel() {
  return SizedBox(
    child: CarouselSlider(
      options: CarouselOptions(
        padEnds: true,
        autoPlay: true,
        viewportFraction: 0.96,
        aspectRatio: 2.0,
        enlargeCenterPage: true,
      ),
      items: imageSliders,
    ),
  );
}
