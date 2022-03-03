import 'dart:html';

import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:sgm/Pacote_de_Ajuda/cores.dart';
import 'package:sgm/visao/account/account_management.dart';
import 'package:sgm/visao/homes/home_supervisor.dart';


class CustomNavBar extends StatefulWidget {
  const CustomNavBar({ Key? key }) : super(key: key);

  @override
  _CustomNavBarState createState() => _CustomNavBarState();
}

class _CustomNavBarState extends State<CustomNavBar> {
  int index = 1;
  @override
  Widget build(BuildContext context) {
    final screens = [
      const HomeSupervisor(),
      const HomeSupervisor(),
      const AccountManagement()
    ];

    final items = <Widget>
    [
      const Icon(Icons.donut_large_outlined, size: 30, color: amareloClaro,),
      const Icon(Icons.psychology_outlined, size: 30, color: amareloClaro,),
      const Icon(Icons.account_circle_outlined, size: 30, color:amareloClaro)
    ];
    return CurvedNavigationBar(
      index: index,
      animationDuration: const Duration(milliseconds: 300),
      height: 65,
      color: azul,
      backgroundColor: amareloClaro,
      items: items,
      onTap: (index) => setState((
      ) => this.index = index)
      );
  }
}