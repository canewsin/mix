import 'package:flutter/foundation.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:mix/mix.dart';
import 'package:mix_annotations/mix_annotations.dart';

import '../../core/theme/remix_theme.dart';

part 'chip.g.dart';
part 'chip_style.dart';
part 'chip_widget.dart';

@MixableSpec()
class ChipSpec extends Spec<ChipSpec> with _$ChipSpec, Diagnosticable {
  final FlexBoxSpec container;
  final IconSpec icon;
  final TextSpec label;

  /// {@macro chip_spec_of}
  static const of = _$ChipSpec.of;

  static const from = _$ChipSpec.from;

  const ChipSpec({
    FlexBoxSpec? container,
    IconSpec? icon,
    TextSpec? label,
    super.modifiers,
    super.animated,
  })  : container = container ?? const FlexBoxSpec(),
        icon = icon ?? const IconSpec(),
        label = label ?? const TextSpec();

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    _debugFillProperties(properties);
  }
}
