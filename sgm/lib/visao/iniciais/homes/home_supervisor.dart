// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:sgm/shared/cores.dart';
import 'package:sgm/shared/profile_appbar.dart';

class HomeSupervisor extends StatefulWidget {
  const HomeSupervisor({ Key? key }) : super(key: key);

  @override
  State<HomeSupervisor> createState() => _HomeSupervisorState();
}

class _HomeSupervisorState extends State<HomeSupervisor> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: CustomScrollView(
       slivers: <Widget>[
        SliverAppBar(
          shape: ContinuousRectangleBorder(
          borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(25), bottomRight: Radius.circular(25))),
          backgroundColor: azul,
          shadowColor: Colors.black,
          leading: IconButton(onPressed: (){
             Scaffold.of(context).openDrawer();
          }, icon: Icon(Icons.density_medium)),
          actions: const <Widget>[
            ProfileAppBart()
          ],
          pinned: true,
          floating: true,
          expandedHeight: 120.0,
          flexibleSpace: Center(
            child: FlexibleSpaceBar(
              title: Text('Supervisor'),
            ),
          ),
        ),
        SliverFixedExtentList(
          itemExtent: 50,
          delegate: SliverChildListDelegate([
            Container(color: Colors.red),
            Container(color: Colors.green),
            Container(color: Colors.blue),
          ]),
        ),
        SliverList(
          delegate: SliverChildBuilderDelegate(
            (context, index) {
              return Container(
                height: 50,
                alignment: Alignment.center,
                color: Colors.orange[100 * (index % 9)],
                child: Text('orange $index'),
              );
            },
            childCount: 9,
          ),
        ),
        SliverGrid(
          delegate: SliverChildBuilderDelegate(
            (context, index) {
              return Container(
                alignment: Alignment.center,
                color: Colors.teal[100 * (index % 9)],
                child: Text('grid item $index'),
              );
            },
            childCount: 30,
          ),
          // gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
          //   maxCrossAxisExtent: 200.0,
          //   mainAxisSpacing: 10.0,
          //   crossAxisSpacing: 10.0,
          //   childAspectRatio: 4.0,
          // ),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            mainAxisSpacing: 15,
            crossAxisSpacing: 15,
            childAspectRatio: 2.0,
          ),
        ),
        SliverToBoxAdapter(
          child: Container(
            color: Colors.yellow,
            padding: const EdgeInsets.all(8.0),
            child: Text('Grid Header', style: TextStyle(fontSize: 24)),
          ),
        ),
        SliverGrid.count(
          crossAxisCount: 3,
          mainAxisSpacing: 10.0,
          crossAxisSpacing: 10.0,
          childAspectRatio: 4.0,
          children: <Widget>[
            Container(color: Colors.red),
            Container(color: Colors.green),
            Container(color: Colors.blue),
            Container(color: Colors.red),
            Container(color: Colors.green),
            Container(color: Colors.blue),
          ],
        ),
        SliverGrid.extent(
          maxCrossAxisExtent: 200,
          mainAxisSpacing: 10.0,
          crossAxisSpacing: 10.0,
          childAspectRatio: 4.0,
          children: <Widget>[
            Container(color: Colors.pink),
            Container(color: Colors.indigo),
            Container(color: Colors.orange),
            Container(color: Colors.pink),
            Container(color: Colors.indigo),
            Container(color: Colors.orange),
          ],
        ),
      ],
      
      ),
    );
  }
}