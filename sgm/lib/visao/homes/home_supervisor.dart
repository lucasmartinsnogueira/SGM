import 'package:flutter/material.dart';

class HomeSupervisor extends StatefulWidget {
  const HomeSupervisor({ Key? key }) : super(key: key);

  @override
  _HomeSupervisorState createState() => _HomeSupervisorState();
}

class _HomeSupervisorState extends State<HomeSupervisor> {
  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      child: Text("Supervisor")
    );
  }
}