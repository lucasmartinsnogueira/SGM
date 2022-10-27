import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:sgm/modules/service_order/models/service_order_model.dart';
import 'package:sgm/services/auth_services.dart';
import 'package:sgm/shared/help/colors.dart';

class Counter extends StatefulWidget {
  final ServiceOrderModel newOS;
  final String? uid;
  const Counter({required this.newOS, this.uid, Key? key}) : super(key: key);

  @override
  State<Counter> createState() => _CounterState();
}

class _CounterState extends State<Counter> {
  late Duration duration = Duration(seconds: widget.newOS.tempoEspec!);

  bool isCountDown = true;
  Timer? timer;
  bool disableButtom = false;

  @override
  void initState() {
    super.initState();
  }

  void startTimer({bool resets = true}) {
    if (resets) {
      reset();
    }
    timer = Timer.periodic(const Duration(seconds: 1), (_) => addTime());
  }

  void reset() {
    setState(() => duration = const Duration());
  }

  Future<void> addTime() async {
    const addSeconds = 1;

    if (mounted) {
      setState(() {
        final seconds = duration.inSeconds + addSeconds;
        duration = Duration(seconds: seconds);
      });
    } else {
      final seconds = duration.inSeconds + addSeconds;
      duration = Duration(seconds: seconds);
      await FirebaseFirestore.instance
          .collection("OSs")
          .doc(widget.newOS.id)
          .collection("trabalhos")
          .doc(widget.uid)
          .update({"tempo": duration.inSeconds});
      stopTimer(resets: false);
    }
  }

  void stopTimer({bool resets = true}) {
    if (resets) {
      reset();
    }
    if (mounted) {
      setState(() => timer?.cancel());
    } else {
      timer?.cancel();
    }
  }

  @override
  Widget build(BuildContext context) {
    AuthService auth = Provider.of<AuthService>(context);
    return Container(
      height: 200,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        border: const Border(top: BorderSide(width: 8, color: blue)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.8),
            spreadRadius: 5,
            blurRadius: 7,
            offset: const Offset(0, 3),
          )
        ],
        color: pink,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(child: buildTime()),
          const SizedBox(
            height: 5,
          ),
          buildButtons(auth.usuario!.uid),
        ],
      ),
    );
  }

  Widget buildButtons(uid) {
    final isRunning = timer == null ? false : timer!.isActive;
    final isCompleted = duration.inSeconds == 0;

    return isRunning || !isCompleted
        ? Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                  tooltip: isRunning ? "Pausar" : "Continuar",
                  onPressed: () async {
                    if (disableButtom == false) {
                      setState(() {
                        disableButtom == true;
                      });
                      if (isRunning) {
                        stopTimer(resets: false);
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30),
                              ),
                              title: const Text("Salvando..."),
                              backgroundColor: lightyellow,
                              content: const SizedBox(
                                height: 25,
                                child: ClipRRect(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(35)),
                                  child: LinearProgressIndicator(
                                    color: blue,
                                    backgroundColor: pink,
                                  ),
                                ),
                              ),
                            );
                          },
                        );
                        await FirebaseFirestore.instance
                            .collection("OSs")
                            .doc(widget.newOS.id)
                            .collection("trabalhos")
                            .doc(uid)
                            .update({"tempo": duration.inSeconds});
                        Navigator.pop(context);
                      } else {
                        startTimer(resets: false);
                      }
                    }
                  },
                  icon: isRunning
                      ? const Icon(
                          Icons.stop_circle_rounded,
                          size: 55,
                          color: blue,
                        )
                      : const Icon(
                          Icons.play_circle_rounded,
                          size: 55,
                          color: blue,
                        )),
              const SizedBox(
                width: 15,
              ),
              const SizedBox(
                width: 35,
              ),
              IconButton(
                  tooltip: "Finalizar",
                  onPressed: () {
                    showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          bool endding = false;
                          return AlertDialog(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                            title: const Text("Finalizar OS"),
                            backgroundColor: lightyellow,
                            content: SizedBox(
                              height: 205,
                              child: Column(
                                children: [
                                  const Text(
                                    "Tem certeza que deseja finzalizar a OS?",
                                    textAlign: TextAlign.center,
                                  ),
                                  const SizedBox(
                                    height: 25,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: ElevatedButton(
                                        style: ButtonStyle(
                                            backgroundColor:
                                                MaterialStateProperty.all<
                                                    Color>(pink),
                                            shape: MaterialStateProperty.all<
                                                    RoundedRectangleBorder>(
                                                RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            18.0),
                                                    side: const BorderSide(
                                                        color: blue,
                                                        width: 3)))),
                                        onPressed: () async {
                                          int numStatus = 0;
                                          if (endding == false) {
                                            setState(() {
                                              endding = true;
                                            });
                                            endding = true;
                                            for (int i = 0;
                                                i <
                                                    widget.newOS.mecanicos!
                                                        .length;
                                                i++) {
                                              await FirebaseFirestore.instance
                                                  .collection("OSs")
                                                  .doc(widget.newOS.id)
                                                  .collection("trabalhos")
                                                  .doc(widget.newOS.mecanicos![
                                                      "mecanico${i + 1}"])
                                                  .get()
                                                  .then((value) {
                                                if (value.data()!["status"] ==
                                                    true) {
                                                  numStatus += 1;
                                                }
                                              });
                                            }

                                            if (numStatus == 0) {
                                              FirebaseFirestore
                                                  .instance //await não funciona
                                                  .collection("OSs")
                                                  .doc(widget.newOS.id)
                                                  .update({"feita": true});
                                            }
                                            FirebaseFirestore.instance //await não funciona
                                                .collection("OSs")
                                                .doc(widget.newOS.id)
                                                .collection("trabalhos")
                                                .doc(uid)
                                                .update({"status": true});

                                            Navigator.pop(context);
                                            Navigator.pop(context);
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(const SnackBar(
                                                    content: Text(
                                                        "OS Finalizada!")));
                                          }
                                        },
                                        child: Row(
                                          children: [
                                            Expanded(
                                                child: Padding(
                                              padding:
                                                  const EdgeInsets.all(10.0),
                                              child: Text(
                                                "Finalizar",
                                                style: GoogleFonts.poppins(
                                                    fontSize: 20,
                                                    fontWeight: FontWeight.w600,
                                                    color: blue),
                                              ),
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
                                  const SizedBox(
                                    height: 15,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(right: 10),
                                        child: Container(
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  const BorderRadius.all(
                                                      Radius.circular(10)),
                                              border: Border.all(
                                                  width: 3, color: Colors.red)),
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
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          );
                        });
                  },
                  icon: const Icon(
                    Icons.flag_circle_outlined,
                    size: 55,
                    color: Color.fromARGB(255, 134, 4, 4),
                  )),
            ],
          )
        : OutlinedButton(
            onPressed: () {
              startTimer();
            },
            child: const Text(
              'Iniciar OS',
              style: TextStyle(fontSize: 18),
            ),
            style: OutlinedButton.styleFrom(
              shadowColor: blue,
              foregroundColor: blue,
              side: const BorderSide(width: 2, color: blue),
              shape: const StadiumBorder(),
            ),
          );
  }

  Widget buildTime() {
    String twoDigits(int n) => n.toString().padLeft(2, "0");
    final hours = twoDigits(duration.inHours);
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final seconds = twoDigits(duration.inSeconds.remainder(60));

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        buildTimeCard(time: hours, header: "Horas"),
        const SizedBox(
          width: 12,
        ),
        buildTimeCard(time: minutes, header: "Minutos"),
        const SizedBox(
          width: 12,
        ),
        buildTimeCard(time: seconds, header: "Segundos")
      ],
    );
  }

  buildTimeCard({required String time, required String header}) => Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: lightyellow,
              borderRadius: BorderRadius.circular(13),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.7),
                  spreadRadius: 2,
                  blurRadius: 4,
                  offset: const Offset(0, 2),
                )
              ],
            ),
            child: Text(
              time,
              style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                  fontSize: 34),
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          Text(
            header,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
          )
        ],
      );
}
