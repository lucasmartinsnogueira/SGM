import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:sgm/modules/service_order/model/serviceorder.dart';
import 'package:sgm/services/auth_services.dart';
import 'package:sgm/shared/help/colors.dart';
import 'package:sgm/shared/widgets/custom_Text_Form_Field.dart';
import 'package:sgm/shared/widgets/custom_alert_dialog.dart';
import '../../database/firebase/firestore_api.dart';

class FormOSs extends StatefulWidget {
  final List<Map<String, dynamic>>? mapDoc;
  const FormOSs({Key? key, required this.mapDoc}) : super(key: key);

  @override
  State<FormOSs> createState() => _FormOSsState();
}

class _FormOSsState extends State<FormOSs> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  //mecânicos
  String dropdownValue = 'One';
  int filterChipCount = 0;
  List<String> mecDoc = [];
  Map<String, dynamic> firestoreMecDoc = {};

  //SwichList
  bool boolZero = false;
  bool boolOne = false;
  bool boolTwo = false;

  //Imagem método
  UploadTask? task;
  XFile? image;

  //Imagem classe
  File? imageOS;

  //Text Controllers
  TextEditingController title = TextEditingController();
  TextEditingController cart = TextEditingController();
  TextEditingController horse = TextEditingController();
  TextEditingController description = TextEditingController();

  //Documento OS
  String? docOS;

  //Alterar estado do envio de dados
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    //Usuário
    AuthService auth = Provider.of<AuthService>(context);
    return SingleChildScrollView(
      child: StatefulBuilder(builder: (context, setState) {
        return Padding(
          padding: const EdgeInsets.only(left: 3, right: 3, bottom: 8, top: 40),
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
                    CustomTextFormField(
                        activated: true,
                        label: "Escreva o título...",
                        maxlines: 1,
                        keyboardType: TextInputType.text,
                        controller: title,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "*Campo obrigatório";
                          } else if (value.length < 3) {
                            return "*O título deve ter pelo menos 3 caracteres";
                          }

                          return null;
                        }),
                    Padding(
                      padding: const EdgeInsets.all(16),
                      child: Text(
                        (imageOS == null)
                            ? "Insira uma imagem"
                            : "Imagem inserida:",
                        style: GoogleFonts.poppins(
                          fontSize: 20,
                        ),
                      ),
                    ),
                    (imageOS == null)
                        ? SizedBox(
                            width: 70,
                            height: 70,
                            child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  primary: pink,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30.0),
                                  ),
                                ),
                                onPressed: () async {
                                  await showImagePickerAlert(context);
                                  setState(() {});
                                },
                                child: const Icon(
                                  Icons.add_a_photo_rounded,
                                  size: 40,
                                  color: blue,
                                )),
                          )
                        : Stack(children: [
                            Container(
                              height: 200,
                              width: 200,
                              decoration: BoxDecoration(
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(15)),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.8),
                                    spreadRadius: 2,
                                    blurRadius: 5,
                                    offset: const Offset(0, 7),
                                  ),
                                ],
                              ),
                              child: ClipRRect(
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(15)),
                                child: Image.file(
                                  imageOS!,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            Positioned(
                              right: 0,
                              child: Padding(
                                padding: const EdgeInsets.all(3),
                                child: Container(
                                    width: 35,
                                    height: 35,
                                    decoration: BoxDecoration(
                                        color: red.withOpacity(0.7),
                                        borderRadius: const BorderRadius.all(
                                            Radius.circular(15))),
                                    child: IconButton(
                                        onPressed: () {
                                          this.setState(() {
                                            imageOS = null;
                                          });
                                        },
                                        icon: const Icon(
                                          Icons.delete_rounded,
                                          color: Colors.black,
                                          size: 20,
                                        ))),
                              ),
                            ),
                          ]),
                    Padding(
                        padding: const EdgeInsets.all(16),
                        child: SwitchListTile(
                          activeColor: pink,
                          value: boolOne,
                          title: Text(
                            "Qual a carreta?",
                            style: GoogleFonts.poppins(
                              fontSize: 20,
                            ),
                          ),
                          onChanged: (bool value) {
                            setState(() => boolOne = value);
                          },
                        )),
                    CustomTextFormField(
                        activated: boolOne,
                        enable: boolOne,
                        label: "02",
                        maxlines: 1,
                        keyboardType: TextInputType.number,
                        controller: cart,
                        validator: (value) {
                          if (boolOne == true) {
                            if (value == null || value.isEmpty) {
                              return "*Se ativado, o campo é obrigatório";
                            }
                          }
                          return null;
                        }),
                    Padding(
                      padding: const EdgeInsets.all(16),
                      child: SwitchListTile(
                        activeColor: pink,
                        value: boolTwo,
                        title: Text(
                          "Qual o cavalo?",
                          style: GoogleFonts.poppins(
                            fontSize: 20,
                          ),
                        ),
                        onChanged: (bool value) {
                          setState(() => boolTwo = value);
                        },
                      ),
                    ),
                    CustomTextFormField(
                        activated: boolTwo,
                        enable: boolTwo,
                        label: "75",
                        maxlines: 1,
                        keyboardType: TextInputType.number,
                        controller: horse,
                        validator: (value) {
                          if (boolTwo == true) {
                            if (value == null || value.isEmpty) {
                              return "*Se ativado, o campo é obrigatório";
                            }
                          }
                          return null;
                        }),
                    Padding(
                      padding: const EdgeInsets.all(16),
                      child: Text(
                        "Descreva a OS",
                        style: GoogleFonts.poppins(
                          fontSize: 20,
                        ),
                      ),
                    ),
                    CustomTextFormField(
                        activated: true,
                        label: "Descreva a atividade...",
                        maxlines: 3,
                        keyboardType: TextInputType.text,
                        controller: description,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "*Campo obrigatório";
                          } else if (value.length < 3) {
                            return "*A descrição deve ter pelo menos 3 caracteres";
                          }

                          return null;
                        }),
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
                                        borderRadius:
                                            BorderRadius.circular(18.0),
                                        side: const BorderSide(
                                            color: blue, width: 3)))),
                            onPressed: () async {
                              if (mecDoc.isEmpty) {
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return const CustomAlertDialog(
                                      title: "Nenhum mecânico",
                                      message:
                                          "É obrigatório atribuir pelo menos um mecânico a OS",
                                      popOnCancel: true,
                                    );
                                  },
                                );
                              } else {
                                if (formKey.currentState!.validate()) {
                                  this.setState(() {
                                    isLoading = true;
                                  });

                                  for (int i = 0; i < mecDoc.length; i++) {
                                    firestoreMecDoc.addAll(
                                        {"mecanico${i + 1}": mecDoc[i]});
                                  }
                                  ServiceOrder newServiceOrder = ServiceOrder(
                                      title.text,
                                      firestoreMecDoc,
                                      (horse.text == "")
                                          ? null
                                          : int.parse(horse.text),
                                      (cart.text == "")
                                          ? null
                                          : int.parse(cart.text),
                                      description.text,
                                      false,
                                      false,
                                      false,
                                      false,
                                      "",
                                      "imagem",
                                      auth.usuario!.uid,
                                      DateTime.now());
                                  try {
                                    docOS = await newServiceOrder
                                        .registerOS(newServiceOrder);
                                    await firestoreImageAlert(imageOS, docOS);
                                    for (int i = 0; i < mecDoc.length; i++) {
                                      await newServiceOrder.registerDocEachMec(
                                          docOS!, mecDoc[i]);
                                    }
                                    setState(() {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(const SnackBar(
                                              content: Text(
                                                  "OS Cadastrada com sucesso!")));
                                    });
                                    Navigator.pop(context);
                                  } on FirebaseException catch (e) {
                                    setState(() {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(SnackBar(
                                              content: Text("ERRO!: " +
                                                  e.message.toString())));
                                    });
                                  }
                                }
                                this.setState(() {
                                  isLoading = false;
                                });
                              }
                            },
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
                                (isLoading == false)
                                    ? const Expanded(
                                        child: Icon(
                                        Icons.send_rounded,
                                        size: 30,
                                        color: blue,
                                      ))
                                    : const SizedBox(
                                        width: 40,
                                        height: 40,
                                        child: CircularProgressIndicator(
                                            backgroundColor: darkyellow,
                                            color: blue))
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
                      mecDoc.remove(filterChipData["id"]);
                    } else if (isSelected == true) {
                      filterChipCount = filterChipCount - 1;

                      mecDoc.add(filterChipData["id"]);
                    }
                    debugPrint("Lista Mapa :" + mecDoc.toString());

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

  Future showImagePickerAlert(context) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: lightyellow,
            content: SizedBox(
              height: 100,
              child: Row(
                children: [
                  const Spacer(),
                  GestureDetector(
                    onTap: () => pickImageAlert(ImageSource.gallery, context),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Icon(
                          Icons.perm_media,
                          size: 40,
                          color: blue,
                        ),
                        Text(
                          "Arquivo",
                          style: TextStyle(fontSize: 20, color: blue),
                        )
                      ],
                    ),
                  ),
                  const Spacer(),
                  GestureDetector(
                    onTap: () => pickImageAlert(ImageSource.camera, context),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Icon(
                          Icons.camera,
                          size: 40,
                          color: blue,
                        ),
                        Text(
                          "Câmera",
                          style: TextStyle(fontSize: 20, color: blue),
                        )
                      ],
                    ),
                  ),
                  const Spacer(),
                ],
              ),
            ),
          );
        });
  }

  Future pickImageAlert(ImageSource source, context) async {
    try {
      final image = await ImagePicker().pickImage(source: source);
      if (image == null) return;
      final imageTemporaty = XFile(image.path);
      this.image = imageTemporaty;
      Navigator.pop(context);
      uploadImageAlert(context, image);
    } on PlatformException catch (e) {
      debugPrint("Ocorreu um erro na gravação da imagem: $e");
    }
  }

  Future firestoreImageAlert(file, storagePath) async {
    if (file == null) return;

    String destination = "ImageOSs/$storagePath";

    task = FirestoreApi.uploadFile(destination, file!);
    if (task == null) return null;
    final snapshot = await task!.whenComplete(() {});
    final url = await snapshot.ref.getDownloadURL();
    await FirebaseFirestore.instance
        .collection("OSs")
        .doc(storagePath)
        .update({"imagem": url});
  }

  uploadImageAlert(context, image) {
    File newimage = File(image.path);
    bool isloading = false;
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return StatefulBuilder(builder: (context, setState) {
            return AlertDialog(
              title: const Text("Alterar Imagem"),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              backgroundColor: lightyellow,
              actions: [
                (isloading == true)
                    ? const ClipRRect(
                        borderRadius: BorderRadius.all(Radius.circular(45)),
                        child: SizedBox(
                            width: 100,
                            height: 25,
                            child: LinearProgressIndicator(
                              backgroundColor: pink,
                              color: blue,
                            )),
                      )
                    : const SizedBox(),
                Container(
                  decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.circular(10)),
                      border: Border.all(width: 3, color: Colors.red)),
                  child: IconButton(
                      tooltip: "Cancelar",
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: const Icon(
                        Icons.clear,
                        color: Colors.red,
                      )),
                ),
                Container(
                  decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.circular(10)),
                      border: Border.all(width: 3, color: Colors.green)),
                  child: IconButton(
                      tooltip: "Inserir",
                      onPressed: () async {
                        imageOS = newimage;

                        setState(() {});

                        Navigator.pop(context);
                        this.setState(() {});
                      },
                      icon: const Icon(
                        Icons.check,
                        color: Colors.green,
                      )),
                )
              ],
              content: SizedBox(
                  width: MediaQuery.of(context).size.width * 0.8,
                  height: MediaQuery.of(context).size.width * 0.6 + 75,
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ClipRRect(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(15)),
                          child: Image.file(
                            newimage,
                            width: MediaQuery.of(context).size.width * 0.6,
                            height: MediaQuery.of(context).size.width * 0.6,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ])),
            );
          });
        });
  }
}
