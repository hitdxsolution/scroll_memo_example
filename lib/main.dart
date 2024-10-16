

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
        title: const Text('메모 리스트'),
      ),
      body: Column(
        children: [
          Expanded(
            child: Obx(() {

              return ListView(
                controller: memoController.scrollController,
                padding: const EdgeInsets.all(10),
                children: [
                  // 메모 아이템을 직접 리스트로 추가
                  ...memoController.memos.map((memo) {
                    int index = memoController.memos.indexOf(memo);
                    return MemoItem(index: index, memo: memo);
                  }),

                  // 추가 모드일 경우 입력창을 리스트 끝에 추가
                  if (memoController.isAdding.value) AddMemoInput(),
                ],
              );
            }),
          ),
          Obx(() {
            // 추가 모드가 아닐 때만 하단에 입력창 고정
            return memoController.isAdding.value
                ? const SizedBox.shrink()
                : AddMemoInput(); // 입력 모드가 아닐 때 하단에 입력창 표시
          }),
        ],
      ),
    );
  }
}
