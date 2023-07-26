import 'dart:math';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:galaxy_planets/controllers/providers/json_decode_provider.dart';
import 'package:galaxy_planets/controllers/providers/theme_provider.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  late AnimationController animationController;

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 8),
      lowerBound: 0,
      upperBound: 2 * pi,
    );
    animationController.repeat();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/gifs/BackgroundBlack.gif'),
              fit: BoxFit.cover,
            ),
          ),
          child: Column(
            children: [
              Expanded(
                flex: 1,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: 6.w, top: 1.h),
                      child: Text(
                        "Planet  Details",
                        style: TextStyle(
                          fontSize: 3.h,
                          fontWeight: FontWeight.w500,
                          color: Colors.white.withOpacity(0.8),
                        ),
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        showModalBottomSheet(
                          context: context,
                          builder: (context) => Container(
                            padding: EdgeInsets.all(6.w),
                            height: 18.h,
                            child: Column(
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    Navigator.of(context).pop();
                                    Navigator.of(context)
                                        .pushNamed('settings_page');
                                  },
                                  child: Row(
                                    children: [
                                      Icon(Icons.settings, size: 4.h),
                                      SizedBox(
                                        width: 3.w,
                                      ),
                                      Text(
                                        "Settings",
                                        style: TextStyle(fontSize: 2.5.h),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 2.5.h,
                                ),
                                GestureDetector(
                                  onTap: () {
                                    Navigator.of(context).pop();
                                    Navigator.of(context)
                                        .pushNamed('favorites_page');
                                  },
                                  child: Row(
                                    children: [
                                      Icon(Icons.favorite_border_rounded,
                                          size: 4.h),
                                      SizedBox(
                                        width: 3.w,
                                      ),
                                      Text(
                                        "Favorites",
                                        style: TextStyle(fontSize: 2.5.h),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                      icon: const Icon(
                        Icons.dehaze,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 1.h,
              ),
              Expanded(
                flex: 18,
                child: Column(
                  children: [
                    CarouselSlider(
                      items: [
                        ...List.generate(
                          Provider.of<JsonDecodeProvider>(context,
                                  listen: false)
                              .galaxyDetails
                              .length,
                          (index) => Column(
                            children: [
                              SizedBox(
                                height: 60,
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      if (animationController.isAnimating) {
                                        animationController.stop();
                                      } else {
                                        animationController.repeat();
                                      }
                                      setState(() {});
                                    },
                                    child: AnimatedBuilder(
                                      animation: animationController,
                                      child: Image.asset(
                                        Provider.of<JsonDecodeProvider>(context,
                                                listen: false)
                                            .galaxyDetails[index]
                                            .image,
                                        height: 35.h,
                                        width: 35.h,
                                      ),
                                      builder: (context, widget) {
                                        return Transform.rotate(
                                          angle: animationController.value,
                                          child: widget,
                                        );
                                      },
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.of(context).pushNamed(
                                        'details_page',
                                        arguments:
                                            Provider.of<JsonDecodeProvider>(
                                                    context,
                                                    listen: false)
                                                .galaxyDetails[index],
                                      );
                                    },
                                    child: Container(
                                      height: 22.h,
                                      width: 40.h,
                                      decoration: BoxDecoration(
                                        color:
                                            (Provider.of<ThemeProvider>(context)
                                                    .themeModel
                                                    .isDark)
                                                ? Colors.grey.withOpacity(0.4)
                                                : Colors.white.withOpacity(0.8),
                                        borderRadius:
                                            BorderRadius.circular(1.h),
                                      ),
                                      padding: EdgeInsets.all(1.h),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                Provider.of<JsonDecodeProvider>(
                                                        context)
                                                    .galaxyDetails[index]
                                                    .name,
                                                style: TextStyle(
                                                  fontSize: 3.h,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ],
                                          ),
                                          SizedBox(
                                            height: 3.h,
                                          ),
                                          Text(
                                            'Radius : ${Provider.of<JsonDecodeProvider>(context).galaxyDetails[index].radius}',
                                            style: TextStyle(
                                              fontSize: 2.h,
                                            ),
                                          ),
                                          Text(
                                            'Velocity : ${Provider.of<JsonDecodeProvider>(context).galaxyDetails[index].velocity}',
                                            style: TextStyle(
                                              fontSize: 2.h,
                                            ),
                                          ),
                                          Text(
                                            'Gravity : ${Provider.of<JsonDecodeProvider>(context).galaxyDetails[index].gravity}',
                                            style: TextStyle(
                                              fontSize: 2.h,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                      options: CarouselOptions(
                        height: 700,
                        enlargeCenterPage: true,
                        scrollDirection: Axis.horizontal,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }
}
