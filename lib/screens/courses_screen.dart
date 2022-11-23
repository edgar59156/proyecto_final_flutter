import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../firebase/courses_firebase.dart';

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
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: height / 2,
              child: Stack(
                children: [
                  Container(
                    height: height / 3,
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
              height: 400,
              child: StreamBuilder(
                  stream: _coursesFirebase!.getAllCourses(),
                  builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (snapshot.hasData) {
                      return ListView.builder(
                        itemCount: snapshot.data!.docs.length,
                        itemBuilder: (context, index) {
                          var place = snapshot.data!.docs[index];
                          return ListTile(
                            leading: FadeInImage(
                              image: NetworkImage(place.get('fotografia')),
                              placeholder:
                                  NetworkImage(place.get('fotografia')),
                            ),
                            title: Text(place.get('taller')),
                            subtitle: Text(place.get('descripcion')),
                            trailing: SizedBox(
                              width: MediaQuery.of(context).size.width * 0.25,
                              child: Row(
                                children: [
                                  IconButton(
                                      onPressed: () {}, icon: Icon(Icons.edit)),
                                  IconButton(
                                      onPressed: () {
                                        _coursesFirebase!.delCourse(place.id);
                                      },
                                      icon: Icon(Icons.delete)),
                                ],
                              ),
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
                        return const CircularProgressIndicator();
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
