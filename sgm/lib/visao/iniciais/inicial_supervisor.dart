import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sgm/shared/cores.dart';
import 'package:sgm/visao/account/account_management.dart';
import 'package:sgm/visao/dashboards/dashboard_supervisor.dart';
import 'package:sgm/visao/iniciais/homes/home_supervisor.dart';


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
      const Icon(Icons.donut_large_outlined, size: 30, color: amareloClaro,),
      const Icon(Icons.psychology_outlined, size: 30, color: amareloClaro,),
      const Icon(Icons.account_circle_outlined, size: 30, color:amareloClaro)
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
     statusBarColor: azul,
     statusBarIconBrightness: Brightness.light
    ));
    return Scaffold(
      drawer: const Drawer(
        backgroundColor: azul,
      ),
      key: scaffoldKey,
      backgroundColor: amareloClaro,
      body: screens[index],
      bottomNavigationBar: CurvedNavigationBar(
      index: index,
      animationDuration: const Duration(milliseconds: 300),
      height: 65,
      color: azul,
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


