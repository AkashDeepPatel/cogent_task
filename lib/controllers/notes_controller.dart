import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../auth/screens/login_screen.dart';
import 'package:intl/intl.dart';

var user = FirebaseAuth.instance.currentUser;
var _firestore = FirebaseFirestore.instance;

class NotesController extends GetxController{

  TextEditingController titleCtr = TextEditingController();
  TextEditingController textCtr = TextEditingController();


  addNote() {
  try {
  FirebaseFirestore.instance.collection('notes').doc(user!.phoneNumber!)
      .collection(user!.phoneNumber!).add({
    "title": titleCtr.text,
    "text": textCtr.text,
    "time": DateTime.now(),
    });
  Get.back();
  } catch (e) {
  debugPrint("$e");
    }
  }

}


class NotesList extends StatelessWidget {
  const NotesList({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: _firestore.collection('notes').doc(user!.phoneNumber!)
          .collection(user!.phoneNumber!)
          .snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Text('Something went wrong');
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Text("Loading");
        }
        return snapshot.data!.docs.isNotEmpty?GridView.builder(
            shrinkWrap: true,
            itemCount: snapshot.data!.docs.length,
            physics: const BouncingScrollPhysics(),
            // physics: NeverScrollableScrollPhysics(),
            gridDelegate:  const SliverGridDelegateWithFixedCrossAxisCount(
                mainAxisSpacing: 32,
                crossAxisSpacing: 32,
                crossAxisCount: 2,
                childAspectRatio: 0.75), itemBuilder: (context, index){
          return  Stack(
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width*0.40,
                child: Card(
                  elevation: 3.0,
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(16))
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("${snapshot.data!.docs[index].get('title')}\n", style: Theme.of(context).textTheme.titleMedium),
                        Text(snapshot.data!.docs[index].get('text'), maxLines: 5, style: Theme.of(context).textTheme.bodyMedium),
                        const Spacer(),
                        Align(
                            alignment: Alignment.bottomLeft,
                            child: Text("\n${DateFormat('dd/MM/yy').format(snapshot.data!.docs[index].get('time').toDate())}", style: Theme.of(context).textTheme.titleSmall))
                      ],
                    ),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.topRight,
                child: Column(
                  children: [
                    const SizedBox(height: 16),
                    SizedBox(
                        height: 30,
                        child: FloatingActionButton(
                          onPressed: (){}, child: const Icon(Icons.delete, size: 20,),)),
                  ],
                ),
              ),
              Align(
                  alignment: Alignment.bottomRight,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      CommonCircularButton(onPressed: (){}, radius: 4, color: Colors.redAccent,child: const Icon(Icons.edit, size: 20,),),
                      const SizedBox(height: 8),
                    ],
                  ))

            ],
          );
        }):
        Center(
          child: Text("No Notes Added, Add a note now by clicking + icon."),
        )
        ;

      },
    );
  }
}
