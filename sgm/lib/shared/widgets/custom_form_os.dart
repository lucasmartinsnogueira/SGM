//Widget customizado de popup de Alerta
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sgm/shared/help/colors.dart';
import 'package:sgm/shared/widgets/custom_Text_Form_Field.dart';
import 'package:sgm/shared/widgets/custom_alert_dialog.dart';

class FormOSs extends StatefulWidget {
  final List<Map<String, dynamic>>? mapDoc;
  const FormOSs({Key? key, required this.mapDoc}) : super(key: key);

  @override
  State<FormOSs> createState() => _FormOSsState();
}

class _FormOSsState extends State<FormOSs> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  String dropdownValue = 'One';
  int filterChipCount = 0;
  bool boolOne = false;
  bool boolTwo = false;
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: StatefulBuilder(builder: (context, setState) {
        return Padding(
          padding: const EdgeInsets.only(
            left: 3,
            right: 3,
            bottom: 8,
            top: 40
          ),
          child: Container(
              width: MediaQuery.of(context).size.width,
              decoration: const BoxDecoration(
                color: lightyellow,
                borderRadius: BorderRadius.vertical(top: Radius.circular(30.0)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black,
                    offset: Offset(0.0, 1.0), //(x,y)
                    blurRadius: 8.0,
                  ),
                ],
              ),
              child: Form(
                key: formKey,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 5),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(
                              child: Padding(
                            padding: const EdgeInsets.only(left: 20),
                            child: Text("Criar Ordem de Serviço",
                                style: GoogleFonts.poppins(
                                    fontSize: 25, fontWeight: FontWeight.w400)),
                          )),
                          IconButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              icon: const Icon(
                                Icons.expand_more_rounded,
                                size: 30,
                              )),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16),
                      child: Text(
                        "Escolha os mecânicos",
                        style: GoogleFonts.poppins(
                          fontSize: 20,
                        ),
                      ),
                    ),
                    buildFilterChips(),
                    Padding(
                      padding: const EdgeInsets.all(16),
                      child: Text(
                        "Qual o título?",
                        style: GoogleFonts.poppins(
                          fontSize: 20,
                        ),
                      ),
                    ),
                    const CustomTextFormField(activated: true, label: "Escreva o título...", maxlines: 1, keyboardType: TextInputType.text),
                    Padding(
                        padding: const EdgeInsets.all(16),
                        child: SwitchListTile(
                          activeColor: pink,
                          value: boolOne,
                          title: Text("Qual a carreta?", style: GoogleFonts.poppins(
                          fontSize: 20,
                        ),),
                          onChanged: (bool value) {
                            setState(() => boolOne = value);
                          },
                          

                        )),
                    CustomTextFormField(activated: boolOne, label: "02", maxlines: 1, keyboardType: TextInputType.number),
                    Padding(
                      padding: const EdgeInsets.all(16),
                      child: SwitchListTile(
                          activeColor: pink,
                          value: boolTwo,
                          title: Text("Qual o cavalo?", style: GoogleFonts.poppins(
                          fontSize: 20,
                        ),),
                          onChanged: (bool value) {
                            setState(() => boolTwo = value);
                          },
                      ),
                    ),
          

                      
                      
                    
                    CustomTextFormField(activated: boolTwo, label: "75", maxlines: 1, keyboardType: TextInputType.number),
                    Padding(
                      padding: const EdgeInsets.all(16),
                      child: Text(
                        "Descreva a OS",
                        style: GoogleFonts.poppins(
                          fontSize: 20,
                        ),
                      ),
                    ),
                    const CustomTextFormField(activated: true, label: "Descreva a atividade...", maxlines: 3, keyboardType: TextInputType.text),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 25),
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width * 0.8,
                        height: 60,
                        child: ElevatedButton(
                            style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all<Color>(pink),
                                shape: MaterialStateProperty.all<
                                        RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(18.0),
                                        side: const BorderSide(
                                            color: blue, width: 3)))),
                            onPressed: () {},
                            child: Row(
                              children: [
                                Expanded(
                                    child: Text(
                                  "Enviar OS",
                                  style: GoogleFonts.poppins(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w600,
                                      color: blue),
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
                    )
                  ],
                ),
              )),
        );
      }),
    );
  }

  Widget buildFilterChips() {
    return Wrap(
      runSpacing: 10,
      spacing: 10,
      children: widget.mapDoc!
          .map((filterChipData) => FilterChip(
              label: Text(
                filterChipData["name"]
                    .toString()
                    .split(" ")
                    .getRange(0, 2)
                    .toString()
                    .replaceAll("(", "")
                    .replaceAll(")", "")
                    .replaceAll(",", ""),
              ),
              labelStyle: TextStyle(
                  fontWeight: FontWeight.bold, color: red.withOpacity(0.8)),
              backgroundColor: red.withOpacity(0.1),
              onSelected: (isSelected) => setState(() {
                    if (isSelected == false) {
                      filterChipCount = filterChipCount + 1;
                    } else if (isSelected == true) {
                      filterChipCount = filterChipCount - 1;
                    }
                    if (filterChipCount <= 4) {
                      if (filterChipData["selected"] == true) {
                        filterChipData["selected"] = false;
                      } else if (filterChipData["selected"] == false) {
                        filterChipData["selected"] = true;
                      }
                    } else if (filterChipCount > 4) {
                      filterChipCount = 4;
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return const CustomAlertDialog(
                            title: "Opção inválida",
                            message:
                                "Uma OS só pode ser atribuída a no máximo 4 mecânicos",
                            popOnCancel: true,
                          );
                        },
                      );
                    }
                  }),
              selected: filterChipData["selected"],
              checkmarkColor: red,
              selectedColor: blue))
          .toList(),
    );
  }
}
