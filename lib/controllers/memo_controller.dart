import 'package:get/get.dart';
import 'package:flutter/material.dart';
import '../constant/memo_data.dart';

class MemoController extends GetxController {
  var memos = <String>[].obs;
  var editingIndex = Rxn<int>();
  var isAdding = false.obs;

  final textController = ''.obs;
  final editController = ''.obs;

  // ScrollController를 MemoController로 옮김
  final ScrollController scrollController = ScrollController();

  // 생성자에서 더미 데이터를 로드
  MemoController() {
    loadDummyData();
    ever(isAdding, (editing) {
      if (editing) {
        scrollToBottom();
      }
    });
  }

  // 더미 데이터를 memos 리스트에 추가하는 함수
  void loadDummyData() {
    memos.addAll(memoData);
  }

  void addMemo() {
    if (textController.value.isNotEmpty) {
      memos.add(textController.value);
      textController.value = '';
      isAdding.value = false;
    }
  }

  void editMemo(int index) {
    if (editController.value.isNotEmpty) {
      memos[index] = editController.value;
      editingIndex.value = null;
      editController.value = '';
    }
  }

  void setEditMode(int index, String memo) {
    editingIndex.value = index;
    editController.value = memo;
    isAdding.value = false;
  }

  void startAdding() {
    isAdding.value = true;
    editingIndex.value = null;
  }

  void cancelEditing() {
    editingIndex.value = null;
    editController.value = '';
  }

  // 스크롤을 리스트의 끝으로 이동하는 함수
  void scrollToBottom() {
    if (scrollController.hasClients) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        // 스크롤이 끝까지 완료되었는지 확인하기 위해 animateTo 사용
        scrollController.animateTo(
          scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        ).then((_) {
          // 스크롤이 끝에 도달했는지 다시 확인
          if (scrollController.position.pixels !=
              scrollController.position.maxScrollExtent) {
            scrollController.jumpTo(scrollController.position.maxScrollExtent);
          }
        });
      });
    }
  }

}
