import 'package:flutter/material.dart';
import 'package:multi_value_listenable_builder/multi_value_listenable_builder.dart';

void main() {
  runApp(
    MaterialApp(
      title: 'Multi-ValueListenableBuilder Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Demo(),
    ),
  );
}

class Demo extends StatefulWidget {
  Demo({Key? key}) : super(key: key);

  @override
  _DemoState createState() => _DemoState();
}

class _DemoState extends State<Demo> {
  List<String> _labels = ['Alpha', 'Red', 'Green', 'Blue'];
  List<ValueNotifier<int>> _argb = [
    ValueNotifier(255), // Alpha
    ValueNotifier(255), // Red
    ValueNotifier(255), // Green
    ValueNotifier(255), // Blue
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Multi-ValueListenableBuilder Demo'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 50.0),
              child: MultiValueListenableBuider(
                valueListenables: _argb,
                builder: (context, values, child) {
                  return Container(
                    decoration: ShapeDecoration(
                      shadows: [BoxShadow(blurRadius: 5)],
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      color: Color.fromARGB(
                        values.elementAt(0), // Alpha
                        values.elementAt(1), // Red
                        values.elementAt(2), // Green
                        values.elementAt(3), // Blue
                      ),
                    ),
                    height: 200,
                    width: 200,
                  );
                },
              ),
            ),
            Column(
              children: [0, 1, 2, 3]
                  .map(
                    (index) => Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(
                          _labels.elementAt(index),
                          style: TextStyle(fontSize: 20.0),
                        ),
                        ValueListenableBuilder<int>(
                          valueListenable: _argb.elementAt(index),
                          builder:
                              (BuildContext context, int value, Widget? child) {
                            return Slider(
                              value: value.toDouble(),
                              max: 255,
                              min: 0,
                              onChanged: (newValue) {
                                _argb[index].value = newValue.toInt();
                              },
                            );
                          },
                        )
                      ],
                    ),
                  )
                  .toList(),
            ),
          ],
        ),
      ),
    );
  }
}
