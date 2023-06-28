library store_generator;

import 'package:build/build.dart';
import 'package:source_gen/source_gen.dart';
import 'package:store_generator/src/store_generator.dart';

Builder store(BuilderOptions options) =>
    SharedPartBuilder([StoreGenerator()], 'store');
