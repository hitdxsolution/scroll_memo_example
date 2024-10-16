import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'controllers/memo_controller.dart';
import 'widgets/memo_item.dart';
import 'widgets/add_memo_input.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Memo List',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MemoListPage(),
    );
  }
}

class MemoListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final MemoController memoController = Get.put(MemoController());

    return Scaffold(
      appBar: AppBar(
        title: Text('메모 리스트'),
      ),
      body: Column(
        children: [
          Expanded(
            child: Obx(() {
              return ListView.builder(
                padding: EdgeInsets.all(10),
                itemCount: memoController.memos.length,
                itemBuilder: (context, index) {
                  return MemoItem(
                    index: index,
                    memo: memoController.memos[index],
                  );
                },
              );
            }),
          ),
          AddMemoInput(),
        ],
      ),

    );
  }
}
