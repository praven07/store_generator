import 'dart:async';
import 'package:analyzer/dart/element/element.dart';
import 'package:build/build.dart';
import 'package:source_gen/source_gen.dart';
import 'package:store/store.dart';
import 'package:store_generator/src/class_visitor.dart';

class StoreGenerator extends GeneratorForAnnotation<StoreAnnotation> {
  @override
  FutureOr<String> generateForAnnotatedElement(
      Element element, ConstantReader annotation, BuildStep buildStep) {
    return _generateActionSource(element);
  }

  String _generateActionSource(Element element) {

    ClassVisitor classVisitor = ClassVisitor();
    element.visitChildren(classVisitor);

    StringBuffer buffer = StringBuffer();

    // Write the class
    buffer.writeln('abstract class \$${classVisitor.className}<A, S> extends Store<A, S> {');

    // Write the actions map
    buffer.writeln("@override");
    buffer.writeln("Map<Type, Function> get actionHandlers => {");

    for (var method in classVisitor.methods) {
      buffer.writeln("${method.annotationParameterType}: ${method.name},");
    }

    buffer.writeln("};");


    // Write method calls.
    for (var method in classVisitor.methods) {
      buffer.writeln("${method.name}(${method.annotationParameterType} action);");
    }


    buffer.writeln('}');

    return buffer.toString();
  }
}