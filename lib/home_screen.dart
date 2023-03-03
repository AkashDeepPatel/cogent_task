import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'auth/screens/login_screen.dart';

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
                    Spacer(),
                    ElevatedButton(onPressed: (){
                      FirebaseAuth.instance.signOut();
                      Get.to(()=>LoginScreen());
                    }, child: Text("Logout"))
                  ],
                ),
                Expanded(
                  child: GridView.builder(
                    shrinkWrap: true,
                      itemCount: 10,
                      physics: const BouncingScrollPhysics(),
                      // physics: NeverScrollableScrollPhysics(),
                      gridDelegate:  const SliverGridDelegateWithFixedCrossAxisCount(
                      mainAxisSpacing: 32,
                      crossAxisSpacing: 32,
                      crossAxisCount: 2,
                      childAspectRatio: 0.75), itemBuilder: (context, index){
                    return Stack(
                      children: [
                        Card(
                          elevation: 3.0,
                          shape: RoundedRectangleBorder(
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
                              SizedBox(height: 16),
                              SizedBox(
                                  height: 30,
                                  child: FloatingActionButton(
                                    onPressed: (){}, child: Icon(Icons.delete, size: 20,),)),
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
                                SizedBox(height: 8),
                              ],
                            ))

                      ],
                    );
                  }),
                )
              ],
          ),
        ),
      ),
    );
  }
}
