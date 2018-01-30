import 'package:flutter/rendering.dart';
import 'package:flutter/gestures.dart';

void main() {
  RenderConstrainedBox box = new RenderConstrainedBox(
      additionalConstraints: const BoxConstraints.tightFor(width: 100.0, height: 100.0)
  );
  RenderClipRRect renderClipRRect = new RenderClipRRect(
    child: box,
    borderRadius: const BorderRadius.all(const Radius.circular(25.0)),
  );


  RenderConstrainedBox box2 = new RenderConstrainedBox(
      additionalConstraints: const BoxConstraints.tightFor(width: 100.0, height: 100.0)
  );
  RenderClipPath renderClipPath = new RenderClipPath(
    child: box2,
    clipper: new ShapeBorderClipper(
      shapeBorder: new RoundedRectangleBorder(
        borderRadius: const BorderRadius.all(const Radius.circular(25.0)),
      )
    ),
  );

  benchMarkWithRenderer(renderClipRRect, 'ClipRRect');
  benchMarkWithRenderer(renderClipPath, 'ClipPath');

}

void benchMarkWithRenderer(RenderBox renderBox, String desc) {
  renderBox.layout(const BoxConstraints.tightFor(width: 100.0, height: 100.0));
  HitTestResult hitTestResult = new HitTestResult();
  final Stopwatch watch = new Stopwatch();
  watch.start();
  int numIterations = 0;
  for (double i = 0.0; i <= 100.0; i = i + 0.25) {
    renderBox.hitTest(hitTestResult, position: new Offset(i, i));
    numIterations = numIterations +1;
  }
  watch.stop();
  print ('$desc: avg hit test time ${watch.elapsedMicroseconds / numIterations} microseconds');
}
