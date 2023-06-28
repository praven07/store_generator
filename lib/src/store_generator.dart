import 'dart:async';

import 'package:analyzer/dart/element/element.dart';
import 'package:build/build.dart';
import 'package:source_gen/source_gen.dart';
import 'package:store/store.dart';

class StoreGenerator extends GeneratorForAnnotation<StoreAnnotation> {
  @override
  FutureOr<String> generateForAnnotatedElement(
      Element element, ConstantReader annotation, BuildStep buildStep) {
    return _generateActionSource(element);
  }

  String _generateActionSource(Element element) {
    return "class HelloWorld {}";
  }
}