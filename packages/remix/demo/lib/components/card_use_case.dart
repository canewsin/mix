import 'package:demo/helpers/knob_builder.dart';
import 'package:flutter/widgets.dart';
import 'package:mix/mix.dart';
import 'package:remix/remix.dart';
import 'package:remix/themes/fortaleza.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

@widgetbook.UseCase(
  name: 'Card Component',
  type: Card,
)
Widget buildCard(BuildContext context) {
  return Scaffold(
    body: Center(
      child: Card(
        variants: [
          context.knobs.variant(FortalezaCardStyle.variants),
        ],
        child: StyledRow(
          style: Style(
            $flex.gap(12),
            $flex.mainAxisSize.min(),
          ),
          children: [
            Avatar(
              fallbackBuilder: (spec) => spec('LF'),
              variants: FortalezaCardStyle.variants,
            ),
            Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                StyledText(
                  'Leo Farias',
                  style: Style(
                    $text.chain
                      ..style.fontSize(14)
                      ..style.fontWeight.bold()
                      ..style.color.black87(),
                    $on.dark(
                      $text.style.color.white(),
                    ),
                  ),
                ),
                StyledText(
                  'Flutter Engineer',
                  style: Style(
                    $text.chain
                      ..style.fontSize(12)
                      ..style.color.black54(),
                    $on.dark(
                      $text.style.color.white70(),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    ),
  );
}
