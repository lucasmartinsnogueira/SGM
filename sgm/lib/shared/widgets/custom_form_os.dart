//Widget customizado de popup de Alerta
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sgm/shared/help/colors.dart';
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
  @override
  Widget build(BuildContext context) {
    return StatefulBuilder(builder: (context, setState) {
      return Container(
          height: MediaQuery.of(context).size.height * 0.85,
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
                /*const Text("Número de Mecânicos"),
                NumberPicker(
                  haptics: true,
                  selectedTextStyle: const TextStyle(
                      color: blue, fontSize: 32, fontWeight: FontWeight.bold),
                  axis: Axis.horizontal,
                  minValue: 1,
                  maxValue: 4,
                  value: _currentValue,
                  onChanged: (value) => setState(() => _currentValue = value),
                ),
                CustomTextFormField(),*/
                /* DropdownButton(
                  dropdownColor: lightyellow,
                  
                  value: dropdownValue,
                  icon: const Icon(Icons.arrow_downward),
                  elevation: 16,
                  style: const TextStyle(color: Colors.deepPurple),
                  underline: Container(
                    height: 2,
                    color: Colors.deepPurpleAccent,
                  ),
                  onChanged: (value) =>
                      setState(() => dropdownValue = value.toString()),
                  items: <String>['One', 'Two', 'Free', 'Four']
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                )*/

                Container(
                  child: Padding(
                    padding: EdgeInsets.all(16),
                    child: Text(
                      "Número de mecânicos",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 24,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                /*Wrap(
                  children: [
                    mychips("Sales"),
                    mychips("oi"),
                    mychips("roi"),
                    mychips("ola"),
                     mychips("Sales"),
                    mychips("oi"),
                    mychips("roi"),
                    mychips("ola"),
                  ],
                ),
                */
                buildFilterChips()
              ],
            ),
          ));
    });
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

/*
  SizedBox mychips(String chipName) {
    return SizedBox(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5),
                    child: ElevatedButton(
                style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(
                        red.withOpacity(0.6),
                      ),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18.0),
                              side: BorderSide(color: blue, width: 3)))),
                onPressed: () {},
                child: Text(chipName),
              ),
                  ));
  }
  */

}
