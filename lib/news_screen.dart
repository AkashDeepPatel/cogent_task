import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'controllers/news_controller.dart';
import 'news_model.dart';

class NewsScreen extends StatelessWidget {
  NewsScreen({Key? key}) : super(key: key);

  NewsController controller = Get.put(NewsController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("News"),
      ),
      body: controller.obx((state) => RefreshIndicator(
        onRefresh: () async{
          await controller.getNews();
        },
        child: ListView.builder(
            itemCount: controller.newsList.value.articles!.length,
            itemBuilder: (context, index){
              Article model = controller.newsList.value.articles![index]!;
              return Card(
                child: Row(
                  children: [
                    Expanded(
                        flex: 3,
                        child: Image.network(model.urlToImage??"https://cdn.vectorstock.com/i/preview-1x/65/30/default-image-icon-missing-picture-page-vector-40546530.jpg", height: 75, width: 50,)),
                    const SizedBox(width: 8),
                    Expanded(
                      flex: 10,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(model.title??"Title", maxLines: 2, overflow: TextOverflow.fade, style: Theme.of(context).textTheme.titleSmall,),
                          Text(model.description??"Desc", maxLines: 3, overflow: TextOverflow.fade,),
                        ],
                      ),
                    ),

                  ],
                ),
              );
            }),
      ),
          onLoading: const Center(child: Text("Loading"),)
    ),);
  }
}
