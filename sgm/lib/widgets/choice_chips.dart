import 'package:flutter/material.dart';
import 'package:sgm/shared/cores.dart';
import 'package:sgm/widgets/choice_chip_data.dart';

class ChoiceChips {
  static final all = <ChoiceChipData>[
    ChoiceChipData(
      label: 'Mecânico',
      isSelected: false,
      selectedColor: azul,
      textColor: Colors.white,
      circleAvatar: const CircleAvatar(
        backgroundColor:Color(0XFFF2F2F2),
        child: Icon(Icons.engineering, color: azul, size: 17,),
        ),
        categoria: "Mecânico"
    ),
    ChoiceChipData(
      label: 'Estoque',
      isSelected: false,
      selectedColor: azul,
      textColor:const Color(0XFFF2F2F2), 
      circleAvatar: const CircleAvatar(
        backgroundColor: Color(0XFFF2F2F2),
        child: Icon(Icons.inventory,
        color: azul, size: 17,),
        ),
        categoria: "Estoque"
    ),
    ChoiceChipData(
      label: 'Supervisor',
      isSelected: false,
      selectedColor: azul,
      textColor:const Color(0XFFF2F2F2),
      circleAvatar: const CircleAvatar(
        backgroundColor:Color(0XFFF2F2F2),
        child: Icon(Icons.psychology,
        color: azul, size: 17,),
        ),
        categoria: "Supervisor"
    ),
  ];
}