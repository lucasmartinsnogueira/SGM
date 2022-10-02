import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sgm/modules/users/mechanical/pages/home_mechanical.dart';
import 'package:sgm/shared/widgets/account_management.dart';
import 'package:sgm/shared/help/colors.dart';
import 'package:sgm/shared/widgets/custom_drawer.dart';

class StartMechanical extends StatefulWidget {
  const StartMechanical({Key? key}) : super(key: key);

  @override
  State<StartMechanical> createState() => _StartMechanicalState();
}

class _StartMechanicalState extends State<StartMechanical> {
  int index = 1;

  final items = <Widget>[
    const Icon(
      Icons.donut_large_outlined,
      size: 30,
    ),
    const Icon(
      Icons.engineering_outlined,
      size: 30,
    ),
    const Icon(
      Icons.account_circle_outlined,
      size: 30,
    )
  ];

  final screens = [
    const HomeMechanical(),
    const HomeMechanical(),
    AccountManagement(
      primaryColor: pink,
      nameColor: Colors.black,
      editColor: const Color.fromARGB(255, 87, 8, 8),
    )
  ];
  final scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
        statusBarColor: pink,
        systemNavigationBarColor: pink,
        statusBarIconBrightness: Brightness.dark));
    return Scaffold(
        drawer: const CustomDrawer(color: pink, secondaryColor: Colors.black),
        key: scaffoldKey,
        backgroundColor: lightyellow,
        body: screens[index],
        bottomNavigationBar: CurvedNavigationBar(
          index: index,
          animationDuration: const Duration(milliseconds: 300),
          height: 65,
          color: pink,
          backgroundColor: Colors.transparent,
          items: items,
          onTap: (index) {
            setState(() {
              this.index = index;
            });
          },
        ));
  }
}
