import 'package:flutter/material.dart';
import 'package:sgm/Pacote_de_Ajuda/cores.dart';

class DashboardSupervisor extends StatefulWidget {
  const DashboardSupervisor({ Key? key }) : super(key: key);

  @override
  State<DashboardSupervisor> createState() => _DashboardSupervisorState();
}

class _DashboardSupervisorState extends State<DashboardSupervisor> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Scaffold.of(context).openDrawer();
      },
      child: Container(
        height: 75,
        width: 75,
        color: vermelho,
      ),
    );
  }
}