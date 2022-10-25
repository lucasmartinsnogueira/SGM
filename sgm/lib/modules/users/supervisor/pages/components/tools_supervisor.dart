import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sgm/shared/help/colors.dart';

class ManageOSsWidget extends StatefulWidget {
  const ManageOSsWidget({Key? key}) : super(key: key);

  @override
  State<ManageOSsWidget> createState() => _ManageOSsWidgetState();
}

class _ManageOSsWidgetState extends State<ManageOSsWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10),
      child: Container(
        width: 120,
        decoration: BoxDecoration(
            color: blue.withOpacity(0.8),
            borderRadius: const BorderRadius.all(Radius.circular(20)),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.6),
                spreadRadius: 2,
                blurRadius: 4,
                offset: const Offset(2, 4),
              ),
            ]),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "Visualizar \nOS",
                  style: GoogleFonts.poppins(
                      fontSize: 17,
                      fontWeight: FontWeight.w600,
                      color: lightyellow),
                ),
              ),
            ),
            Center(
              child: SizedBox(
                height: 90,
                child: Image.asset("assets/supervisor/manageOSs.png",
                    fit: BoxFit.fill),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
