import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:proyecto_final/firebase/notifications_firebase.dart';
import 'package:proyecto_final/screens/message_screen_user.dart';
import 'package:proyecto_final/shared_preferences/preferencias.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  NotificationsFirebase? _notificationsFirebase;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _notificationsFirebase = NotificationsFirebase();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height / 815;
    double width = MediaQuery.of(context).size.width / 375;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightBlue,
        elevation: 0,
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: height / 5,
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
                  stream: _notificationsFirebase!
                      .getAllNotifications(Preferences.email),
                  builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (snapshot.hasData) {
                      return ListView.builder(
                        itemCount: snapshot.data!.docs.length,
                        itemBuilder: (context, index) {
                          var notification = snapshot.data!.docs[index];
                          return ListTile(
                            leading: Icon(
                              Icons.notifications,
                              color: Colors.lightBlue,
                            ),
                            title: Text(notification.get('taller')),
                            subtitle: Text(notification.get('descripcion'),
                                maxLines: 3),
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => MessageScreenUser(
                                            taller: notification.get('taller'),
                                            descripcion:
                                                notification.get('descripcion'),
                                            fecha: notification.get('fecha'),
                                            instructor:
                                                notification.get('instructor'),
                                            mensaje:
                                                notification.get('mensaje'),
                                            titulo: notification.get('titulo'),
                                            to_email:
                                                notification.get('to_email'),
                                          )));
                            },
                            /*trailing: SizedBox(
                              width: MediaQuery.of(context).size.width * 0.25,
                              child: Row(
                                children: [
                                  IconButton(
                                      onPressed: () {}, icon: Icon(Icons.edit)),
                                  IconButton(
                                      onPressed: () {
                                       // _notificationsFirebase!.delnotification(place.id);
                                      },
                                      icon: Icon(Icons.delete)),
                                ],
                              ),
                            ),*/
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
