import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/dart/element/visitor.dart';

class ClassVisitor extends SimpleElementVisitor<void> {
  String className = '';
  List<ActionMethod> methods = [];

  @override
  void visitConstructorElement(ConstructorElement element) {
    className = element.returnType.toString();
  }

  @override
  void visitMethodElement(MethodElement element) {
    // Get the list of annotations for the method.
    List<ElementAnnotation> annotations = element.metadata;

    // Check to see if it has '@Action' annotation and adds it to the list.
    for (var annotation in annotations) {

      if (annotation.element?.enclosingElement?.name == 'Action') {

        methods.add(ActionMethod(
          annotationParameterType: annotation.computeConstantValue()?.getField("type")?.toTypeValue()?.name,
          name: element.name,
          returnType: element.returnType.getDisplayString(withNullability: true),
        ));
      }
    }
  }
}

/// It is a data class for method that has 'Action' annotation.
class ActionMethod {

  /// Parameter type provided inside the Action annotation.
  final String? annotationParameterType;

  /// Name of the method.
  final String name;

  /// Return type of the method.
  final String returnType;

  ActionMethod({
    required this.annotationParameterType,
    required this.name,
    required this.returnType,
  });
}
