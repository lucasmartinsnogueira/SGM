import 'package:flutter/material.dart';

class HomeMecanico extends StatefulWidget {
  const HomeMecanico({ Key? key }) : super(key: key);

  @override
  _HomeMecanicoState createState() => _HomeMecanicoState();
}

class _HomeMecanicoState extends State<HomeMecanico> {
  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      child: Center(child: Text("Mecânico")),
    );
  }
}