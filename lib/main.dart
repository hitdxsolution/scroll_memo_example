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
  // 20개의 임의 메모 추가
  final List<String> _memos = List.generate(20, (index) => '메모 ${index + 1}');
  final TextEditingController _textController = TextEditingController();

  void _addMemo() {
    if (_textController.text.isNotEmpty) {
      setState(() {
        _memos.add(_textController.text);
        _textController.clear();
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
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: TextField(
                      controller: _textController,
                      maxLines: null, // 최대 라인 제한 없음
                      minLines: 1, // 최소 1줄
                      decoration: InputDecoration(
                        hintText: '메모를 입력하세요',
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                  SizedBox(width: 10),
                  FloatingActionButton(
                    onPressed: _addMemo,
                    child: Icon(Icons.add),
                    mini: true,
                  ),
                ],
              ),
            );

          }
        },
      ),
    );
  }
}
