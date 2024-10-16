import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/memo_controller.dart';

class AddMemoInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final MemoController memoController = Get.find();

    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: GestureDetector(
        onTap: () {
          memoController.startAdding();
        },
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          padding: const EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.0),
            border: Border.all(
              color: Colors.grey,
            ),
          ),
          child: Obx(() {
            return memoController.isAdding.value
                ? Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextField(
                  onChanged: (value) =>
                  memoController.textController.value = value,
                  autofocus: true,
                  maxLines: null,
                  minLines: 3,
                  keyboardType: TextInputType.multiline,
                  decoration: const InputDecoration(
                    hintText: '댓글을 입력하세요',
                    border: InputBorder.none,
                  ),
                  onEditingComplete: () {},
                ),
                Align(
                  alignment: Alignment.bottomRight,
                  child: IconButton(
                    icon: const Icon(Icons.add_circle, color: Colors.blue),
                    onPressed: memoController.addMemo, // 메모 추가 버튼
                  ),
                ),
              ],
            )
                : const Row(
              children: [
                Icon(Icons.person, color: Colors.blue),
                SizedBox(width: 10),
                Text('댓글 추가...'),
              ],
            );
          }),
        ),
      ),
    );
  }
}
