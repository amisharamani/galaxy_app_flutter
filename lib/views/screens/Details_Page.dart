import 'dart:math';

import 'package:flutter/material.dart';
import 'package:galaxy_planets/controllers/providers/json_decode_provider.dart';
import 'package:galaxy_planets/controllers/providers/theme_provider.dart';
import 'package:galaxy_planets/models/json_decode.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class DetailsPage extends StatefulWidget {
  const DetailsPage({super.key});

  @override
  State<DetailsPage> createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  @override
  Widget build(BuildContext context) {
    JsonDecodeModel data =
        ModalRoute.of(context)!.settings.arguments as JsonDecodeModel;

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
                    IconButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      icon: const Icon(
                        Icons.arrow_back_ios,
                        color: Colors.white,
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        Provider.of<JsonDecodeProvider>(context, listen: false)
                            .favoritePlanet(int.parse(data.position));
                      },
                      icon: (Provider.of<JsonDecodeProvider>(context)
                              .galaxyDetails[int.parse(data.position)]
                              .favorite)
                          ? const Icon(
                              Icons.favorite,
                              color: Colors.pink,
                            )
                          : const Icon(
                              Icons.favorite_border,
                              color: Colors.white,
                            ),
                    ),
                  ],
                ),
              ),
              Expanded(
                flex: 18,
                child: Padding(
                  padding: EdgeInsets.all(3.h),
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: Column(
                      children: [
                        TweenAnimationBuilder(
                          tween: Tween<double>(
                            begin: 0,
                            end: 2 * pi,
                          ),
                          duration: const Duration(seconds: 16),
                          child: Image.asset(
                            data.image,
                            height: 40.h,
                            width: 40.h,
                          ),
                          builder: (context, value, widget) {
                            return Transform.rotate(
                              angle: value,
                              child: widget,
                            );
                          },
                        ),
                        Container(
                          height: 28.h,
                          width: 44.h,
                          decoration: BoxDecoration(
                            color: (Provider.of<ThemeProvider>(context)
                                    .themeModel
                                    .isDark)
                                ? Colors.grey.withOpacity(0.4)
                                : Colors.white.withOpacity(0.8),
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(2.h),
                              bottomRight: Radius.circular(2.h),
                            ),
                          ),
                          padding: EdgeInsets.all(1.2.h),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                data.name,
                                style: TextStyle(
                                  fontSize: 3.5.h,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                data.type,
                                style: TextStyle(
                                  fontSize: 2.h,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              SizedBox(
                                height: 3.h,
                              ),
                              Text(
                                'Radius : ${data.radius}',
                                style: TextStyle(
                                  fontSize: 2.h,
                                ),
                              ),
                              Text(
                                'Orbital Period : ${data.orbital_period}',
                                style: TextStyle(
                                  fontSize: 2.h,
                                ),
                              ),
                              Text(
                                'Gravity : ${data.gravity}',
                                style: TextStyle(
                                  fontSize: 2.h,
                                ),
                              ),
                              Text(
                                'Velocity : ${data.velocity}',
                                style: TextStyle(
                                  fontSize: 2.h,
                                ),
                              ),
                              Text(
                                'Distance (from Sun) : ${data.distance}',
                                style: TextStyle(
                                  fontSize: 2.h,
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 4.h,
                        ),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "Details",
                            style: TextStyle(
                              fontSize: 2.5.h,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 1.h,
                        ),
                        Text(
                          data.description,
                          style: TextStyle(
                            fontSize: 2.h,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
