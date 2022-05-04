import 'package:flutter/material.dart';
import 'package:sgm/shared/help/colors.dart';


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
        color: red,
      ),
    );
  }
}