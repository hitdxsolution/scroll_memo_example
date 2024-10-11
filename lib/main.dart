import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Memo List',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MemoListPage(),
    );
  }
}

class MemoListPage extends StatefulWidget {
  @override
  _MemoListPageState createState() => _MemoListPageState();
}

class _MemoListPageState extends State<MemoListPage> {
  final List<String> _memos = List.generate(20, (index) => '메모 ${index + 1}');
  final TextEditingController _textController = TextEditingController();
  bool _isEditing = false; // 텍스트 필드가 편집 모드인지 여부

  void _addMemo() {
    if (_textController.text.isNotEmpty) {
      setState(() {
        _memos.add(_textController.text);
        _textController.clear();
        _isEditing = false; // 메모 추가 후 입력 상태 종료
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('메모 리스트'),
      ),
      body: ListView.builder(
        padding: EdgeInsets.all(10),
        itemCount: _memos.length + 1, // 마지막에 입력 필드를 추가하기 위해 +1
        itemBuilder: (context, index) {
          if (index < _memos.length) {
            // 메모 리스트 항목들
            return Card(
              margin: EdgeInsets.symmetric(vertical: 5),
              elevation: 3,
              child: ListTile(
                title: Text(_memos[index]),
              ),
            );
          } else {
            // 마지막 항목에 입력 필드를 추가
            return Padding(
              padding: const EdgeInsets.all(12.0),
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    _isEditing = true; // 터치 시 편집 모드로 전환
                  });
                },
                child: AnimatedContainer(
                  duration: Duration(milliseconds: 300),
                  padding: const EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.0),
                    border: Border.all(
                      color: Colors.grey,
                    ),
                  ),
                  // AnimatedContainer에서 height를 최소한으로 설정하여 TextField의 크기를 늘림
                  child: _isEditing
                      ? TextField(
                    controller: _textController,
                    autofocus: true,
                    maxLines: null, // 최대 라인 제한 없음
                    minLines: 5, // 최소 3줄
                    keyboardType: TextInputType.multiline, // 멀티라인 입력 허용
                    decoration: InputDecoration(
                      hintText: '메모를 입력하세요',
                      border: InputBorder.none,
                    ),
                  )
                      : Row(
                    children: [
                      Icon(Icons.person, color: Colors.blue),
                      SizedBox(width: 10),
                      Text('댓글 추가...'),
                    ],
                  ),
                ),
              ),
            );

          }
        },
      ),
      floatingActionButton: _isEditing
          ? FloatingActionButton(
        onPressed: _addMemo,
        child: Icon(Icons.add),
        mini: true,
      )
          : null,
    );
  }
}
