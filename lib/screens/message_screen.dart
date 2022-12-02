import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:proyecto_final/models/arguments_model.dart';
//${args['titulo']}

class MessageScreen extends StatelessWidget {
  const MessageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height / 815;
    double width = MediaQuery.of(context).size.width / 375;
    final args =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>;

    return Scaffold(
        body: SingleChildScrollView(
            child: Column(
      children: [
        SizedBox(
          height: height * 350,
          child: Stack(
            children: [
              Container(
                width: double.maxFinite,
                height: height * 280,
                decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(35),
                    bottomRight: Radius.circular(35),
                  ),
                ),
              ),
              Positioned(
                left: 0,
                right: 0,
                bottom: 0,
                child: Container(
                  height: height * 100,
                  alignment: Alignment.center,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image(
                      image: AssetImage('assets/notification.png'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              Positioned(
                top: 70,
                left: 16,
                child: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  style: OutlinedButton.styleFrom(
                      side: const BorderSide(width: 1)),
                  icon: Icon(
                    Icons.arrow_back,
                    color: Colors.black,
                  ),
                ),
              ),
            ],
          ),
        ),
        Container(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                "${args['titulo'] ?? "Censored"}",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 48),
              ),
              const SizedBox(height: 10),
              Text(
                "${args['taller']}".toUpperCase(),
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 24),
              ),
              const SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 35),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    /*Column(
                     children: [
                        Text('Type', style: TextStyle(fontSize: 24)),
                        Text(
                          "snapshot.data?.volumeInfo?.printType",
                          style: TextStyle(fontSize: 18),
                        ),
                      ],
                    ),*/
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                "Detalles",
                style: TextStyle(fontSize: 40),
              ),
              const SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 0, 20, 10),
                child: SizedBox(
                  child: Row(
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Instructor:",
                            style: TextStyle(fontSize: 18),
                          ),
                          Text("Fecha:", style: TextStyle(fontSize: 18)),
                        ],
                      ),
                      const SizedBox(width: 20),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${args['instructor'] ?? "Instructor no especificado"}",
                              style: Theme.of(context)
                                  .textTheme
                                  .headline5
                                  ?.copyWith(fontSize: 16),
                            ),
                            Text(
                              "${args['fecha'] ?? "Fecha no especificada"}",
                              style: Theme.of(context)
                                  .textTheme
                                  .headline5
                                  ?.copyWith(fontSize: 16),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                "Descripción",
                style: TextStyle(fontSize: 42),
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                height: 200,
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  border: Border.all(
                    width: 0.5,
                  ),
                ),
                child: Text(
                  "${args['descripcion'] ?? "Sin descripción"}",
                  style: TextStyle(fontSize: 20),
                ),
              ),
              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: () async {

                  Navigator.pop(context);
                  /*
                    Uri url = Uri.parse("snapshot.data?.volumeInfo?.infoLink}");

                    if (await canLaunchUrl(url)) {
                      await launchUrl(url,
                          mode: LaunchMode.externalApplication);
                    } else {
                      throw 'could not launch $url';
                    }*/
                },
                style: ElevatedButton.styleFrom(
                  primary: Colors.blue,
                ),
                child: Text(
                  "Recibido",
                  style: Theme.of(context)
                      .textTheme
                      .headline2
                      ?.copyWith(fontSize: 18, color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ],
    )));
  }
}
