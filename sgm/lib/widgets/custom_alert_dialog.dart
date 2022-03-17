//Widget customizado de popup de Alerta

import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:sgm/Pacote_de_Ajuda/cores.dart';

class CustomAlertDialog extends StatefulWidget {
  final String? message;
  final bool? popOnCancel;
  final Function()? onConfirmPressed;
  final String? title;
  final String? confirmMsg;
  final String? cancelMsg;
  final Widget? container;

  const CustomAlertDialog({Key? key, 
    this.message,
    this.popOnCancel = false,
    this.title,
    this.onConfirmPressed,
    this.confirmMsg,
    this.cancelMsg, 
    this.container,
  }) : super(key: key);

  @override
  _CustomAlertDialogState createState() => _CustomAlertDialogState();
}

class _CustomAlertDialogState extends State<CustomAlertDialog> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double _borda = 20;
    TextStyle _estilo = const TextStyle(
                    fontFamily: "Montserrat",
                    fontSize: 20,
                    color: azul,
                    fontWeight: FontWeight.w500
                    );

    return BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 4, sigmaY: 4),
        child: Dialog(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(_borda)),
          backgroundColor: amareloClaro.withOpacity(0.4),
          child: Container(
            height: size.height * 0.25,
            width: size.width * 0.6,
            decoration: BoxDecoration(
                color: amareloClaro.withOpacity(0.4),
                borderRadius: BorderRadius.circular(_borda),
                border: Border.all(color: azul, width: 4)),
            child: Padding(
              padding: const EdgeInsets.all(5.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  InkWell(
                    onTap:
                      widget.popOnCancel == false
                          ? widget.onConfirmPressed
                          : () => Navigator.pop(context),
                    child: 
                    widget.popOnCancel == false
                    ? const SizedBox()
                    :
                    const Icon(Icons.cancel_outlined, color: azul, size: 30,)
                  ),
                  Align(
                      alignment: Alignment.center,
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(
                              top:10
                            ),
                            child: Text(widget.title!, style: _estilo),
                          ),
                          SizedBox(
                              height:
                                  MediaQuery.of(context).size.height * 0.02),
                          Center(child: Text(widget.message!, style: const TextStyle(
                                fontFamily: "Montserrat",
                                fontSize: 18,
                                color: azul,
                                fontWeight: FontWeight.w400
                          ),
                               textAlign: TextAlign.center,
                          )),
                        ],
                      )),

                  SizedBox(height: size.height * 0.03),
                  //confirmar ou cancelar
                  Center(
                    child: Row(children: [
                      //confirmar
                      widget.confirmMsg != null
                          ? Expanded(
                              child: Center(
                                  child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(12),
                                      
                                      ),
                                      child: TextButton(
                                          child: Text(widget.confirmMsg!,
                                              style: const TextStyle(
                                                  color: azul)),
                                          onPressed: widget.onConfirmPressed
                                            
                                          ))))
                          : const SizedBox(width: 0),
                      //cancelar
                      widget.cancelMsg != null
                          ? Expanded(
                              child: Center(
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12),
                                 
                                ),
                                child: TextButton(
                                    child: Text(widget.cancelMsg!,
                                        style: const TextStyle(
                                            color: azul)),
                                    onPressed: () => Navigator.pop(context)),
                              ),
                            ))
                          : const SizedBox(width: 0),

                          widget.container != null
                          ? const Expanded(child: Padding(
                            padding: EdgeInsets.only(left: 25, right: 25
                            ),
                            child: Center(
                                child: ClipRRect(
                                
                                   borderRadius: BorderRadius.all(Radius.circular(10)),
                                  child: LinearProgressIndicator(
                                    backgroundColor: azul,
                                    color: azul,
                                    minHeight: 13,
                                    
                                    
                                  ),
                                ),
                            ),
                          ),)
                          : Container()
                    ]),
                  )
                ],
              ),
            ),
          ),
        ));
  }
}