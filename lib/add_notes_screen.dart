import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'auth/screens/login_screen.dart';
import 'controllers/notes_controller.dart';

class AddNotesScreen extends StatelessWidget {
  AddNotesScreen({Key? key}) : super(key: key);

  NotesController controller = Get.put(NotesController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Stack(
          children: [
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 16.0),
                  child: Row(
                    children: [
                      CommonCircularButton(
                        onPressed: (){
                          Get.back();
                        },
                        radius: 10,
                        child: const Icon(Icons.arrow_back_outlined, color: Colors.grey,),
                      ),
                      const Spacer(),
                      CommonCircularButton(
                        radius: 10,
                        onPressed: (){},
                        child: const Icon(Icons.undo, color: Colors.grey,),
                      ),
                      CommonCircularButton(
                        radius: 10,
                        onPressed: (){},
                        child: const Icon(Icons.redo, color: Colors.grey,),
                      ),
                      CommonCircularButton(
                        radius: 10,
                        onPressed: (){},
                        child: const Icon(Icons.delete, color: Colors.grey,),
                      ),
                      CommonCircularButton(
                        radius: 10,
                        onPressed: (){
                          controller.addNote();
                        },
                        child: const Icon(Icons.save, color: Colors.grey,),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    // shrinkWrap: true,
                    children: [
                      TextField(
                        controller: controller.titleCtr,
                        style: Theme.of(context).textTheme.headlineMedium,
                        maxLines: 1,
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          hintText: "Title",
                        ),
                      ),
                      TextField(
                        controller: controller.textCtr,
                        style: Theme.of(context).textTheme.headlineSmall,
                        minLines: 1,
                        maxLines: 15,
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          hintText: "Enter Your Text Here",
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 16.0),
              child: Align(
                  alignment: Alignment.bottomLeft,
                  child: CommonCircularButton(
                      child: const Icon(Icons.image, color: Colors.grey,size: 24,), onPressed: (){})),
            ),
          ],
        ),
      ),
    );
  }
}
