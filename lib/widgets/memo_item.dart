import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/memo_controller.dart';

class MemoItem extends StatelessWidget {
  final int index;
  final String memo;

  MemoItem({required this.index, required this.memo});

  @override
  Widget build(BuildContext context) {
    final MemoController memoController = Get.find();

    return GestureDetector(
      onTap: () {
        memoController.setEditMode(index, memo);
      },
      child: Card(
        margin: EdgeInsets.symmetric(vertical: 5),
        elevation: 3,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Obx(() {
            if (memoController.editingIndex.value == index) {
              // TextEditingController에 기존 메모 값을 설정
              final textEditingController = TextEditingController(
                  text: memoController.editController.value);

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextField(
                    controller: textEditingController,
                    onChanged: (value) =>
                    memoController.editController.value = value,
                    autofocus: true,
                    maxLines: null,
                    decoration: InputDecoration(
                      hintText: '수정할 내용을 입력하세요',
                      border: InputBorder.none,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                        onPressed: () {
                          memoController.cancelEditing(); // 수정 취소
                        },
                        child: Text('취소'),
                      ),
                      TextButton(
                        onPressed: () => memoController.editMemo(index),
                        child: Text('수정 완료'),
                      ),
                    ],
                  ),
                ],
              );
            } else {
              return Text(memo);
            }
          }),
        ),
      ),
    );
  }
}
