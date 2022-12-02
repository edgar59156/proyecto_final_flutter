import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:provider/provider.dart';
import 'package:proyecto_final/models/course_model.dart';
import 'package:proyecto_final/models/people_course_model.dart';
import 'package:proyecto_final/shared_preferences/preferencias.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '../firebase/courses_firebase.dart';
import '../firebase/people_courses_firebase.dart';

class DetailsScreen extends StatefulWidget {
  DetailsScreen(
      {Key? key, required this.taller, this.boxColor, required this.color})
      : super(key: key);
  Color color;
  var taller;
  final Color? boxColor;

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  CoursesFirebase? _coursesFirebase;
  PeopleCoursesFirebase? _peopleCoursesFirebase;
  final RoundedLoadingButtonController _btnController =
      RoundedLoadingButtonController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _coursesFirebase = CoursesFirebase();
    _peopleCoursesFirebase = PeopleCoursesFirebase();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height / 815;
    double width = MediaQuery.of(context).size.width / 375;

    return Scaffold(
        body: SingleChildScrollView(
            child: StreamBuilder(
      stream: _coursesFirebase!.getCourse(widget.taller),
      builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return const Center(
            child: Text("Opps! Try again later!"),
          );
        }
        if (snapshot.hasData) {
          return SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: height * 240,
                  child: Stack(
                    children: [
                      Container(
                        width: double.maxFinite,
                        height: height * 210,
                        decoration: BoxDecoration(
                          color: widget.boxColor ?? widget.color,
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
                              image: NetworkImage(
                                  "${snapshot.data!.docs[0].get('fotografia')}"),
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
                        "${snapshot.data!.docs[0].get('taller') ?? "Censored"}",
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 48),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        "Instructor: ${snapshot.data!.docs[0].get('instructor')}"
                            .toUpperCase(),
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
                            Column(
                              children: [
                                Text('Costo', style: TextStyle(fontSize: 24)),
                                Text(
                                  "${snapshot.data!.docs[0].get('costo') ?? "Censored"}",
                                  style: TextStyle(fontSize: 18),
                                ),
                              ],
                            ),
                            Column(
                              children: [
                                Text('Horario', style: TextStyle(fontSize: 24)),
                                Text(
                                  "${snapshot.data!.docs[0].get('hora_inicio') ?? "Censored"} - ${snapshot.data!.docs[0].get('hora_fin') ?? "Censored"} ",
                                  style: TextStyle(fontSize: 18),
                                ),
                              ],
                            )
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
                        "Materiales",
                        style: TextStyle(fontSize: 40),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          Container(
                            width: 350,
                            padding: const EdgeInsets.all(12),
                            child: Html(
                              data:
                                  "${snapshot.data!.docs[0].get('materiales') ?? "Censored"}",
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Text(
                        "Video Youtube",
                        style: TextStyle(fontSize: 40),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Container(
                        margin:
                            EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                        height: MediaQuery.of(context).size.height * .30,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(50)),
                        ),
                        child: YoutubePlayer(
                          controller: YoutubePlayerController(
                            initialVideoId:
                                "${snapshot.data!.docs[0].get('video') ?? "dQw4w9WgXcQ"}",
                            flags: const YoutubePlayerFlags(
                                hideControls: false,
                                controlsVisibleAtStart: true,
                                autoPlay: true,
                                mute: false,
                                showLiveFullscreenButton: false),
                          ),
                          
                          showVideoProgressIndicator: true,
                          progressIndicatorColor: Colors.blue,
                        ),
                      ),
                      Text(
                        "Descripción",
                        style: TextStyle(fontSize: 42),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Container(
                        padding: const EdgeInsets.all(12),
                        child: Html(
                          data:
                              "${snapshot.data!.docs[0].get('descripcion') ?? "Censored"}",
                        ),
                      ),
                      const SizedBox(height: 10),
                      RoundedLoadingButton(
                        child: Text('Inscribirme',
                            style: TextStyle(color: Colors.white)),
                        controller: _btnController,
                        onPressed: () async {
                          Timer(Duration(seconds: 3), () async {
                            PeopleCourseModel objCourse = PeopleCourseModel(
                                costo: snapshot.data!.docs[0].get('costo'),
                                descripcion:
                                    snapshot.data!.docs[0].get('descripcion'),
                                email: Preferences.email,
                                fotografia:
                                    snapshot.data!.docs[0].get('fotografia'),
                                hora_fin:
                                    snapshot.data!.docs[0].get('hora_fin'),
                                hora_inicio:
                                    snapshot.data!.docs[0].get('hora_inicio'),
                                id_taller:
                                    snapshot.data!.docs[0].get('id_taller'),
                                materiales:
                                    snapshot.data!.docs[0].get('materiales'),
                                taller: snapshot.data!.docs[0].get('taller'));
                            _peopleCoursesFirebase!.insPeopleCourse(objCourse);
                            _btnController.success();
                          });
                        },
                      ),
                      /*ElevatedButton(
                        onPressed: () async {
                          PeopleCourseModel objCourse = PeopleCourseModel(
                              costo: snapshot.data!.docs[0].get('costo'),
                              descripcion:
                                  snapshot.data!.docs[0].get('descripcion'),
                              email: Preferences.email,
                              fotografia:
                                  snapshot.data!.docs[0].get('fotografia'),
                              hora_fin: snapshot.data!.docs[0].get('hora_fin'),
                              hora_inicio:
                                  snapshot.data!.docs[0].get('hora_inicio'),
                              id_taller:
                                  snapshot.data!.docs[0].get('id_taller'),
                              materiales:
                                  snapshot.data!.docs[0].get('materiales'),
                              taller: snapshot.data!.docs[0].get('taller'));
                          _peopleCoursesFirebase!.insPeopleCourse(objCourse);
                        },
                        style: ElevatedButton.styleFrom(
                          primary: Colors.blue,
                        ),
                        child: Text(
                          "Inscribirme",
                          style: Theme.of(context)
                              .textTheme
                              .headline2
                              ?.copyWith(fontSize: 18, color: Colors.white),
                        ),
                      ),
                    */
                    ],
                  ),
                ),
              ],
            ),
          );
        }
        return Center(
            child: CircularProgressIndicator(
          color: Colors.black,
        ));
      },
    )));
  }

  void _doSomething() async {
    Timer(Duration(seconds: 3), () {
      _btnController.success();
    });
  }
}
