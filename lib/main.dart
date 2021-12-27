import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Drag and Drop'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _indexOfDroppedItem = 0;
  bool _isDragging = false;

  void _acceptDraggedItem(int index) {
    setState(() {
      _indexOfDroppedItem = index;
    });
  }

  void _setIsDragging() {
    setState(() {
      _isDragging = true;
    });
  }

  void _resetIsDragging() {
    setState(() {
      _isDragging = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: GridView.count(
          shrinkWrap: true,
          primary: false,
          crossAxisCount: 2,
          children: List.generate(6, (index) {
            return Padding(
              padding: const EdgeInsets.all(44.0),
              child: index == _indexOfDroppedItem
                  ? Draggable<int>(
                      data: index,
                      child: Container(
                        decoration: BoxDecoration(
                            color: Colors.blue,
                            border: Border.all(
                              color: Colors.blue,
                            ),
                            borderRadius:
                                const BorderRadius.all(Radius.circular(10))),
                      ),
                      childWhenDragging: Container(
                        decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.blue,
                            ),
                            borderRadius:
                                const BorderRadius.all(Radius.circular(20))),
                      ),
                      onDragStarted: () {
                        _setIsDragging();
                      },
                      onDraggableCanceled: (_, __) {
                        _resetIsDragging();
                      },
                      onDragCompleted: () {
                        _resetIsDragging();
                      },
                      feedback: Container(
                        width: 100,
                        height: 100,
                        decoration: const BoxDecoration(
                            color: Colors.blue,
                            borderRadius:
                                BorderRadius.all(Radius.circular(20))),
                      ),
                    )
                  : DragTarget<int>(
                      builder: (
                        BuildContext context,
                        List<dynamic> accepted,
                        List<dynamic> rejected,
                      ) {
                        return Container(
                            decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.blue,
                          ),
                          borderRadius: BorderRadius.all(_isDragging
                              ? const Radius.circular(20)
                              : const Radius.circular(10)),
                        ));
                      },
                      onAccept: (int data) {
                        _acceptDraggedItem(index);
                      },
                    ),
            );
          }),
        ),
      ),
    );
  }
}
