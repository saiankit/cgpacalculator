// ignore_for_file: directives_ordering

import 'package:build_runner_core/build_runner_core.dart' as _i1;
import 'package:moor_generator/integrations/build.dart' as _i2;
import 'package:source_gen/builder.dart' as _i3;
import 'package:build_config/build_config.dart' as _i4;
import 'dart:isolate' as _i5;
import 'package:build_runner/build_runner.dart' as _i6;
import 'dart:io' as _i7;

final _builders = <_i1.BuilderApplication>[
  _i1.apply('moor_generator:preparing_builder', [_i2.preparingBuilder],
      _i1.toDependentsOf('moor_generator'),
      hideOutput: true, appliesBuilders: ['moor_generator:moor_cleanup']),
  _i1.apply('moor_generator:moor_generator', [_i2.moorBuilder],
      _i1.toDependentsOf('moor_generator'),
      hideOutput: true, appliesBuilders: ['source_gen:combining_builder']),
  _i1.apply('moor_generator:moor_generator_not_shared',
      [_i2.moorBuilderNotShared], _i1.toNoneByDefault(),
      hideOutput: false),
  _i1.apply('source_gen:combining_builder', [_i3.combiningBuilder],
      _i1.toNoneByDefault(),
      hideOutput: false, appliesBuilders: ['source_gen:part_cleanup']),
  _i1.applyPostProcess('source_gen:part_cleanup', _i3.partCleanup,
      defaultGenerateFor: const _i4.InputSet()),
  _i1.applyPostProcess('moor_generator:moor_cleanup', _i2.moorCleanup,
      defaultGenerateFor: const _i4.InputSet())
];
void main(List<String> args, [_i5.SendPort sendPort]) async {
  var result = await _i6.run(args, _builders);
  sendPort?.send(result);
  _i7.exitCode = result;
}
