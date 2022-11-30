import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:proyecto_final/firebase/people_courses_firebase.dart';
import 'package:proyecto_final/models/course_model.dart';
import 'package:proyecto_final/models/notifications_model.dart';
import 'package:proyecto_final/screens/details_screen.dart';
import 'package:proyecto_final/shared_preferences/preferencias.dart';

import '../firebase/courses_firebase.dart';

class MyCoursesScreen extends StatefulWidget {
  const MyCoursesScreen({Key? key}) : super(key: key);

  @override
  State<MyCoursesScreen> createState() => _MyCoursesScreenState();
}

final TextEditingController searchController = TextEditingController();

class _MyCoursesScreenState extends State<MyCoursesScreen> {
  PeopleCoursesFirebase? _peopleCoursesFirebase;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _peopleCoursesFirebase = PeopleCoursesFirebase();
  }

  @override
  Widget build(BuildContext context) {
    final ScrollController scrollController = new ScrollController();
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: height / 3,
              child: Stack(
                children: [
                  Container(
                    //height: height / 3,
                    decoration: BoxDecoration(
                      color: Colors.lightBlue,
                      borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(45),
                        bottomRight: Radius.circular(45),
                      ),
                    ),
                    child: SafeArea(
                      minimum: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Spacer(),
                          Text("Mis Cursos",
                              style: Theme.of(context).textTheme.headline1),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('', style: TextStyle(fontSize: 10)),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 600,
              child: StreamBuilder(
                  stream:
                      _peopleCoursesFirebase!.getAllCourses(Preferences.email),
                  builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (snapshot.hasData) {
                      return GridView.builder(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                        ),
                        itemCount: snapshot.data!.docs.length,
                        controller: scrollController,
                        itemBuilder: (context, index) {
                          var course = snapshot.data!.docs[index];
                          /*return ListTile(
                            leading: FadeInImage(
                              image: NetworkImage(
                                course.get('fotografia'),
                              ),
                              placeholder: NetworkImage(
                                  'https://www.superiorlawncareusa.com/wp-content/uploads/2020/05/loading-gif-png-5.gif'),
                            ),
                            title: Text(course.get('taller')),
                            subtitle:
                                Text(course.get('descripcion'), maxLines: 3),
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => DetailsScreen(
                                          taller: course.get('taller'),
                                          color: Colors.blue)));
                            },
                            /*trailing: SizedBox(
                              width: MediaQuery.of(context).size.width * 0.25,
                              child: Row(
                                children: [
                                  IconButton(
                                      onPressed: () {}, icon: Icon(Icons.edit)),
                                  IconButton(
                                      onPressed: () {
                                       // _peopleCoursesFirebase!.delCourse(place.id);
                                      },
                                      icon: Icon(Icons.delete)),
                                ],
                              ),
                            ),*/
                          );*/

                          return Container(
                            width: 110,
                            height: 100,
                            margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
                            child: Column(
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => DetailsScreen(
                                                taller: course.get('taller'),
                                                color: Colors.blue)));
                                  },
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(20),
                                    child: FadeInImage(
                                      placeholder: NetworkImage(
                                          'https://www.superiorlawncareusa.com/wp-content/uploads/2020/05/loading-gif-png-5.gif'),
                                      image: NetworkImage(
                                          '${course.get('fotografia')}'),
                                      width: 180,
                                      height: 140,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                SizedBox(height: 5),
                                Text(
                                  //movie.title,
                                  course.get('taller'),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  textAlign: TextAlign.center,
                                )
                              ],
                            ),
                          );
                        },
                      );
                    } else {
                      if (snapshot.hasError) {
                        return const Center(
                          child: Text('Error'),
                        );
                      } else {
                        return Center(child: CircularProgressIndicator());
                      }
                    }
                  }),
            ),
          ],
        ),
      ),
    );
  }
}

class _CoursePoster extends StatefulWidget {
  // final Movie movie;
//  final String heroId;

  _CoursePoster(this.snapshot);
  CourseModel snapshot;
  @override
  State<_CoursePoster> createState() => _CoursePosterState();
}

class _CoursePosterState extends State<_CoursePoster> {
  @override
  Widget build(BuildContext context) {
    //movie.heroId = heroId;

    return Container(
      width: 110,
      height: 100,
      margin: EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        children: [
          GestureDetector(
            onTap: () {},
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: FadeInImage(
                placeholder: NetworkImage(
                    'https://www.superiorlawncareusa.com/wp-content/uploads/2020/05/loading-gif-png-5.gif'),
                image: NetworkImage('${widget.snapshot.fotografia}'),
                width: 130,
                height: 120,
                fit: BoxFit.cover,
              ),
            ),
          ),
          SizedBox(height: 5),
          Text(
            //movie.title,
            widget.snapshot.taller!,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
          )
        ],
      ),
    );
  }
}
