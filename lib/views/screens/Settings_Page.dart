import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:galaxy_planets/controllers/providers/theme_provider.dart';
import 'package:galaxy_planets/utils/globals.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      child: CustomScrollView(
        slivers: [
          CupertinoSliverNavigationBar(
            leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(
                Icons.arrow_back_ios,
                size: 2.5.h,
              ),
            ),
            largeTitle: Text(
              'Settings',
              style: TextStyle(
                color: (Provider.of<ThemeProvider>(context).themeModel.isDark)
                    ? CupertinoColors.white
                    : CupertinoColors.black,
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Container(
              padding: EdgeInsets.all(2.h),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: 5.w,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 1.h,
                  ),
                  Card(
                    child: CupertinoListTile(
                      title: Text(
                        "Theme",
                        style: (Provider.of<ThemeProvider>(context)
                                .themeModel
                                .isDark)
                            ? TextThemes.textStyleDark
                            : TextThemes.textStyleLight,
                      ),
                      trailing: CupertinoSwitch(
                        value: Provider.of<ThemeProvider>(context)
                            .themeModel
                            .isDark,
                        onChanged: (val) {
                          Provider.of<ThemeProvider>(context, listen: false)
                              .changeTheme();
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
