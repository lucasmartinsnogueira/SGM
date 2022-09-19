import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sgm/modules/users/stock/controllers/gerenciastock_controller.dart';
import 'package:sgm/shared/help/colors.dart';

class CustomButtom extends StatefulWidget {
  final String text;
  final void Function() function;
  const CustomButtom({
    required this.function,
    required this.text, Key? key}) : super(key: key);

  @override
  State<CustomButtom> createState() => _CustomButtomState();
}

class _CustomButtomState extends State<CustomButtom> {
 
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 25),
      child: SizedBox(
        width: MediaQuery.of(context).size.width * 0.8,
        height: 60,
        child: ElevatedButton(
            style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(pink),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18.0),
                        side: const BorderSide(color: blue, width: 3)))),
            onPressed: widget.function,
            child: Row(
              children: [
                Expanded(
                    child: Text(
                  widget.text,
                  style: GoogleFonts.poppins(
                      fontSize: 20, fontWeight: FontWeight.w600, color: blue),
                )),
            
                     const Expanded(
                        child: Icon(
                        Icons.send_rounded,
                        size: 30,
                        color: blue,
                      ))
                     
              ],
            )),
      ),
    );
  }
}
