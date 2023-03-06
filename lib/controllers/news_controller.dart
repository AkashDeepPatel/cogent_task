
//apiKey = 0408eb6a7dc149afad6cdb959146aa1d

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../news_model.dart';

class NewsController extends GetxController with StateMixin{
  String baseUrl = "https://newsapi.org/v2/top-headlines?country=us&apiKey=0408eb6a7dc149afad6cdb959146aa1d";

  Rx<Root> newsList = Root().obs;

  @override
  onInit(){
    super.onInit();
    getNews();
  }

  getNews() async{
    try{
      debugPrint('start'.toString());
      change(null, status: RxStatus.loading());
      debugPrint('loading'.toString());
      var response = await Dio().get(baseUrl);
      if(response.statusCode==200){
        newsList.value = Root.fromJson(response.data);
        change(null, status: RxStatus.success());
        debugPrint(newsList.value.toString());
      }else{
        throw Exception('Failed to load users');
      }
    }catch(e){
      change(null, status: RxStatus.error());
      print(e);
    }
  }
}