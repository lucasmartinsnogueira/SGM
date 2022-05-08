import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sgm/modules/users/supervisor/pages/account_management.dart';
import 'package:sgm/modules/users/supervisor/pages/dashboard_supervisor.dart';
import 'package:sgm/modules/users/supervisor/pages/home_supervisor.dart';
import 'package:sgm/shared/help/colors.dart';


class InicialSupervisor extends StatefulWidget {
  const InicialSupervisor({ Key? key }) : super(key: key);
  

  int oi(value){
    return value;
  }
  @override
  _InicialSupervisorState createState() => _InicialSupervisorState();
}

class _InicialSupervisorState extends State<InicialSupervisor> {
  InicialSupervisor ola = const InicialSupervisor();
  
  int index = 1;
  
  final items = <Widget>
    [
      const Icon(Icons.donut_large_outlined, size: 30, color: lightyellow,),
      const Icon(Icons.psychology_outlined, size: 30, color: lightyellow,),
      const Icon(Icons.account_circle_outlined, size: 30, color: lightyellow)
    ];
  
  final screens = [
       const DashboardSupervisor(),
       const HomeSupervisor(),
       const AccountManagement()
  ];
  final scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  
  Widget build(BuildContext context) {
     SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
     statusBarColor: blue,
     statusBarIconBrightness: Brightness.light
    ));
    return Scaffold(
      drawer: const Drawer(
        backgroundColor: blue,
      ),
      key: scaffoldKey,
      backgroundColor: lightyellow,
      body: screens[index],
      bottomNavigationBar: CurvedNavigationBar(
      index: index,
      animationDuration: const Duration(milliseconds: 300),
      height: 65,
      color: blue,
      backgroundColor: Colors.transparent,
      items: items,
      onTap: (index){
        setState(() {
          this.index = index;
        });
        
      },

      )
    );
    
  }
  

}


