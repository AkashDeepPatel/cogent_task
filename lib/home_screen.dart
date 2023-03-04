import 'package:cogent_task/add_notes_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'auth/screens/login_screen.dart';
import 'controllers/notes_controller.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

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
                        Get.to(()=>AddNotesScreen());
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
                    CommonCircularButton(child: Icon(Icons.logout, color: Colors.red,), onPressed: (){
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
    );
  }
}

class NotesTile extends StatelessWidget {
  const NotesTile({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Card(
          elevation: 3.0,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(16))
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Title\n", style: Theme.of(context).textTheme.titleMedium),
                Text("Today I made a new note app Today I made a new note appToday I made a new note appToday I made a new note appToday I made a new note appToday I made a new note appToday I made a new note app", maxLines: 5, style: Theme.of(context).textTheme.bodyMedium)
                ,Text("\n6/03/2022", style: Theme.of(context).textTheme.titleSmall)
              ],
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
        )
        // Align(
        //     alignment: Alignment.topRight,
        //     child: Padding(
        //       padding: const EdgeInsets.all(4.0),
        //       child: CommonCircularButton(child: const Icon(Icons.delete, size: 16,), onPressed: (){}, radius: 4, color: Colors.lightBlueAccent,),
        //     ))
        ,Align(
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
  }
}
