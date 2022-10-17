import 'dart:async';
import 'package:flutter/material.dart';
import 'package:sgm/shared/help/colors.dart';

class Counter extends StatefulWidget {
  final int time;
  const Counter({required this.time, Key? key}) : super(key: key);

  @override
  State<Counter> createState() => _CounterState();
}

class _CounterState extends State<Counter> {
  late Duration duration = Duration(seconds: widget.time);
  bool isCountDown = true;
  Timer? timer;
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

  void addTime() {
    const addSeconds = 1;

    setState(() {
      final seconds = duration.inSeconds + addSeconds;
      duration = Duration(seconds: seconds);
    });
  }

  void stopTimer({bool resets = true}) {
    if (resets) {
      reset();
    }
    setState(() => timer?.cancel());
  }

  @override
  Widget build(BuildContext context) {
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
            height: 10,
          ),
          buildButtons(),
        ],
      ),
    );
  }

  Widget buildButtons() {
    final isRunning = timer == null ? false : timer!.isActive;
    final isCompleted = duration.inSeconds == 0;

    return isRunning || !isCompleted
        ? Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                  tooltip: isRunning ? "Pausar": "Continuar",
                  onPressed: () {
                    if (isRunning) {
                      stopTimer(resets: false);
                    } else {
                      startTimer(resets: false);
                    }
                  },
                  icon: isRunning
                      ? const Icon(
                          Icons.stop_circle_rounded,
                          size: 50,
                          color: blue,
                        )
                      : const Icon(
                          Icons.play_circle_rounded,
                          size: 50,
                          color: blue,
                        )),
              const SizedBox(
                width: 15,
              ),
              
              const SizedBox(
                width: 35,
              ),
              IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.flag_circle_outlined,
                    size: 50,
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
              primary: blue,
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
