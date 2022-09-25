import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sgm/shared/help/colors.dart';
import 'package:url_launcher/url_launcher.dart';

class CustomDrawer extends StatefulWidget {
  final Color? color;
  final Color? secondaryColor;
  const CustomDrawer(
      {required this.color, required this.secondaryColor, Key? key})
      : super(key: key);

  @override
  State<CustomDrawer> createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 50, bottom: 20),
      child: Drawer(
          elevation: 10,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(20),
                bottomRight: Radius.circular(20)),
          ),
          backgroundColor: widget.color,
          child: ListView(
            children: [
              DrawerHeader(
                  child: Container(
                decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.5),
                        spreadRadius: 3,
                        blurRadius: 2,
                        offset: const Offset(0, 0),
                      )
                    ],
                    shape: BoxShape.circle,
                    border:
                        Border.all(width: 6, color: widget.secondaryColor!)),
                child: CircleAvatar(
                    backgroundColor: lightyellow,
                    radius: 25,
                    child: Image.asset(
                      "assets/pricipal/tela_inicial.png",
                      width: 205,
                    )),
              )),
              ListTile(
                trailing: Icon(
                  Icons.link_rounded,
                  color: widget.secondaryColor,
                ),
                onTap: () {},
                leading: Icon(Icons.video_collection_outlined,
                    color: widget.secondaryColor),
                title: Text(
                  "Tutoriais",
                  style: GoogleFonts.poppins(
                      fontWeight: FontWeight.w600, color: blue),
                ),
              ),
              ListTile(
                trailing: Icon(
                  Icons.link_rounded,
                  color: widget.secondaryColor,
                ),
                onTap: () async {
                  final Uri url = Uri.parse(
                      'https://github.com/lucasmartinsnogueira?tab=repositories');
                  if (!await launchUrl(url,
                      mode: LaunchMode.externalApplication)) {
                    throw 'Could not launch $url';
                  }
                },
                leading: Icon(Icons.description_outlined,
                    color: widget.secondaryColor),
                title: Text(
                  "Documentos",
                  style: GoogleFonts.poppins(
                      fontWeight: FontWeight.w600, color: blue),
                ),
              ),
              ListTile(
                trailing: Icon(
                  Icons.link_rounded,
                  color: widget.secondaryColor,
                ),
                onTap: () {},
                leading:
                    Icon(Icons.terminal_outlined, color: widget.secondaryColor),
                title: Text(
                  "Sofware",
                  style: GoogleFonts.poppins(
                      fontWeight: FontWeight.w600, color: blue),
                ),
                subtitle: Text(
                  "Baixar versão desktop\nAcessar código fonte",
                  style: GoogleFonts.poppins(fontSize: 12, color: blue),
                ),
                isThreeLine: true,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "Autores",
                  style: GoogleFonts.poppins(
                      fontSize: 25, fontWeight: FontWeight.w600, color: blue),
                ),
              ),
              ListTile(
                trailing: Icon(
                  Icons.link_rounded,
                  color: widget.secondaryColor,
                ),
                onTap: () {},
                leading: Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: ClipRRect(
                    borderRadius: const BorderRadius.all(Radius.circular(50)),
                    child: Image.asset(
                      "assets/autors/lucas.jpg",
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                title: Text(
                  "Lucas",
                  style: GoogleFonts.poppins(
                      fontWeight: FontWeight.w600, color: blue),
                ),
                subtitle: Text(
                  "Martins Nogueira",
                  style: GoogleFonts.poppins(fontSize: 12, color: blue),
                ),
              ),
              ListTile(
                trailing: Icon(
                  Icons.link_rounded,
                  color: widget.secondaryColor,
                ),
                onTap: () {},
                leading: Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: ClipRRect(
                    borderRadius: const BorderRadius.all(Radius.circular(50)),
                    child: Image.asset(
                      "assets/autors/luisa.jpg",
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                title: Text(
                  "Luísa",
                  style: GoogleFonts.poppins(
                      fontWeight: FontWeight.w600, color: blue),
                ),
                subtitle: Text(
                  "Sousa Santos",
                  style: GoogleFonts.poppins(fontSize: 12, color: blue),
                ),
              ),
              ListTile(
                trailing: Icon(
                  Icons.link_rounded,
                  color: widget.secondaryColor,
                ),
                onTap: () {},
                leading: Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: ClipRRect(
                    borderRadius: const BorderRadius.all(Radius.circular(50)),
                    child: Image.asset(
                      "assets/autors/sarah.jpg",
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                title: Text(
                  "Sarah",
                  style: GoogleFonts.poppins(
                      fontWeight: FontWeight.w600, color: blue),
                ),
                subtitle: Text(
                  "Azevedo Pereira",
                  style: GoogleFonts.poppins(fontSize: 12, color: blue),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Center(
                  child: Text(
                    "SGM V1.0",
                    style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w600, color: blue),
                  ),
                ),
              ),
              const Center(
                child: Text(
                  'Todos direitos reservados © 2022 SGM Corporation',
                  style: TextStyle(
                      fontFamily: 'Poppins', fontSize: 10, color: blue),
                ),
              ),
            ],
          )),
    );
  }
}
