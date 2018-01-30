import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/rendering.dart';

void main() {
  runApp(new MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      showPerformanceOverlay: true,
      title: 'Shape benchmark',
      theme: new ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: new Scaffold(body: new MyWidget()),
    );
  }
}

class MyWidget extends StatefulWidget {

  @override
  State createState() => new MyWidgetState();
}

class MyWidgetState extends State<MyWidget> with TickerProviderStateMixin {

  bool big = true;
  bool shouldClipWithPath = true;

  @override
  Widget build(BuildContext context) {
    Widget contentToClip = new Container(
      color: Colors.orange,
      child: new AnimatedSize(
        child: new SizedBox(width: big ?
          200.0 : 100.0, height: big ?
          200.0: 100.0),
        duration: const
        Duration(milliseconds:
          600),
        vsync:
        this,
      ),
    );
    return new GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () { setState(() { big = !big; }); },
      onHorizontalDragEnd : (d) { setState(() { shouldClipWithPath = !shouldClipWithPath; }); },
      child: new Center(
        child: new Column(
          children: <Widget> [
            shouldClipWithPath ? clipWithPath(contentToClip) : clipWithRRect(contentToClip),
            new Text(shouldClipWithPath ? 'Clipping with Path' : 'Clipping with RRect'),
          ],
        ),
      ),
    );
  }

  Widget clipWithRRect(Widget child) {
    return new ClipRRect(
          borderRadius: new BorderRadius.all(const Radius.circular(10.0)),
          child: child
    );
  }

  Widget clipWithPath(Widget child) {
    return new ClipPath( 
      clipper: new ShapeBorderClipper(
        shapeBorder: new RoundedRectangleBorder(
          borderRadius: const
          BorderRadius.all(const
            Radius.circular(10.0)),
        ),
      ),
      child: child,
    );
  }
}

