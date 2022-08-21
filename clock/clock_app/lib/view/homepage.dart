// ignore_for_file: deprecated_member_use, unused_import
import 'dart:developer';
import 'package:clock_app/model/data.dart';
import 'package:clock_app/model/enums.dart';
import 'package:clock_app/view/clock_view.dart';
import 'package:clock_app/model/menu_info.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    var now = DateTime.now();
    var formattedTime = DateFormat("HH:mm").format(now);
    var formattedDate = DateFormat("EEE, d MMM").format(now);
    var timeZoneString = now.timeZoneOffset.toString().split('.').first;
    var offsetSign = '';
    if (!timeZoneString.startsWith("-")) {
      offsetSign = "+";
    }
    log(timeZoneString);

    return Scaffold(
      backgroundColor: Color(0xFF2D2F41),
      body: Row(
        children: [
          Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: menuItems
                  .map((currentMenuInfo) => buildMenuButton(currentMenuInfo))
                  .toList()),
          const VerticalDivider(
            color: Colors.white54,
            width: 1,
          ),
          const SizedBox(
            width: 10,
          ),
          Expanded(
            child: Consumer<MenuInfo>(
                builder: (BuildContext context, MenuInfo value, Widget? child) {
              log("Consumer MenuInfo ${value.menuType}");
              switch (value.menuType) {
                case MenuType.clock:
                  // TODO: Handle this case.
                  return Center(
                    child: Text("Clock"),
                  );
                case MenuType.alarm:
                  // TODO: Handle this case.
                  return Center(
                    child: Text("Alarm"),
                  );
                case MenuType.timer:
                  // TODO: Handle this case.
                  return Center(
                    child: Text("Timer"),
                  );
                case MenuType.stopwatch:
                  // TODO: Handle this case.
                  return Center(
                    child: Text("Stopwatch"),
                  );
              }
              if (value.menuType != MenuType.clock) return Container();
              return Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Flexible(
                      flex: 1,
                      fit: FlexFit.tight,
                      child: Text(
                        "Clock",
                        style: TextStyle(color: Colors.white, fontSize: 24),
                      ),
                    ),
                    Flexible(
                      flex: 2,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            formattedTime,
                            style: TextStyle(color: Colors.white, fontSize: 64),
                          ),
                          Text(
                            formattedDate,
                            style: TextStyle(color: Colors.white, fontSize: 20),
                          ),
                        ],
                      ),
                    ),
                    const Flexible(
                        flex: 4,
                        fit: FlexFit.tight,
                        child: Align(
                            alignment: Alignment.centerLeft,
                            child: ClockView(
                              size: 300,
                            ))),
                    Flexible(
                      flex: 2,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Timezsone",
                            style: TextStyle(color: Colors.white, fontSize: 14),
                          ),
                          const SizedBox(width: 16),
                          Row(
                            children: [
                              const Icon(
                                Icons.language,
                                color: Colors.white,
                              ),
                              const SizedBox(width: 16),
                              Text(
                                "UTC" + offsetSign + timeZoneString,
                                style: const TextStyle(
                                    color: Colors.white, fontSize: 14),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              );
            }),
          ),
        ],
      ),
    );
  }
}

Widget buildMenuButton(MenuInfo currentMenuInfo) {
  return Consumer<MenuInfo>(
    builder: (BuildContext context, MenuInfo value, Widget? child) {
      return FlatButton(
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(topRight: Radius.circular(32))),
        padding: const EdgeInsets.symmetric(vertical: 16),
        color: currentMenuInfo.menuType == value.menuType
            ? Colors.transparent
            : Colors.transparent,
        onPressed: () {
          log("Inside Button");
          var menuInfo = Provider.of<MenuInfo>(context, listen: false);
          menuInfo.updateMenu(currentMenuInfo);
        },
        child: Column(
          children: [
            Image.asset(
              currentMenuInfo.imageSource!,
              scale: 1.5,
            ),
            const SizedBox(
              height: 20,
            ),
            Text(
              currentMenuInfo.title!,
              style: TextStyle(color: Colors.white, fontSize: 24),
            ),
          ],
        ),
      );
    },
  );
}
