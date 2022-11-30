import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:proyecto_final/screens/details_screen.dart';

import '../firebase/courses_firebase.dart';
import '../models/course_model.dart';

class CoursesScreen extends StatefulWidget {
  const CoursesScreen({Key? key}) : super(key: key);

  @override
  State<CoursesScreen> createState() => _CoursesScreenState();
}

final TextEditingController searchController = TextEditingController();

class _CoursesScreenState extends State<CoursesScreen> {
  CoursesFirebase? _coursesFirebase;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _coursesFirebase = CoursesFirebase();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    final ScrollController scrollController = new ScrollController();

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: height / 5.3,
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
                          Text("Cursos",
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
                  stream: _coursesFirebase!.getAllCourses(),
                  builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (snapshot.hasData) {
                      return GridView.builder(
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
                                       // _coursesFirebase!.delCourse(place.id);
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
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                        ),
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
      height: 200,
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
