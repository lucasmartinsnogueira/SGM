import 'package:flutter/material.dart';

class ChoiceChipData {
  final String ? label;
  final bool ? isSelected;
  Color ? textColor;
  Color ? selectedColor;
  CircleAvatar? circleAvatar;
  String ? categoria;

  ChoiceChipData({
    @required this.label,
    @required this.isSelected,
    @required this.textColor,
    @required this.selectedColor,
    @required this.circleAvatar,
    @required this.categoria,
  });

  ChoiceChipData copy({
    String ? label,
    bool ? isSelected,
    Color ? textColor,
    Color ? selectedColor,
    CircleAvatar ? circleAvatar,
    String ? categoria,
  }) =>
      ChoiceChipData(
        label: label ?? this.label,
        isSelected: isSelected ?? this.isSelected,
        textColor: textColor ?? this.textColor,
        selectedColor: selectedColor ?? this.selectedColor,
        circleAvatar: circleAvatar ?? this.circleAvatar,
        categoria: categoria ?? this.categoria
      );

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ChoiceChipData &&
          runtimeType == other.runtimeType &&
          label == other.label &&
          isSelected == other.isSelected &&
          textColor == other.textColor &&
          selectedColor == other.selectedColor &&
          circleAvatar == other.circleAvatar && 
          categoria == other.categoria;

  @override
  int get hashCode =>
      label.hashCode ^
      isSelected.hashCode ^
      textColor.hashCode ^
      selectedColor.hashCode ^
      circleAvatar.hashCode ^
      categoria.hashCode;
}