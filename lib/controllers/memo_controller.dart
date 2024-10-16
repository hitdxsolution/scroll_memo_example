import 'package:get/get.dart';

import '../constant/memo_data.dart';

class MemoController extends GetxController {
  var memos = <String>[].obs;
  var editingIndex = Rxn<int>();
  var isEditing = false.obs;

  final textController = ''.obs;
  final editController = ''.obs;

  // 생성자에서 더미 데이터를 로드
  MemoController() {
    loadDummyData();
  }

  // 더미 데이터를 memos 리스트에 추가하는 함수
  void loadDummyData() {
    memos.addAll(memoData);
  }

  void addMemo() {
    if (textController.value.isNotEmpty) {
      memos.add(textController.value);
      textController.value = '';
      isEditing.value = false;
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
    isEditing.value = false;
  }

  void startAdding() {
    isEditing.value = true;
    editingIndex.value = null;
  }

  void cancelEditing() {
    editingIndex.value = null;
    editController.value = '';
  }
}
