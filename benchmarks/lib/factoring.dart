import 'package:benchmarks/common.dart';
import 'package:flutter/material.dart';
import 'package:mix/mix.dart';

/// flutter run -t lib/factoring.dart --release
void main() {
  assert(
    false,
    "Don't run benchmarks in debug mode! Use 'flutter run --release'.",
  );

  final printer = BenchmarkResultPrinter();
  final watch = Stopwatch();

  {
    final firstMix = StyleMix(
      height(100),
      animated(),
      marginY(10),
      rounded(10),
      bgColor(Color(0xFF00FF80)),
      textStyle(as: TextStyle()),
      textColor(Color(0xFFFFFFFF)),
      onHover(
        padding(20),
        bgColor(Color(0xFFFFFF80)),
        textColor(Color(0xFF000000)),
      ),
    );

    final secondMix = StyleMix(
      width(100),
      marginX(10),
      shadow(spreadRadius: 100),
      rounded(100),
      bgColor(Color(0xFF00FF80)),
      borderColor(Color(0xFF984F9B)),
      onPress(
        shadow(spreadRadius: 2),
        margin(20),
        bgColor(Color(0xFFFFFF80)),
        textColor(Color(0xFF000000)),
      ),
    );

    watch.start();

    StyleMix.combine([firstMix, secondMix]);

    watch.stop();

    printer.addResult(
      description: 'Combine two extense mixes',
      value: watch.elapsedMicroseconds.toDouble(),
      unit: 'microseconds',
      name: 'combine_mix_bench',
    );
  }

  watch.reset();

  {
    watch.start();

    StyleMix.combine([
      StyleMix(bgColor(Colors.black)),
      StyleMix(textColor(Colors.black)),
      StyleMix(margin(20)),
      StyleMix(rounded(10)),
      StyleMix(borderColor(Colors.black)),
    ]);

    watch.stop();

    printer.addResult(
      description: 'Combine multiple mixes',
      value: watch.elapsedMicroseconds.toDouble(),
      unit: 'microseconds',
      name: 'combine_multiple_mixes_bench',
    );
  }

  watch.reset();

  {
    final hasError = StyleVariant('hasError');
    final mix = StyleMix(
      hasError(
        padding(20),
        bgColor(Color(0xFFFFFF80)),
        textColor(Color(0xFF000000)),
      ),
    );

    watch.start();

    mix.selectVariant(hasError);

    watch.stop();

    printer.addResult(
      description: 'Apply a variant to a mix',
      value: watch.elapsedMicroseconds.toDouble(),
      unit: 'microseconds',
      name: 'apply_variant_bench',
    );
  }

  watch.reset();

  {
    final mix = StyleMix(
      onDisabled(padding(20)),
      onFocus(bgColor(Color(0xFFFFFF80))),
      onHover(textColor(Color(0xFF000000))),
      onPress(textBgColor(Color(0xFF964234))),
      onDark(textHeight(10)),
      onLight(textShadow(color: Color(0xFF000000))),
    );

    watch.start();

    mix.withManyVariants([
      onDisabled,
      onFocus,
      onHover,
      onPress,
      onDark,
      onLight,
    ]);

    watch.stop();

    printer.addResult(
      description: 'Apply multiple variants to a mix',
      value: watch.elapsedMicroseconds.toDouble(),
      unit: 'microseconds',
      name: 'apply_multiple_variants_bench',
    );
  }
  printer.printToStdout();
}
