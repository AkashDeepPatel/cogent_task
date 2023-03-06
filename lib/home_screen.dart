import 'package:cogent_task/add_notes_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'auth/screens/login_screen.dart';
import 'controllers/notes_controller.dart';
import 'news_screen.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key}) : super(key: key);

  NotesController controller = Get.put(NotesController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Center(
          child: Column(
              children: [
                Row(
                  children: [
                    CommonCircularButton(
                      color: Colors.white,
                      onPressed: (){
                        controller.reset();
                        Get.to(()=>AddNotesScreen(), arguments: [false, "id"]);
                      },
                      child: const Icon(Icons.add, color: Colors.black,),
                    ),
                    const SizedBox(width: 16),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Welcome to Notes", style: Theme.of(context).textTheme.titleMedium),
                        Text("Have a nice day!", style: Theme.of(context).textTheme.titleSmall)
                      ],
                    ),
                    const Spacer(),
                    CommonCircularButton(child: const Icon(Icons.logout, color: Colors.red,), onPressed: (){
                      FirebaseAuth.instance.signOut();
                      Get.to(()=>LoginScreen());
                    })
                  ],
                ),
                Expanded(
                  child: NotesList(),
                )
              ],
          ),
        ),
      ),
      floatingActionButton: CommonCircularButton(child: const Icon(Icons.article, color: Colors.black,), onPressed: (){
          Get.to(()=> NewsScreen());
      }),
    );
  }
}
