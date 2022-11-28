import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:provider/provider.dart';
import 'package:proyecto_final/models/course_model.dart';
import 'package:url_launcher/url_launcher.dart';

import '../firebase/courses_firebase.dart';

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
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _coursesFirebase = CoursesFirebase();
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
                  height: height * 350,
                  child: Stack(
                    children: [
                      Container(
                        width: double.maxFinite,
                        height: height * 280,
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
                        "${snapshot.data!.docs[0].get('descripcion') ?? "Censored"}",
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 48),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        "${snapshot.data!.docs[0].get('instructor')}"
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
                                Text('Type', style: TextStyle(fontSize: 24)),
                                Text(
                                  "snapshot.data?.volumeInfo?.printType",
                                  style: TextStyle(fontSize: 18),
                                ),
                              ],
                            ),
                            Column(
                              children: [
                                Text('Pages', style: TextStyle(fontSize: 24)),
                                Text(
                                  "snapshot.data?.volumeInfo?.pageCount Pages",
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
                        "Details",
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Author:",
                                    style: TextStyle(fontSize: 18),
                                  ),
                                  Text("Publisher:",
                                      style: TextStyle(fontSize: 18)),
                                  Text("Published Date:",
                                      style: TextStyle(fontSize: 18)),
                                  Text("Categorie:",
                                      style: TextStyle(fontSize: 18))
                                ],
                              ),
                              const SizedBox(width: 20),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "snapshot.data?.volumeInfo!.authors?.length != 0 ? snapshot.data?.volumeInfo!.authors![0]",
                                      style: Theme.of(context)
                                          .textTheme
                                          .headline5
                                          ?.copyWith(fontSize: 16),
                                    ),
                                    Text(
                                      "snapshot.data?.volumeInfo?.publisher}",
                                      style: Theme.of(context)
                                          .textTheme
                                          .headline5
                                          ?.copyWith(fontSize: 16),
                                    ),
                                    Text(
                                      "snapshot.data?.volumeInfo?.publishedDate}",
                                      style: Theme.of(context)
                                          .textTheme
                                          .headline5
                                          ?.copyWith(fontSize: 16),
                                    ),
                                    Text(
                                      "snapshot.data?.volumeInfo?.categories?.length != 0 ? snapshot.data?.volumeInfo!.categories![0] }",
                                      overflow: TextOverflow.ellipsis,
                                      style: Theme.of(context)
                                          .textTheme
                                          .headline5
                                          ?.copyWith(fontSize: 16),
                                    )
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
                        "Description",
                        style: TextStyle(fontSize: 42),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Container(
                        padding: const EdgeInsets.all(12),
                        child: Html(
                          data: "snapshot.data?.volumeInfo?.description}",
                        ),
                      ),
                      const SizedBox(height: 10),
                      ElevatedButton(
                        onPressed: () async {
                          Uri url =
                              Uri.parse("snapshot.data?.volumeInfo?.infoLink}");

                          if (await canLaunchUrl(url)) {
                            await launchUrl(url,
                                mode: LaunchMode.externalApplication);
                          } else {
                            throw 'could not launch $url';
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          primary: Colors.blue,
                        ),
                        child: Text(
                          "Buy",
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
}
