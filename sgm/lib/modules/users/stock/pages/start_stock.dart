import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sgm/modules/users/stock/pages/home_stock.dart';
import 'package:sgm/shared/widgets/account_management.dart';
import 'package:sgm/shared/help/colors.dart';
import 'package:sgm/shared/widgets/custom_drawer.dart';

class StartStock extends StatefulWidget {
  const StartStock({Key? key}) : super(key: key);

  @override
  State<StartStock> createState() => _StartStockState();
}

class _StartStockState extends State<StartStock> {
  int index = 1;

  final items = <Widget>[
    const Icon(
      Icons.donut_large_outlined,
      size: 30,
    ),
    const Icon(
      Icons.inventory_2_outlined,
      size: 30,
    ),
    const Icon(
      Icons.account_circle_outlined,
      size: 30,
    )
  ];

  final screens = [
    const HomeStock(),
    const HomeStock(),
    const AccountManagement(
      primaryColor: darkyellow,
      nameColor: blue,
      editColor: pink,
    )
  ];
  final scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
        statusBarColor: darkyellow,
        systemNavigationBarColor: darkyellow,
        statusBarIconBrightness: Brightness.dark));
    return Scaffold(
        drawer: const CustomDrawer(
          color: darkyellow,
        secondaryColor:  blue 
        ),
        key: scaffoldKey,
        backgroundColor: lightyellow,
        body: screens[index],
        bottomNavigationBar: CurvedNavigationBar(
          index: index,
          animationDuration: const Duration(milliseconds: 300),
          height: 65,
          color: darkyellow,
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
