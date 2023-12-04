import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mix/src/attributes/strut_style/strut_style_dto.dart';
import 'package:mix/src/attributes/strut_style/strut_style_util.dart';

import '../../../helpers/attribute_generator.dart';
import '../../../helpers/testing_utils.dart';

void main() {
  group('StrutStyleUtility', () {
    const strutStyleUtility = StrutStyleUtility(UtilityTestAttribute.new);
    test('callable', () {
      final strutStyle = strutStyleUtility(
        fontFamily: 'Roboto',
        fontSize: 24.0,
        height: 2.0,
        leading: 1.0,
        fontWeight: FontWeight.bold,
        fontStyle: FontStyle.italic,
        forceStrutHeight: true,
      );

      expect(strutStyleUtility.call, isA<Function>());
      expect(strutStyle.value, isA<StrutStyleDto>());
      expect(strutStyle.value.fontFamily, 'Roboto');
      expect(strutStyle.value.fontSize, 24.0);
      expect(strutStyle.value.height, 2.0);
      expect(strutStyle.value.leading, 1.0);
      expect(strutStyle.value.fontWeight, FontWeight.bold);
      expect(strutStyle.value.fontStyle, FontStyle.italic);
      expect(strutStyle.value.forceStrutHeight, true);
    });

    test('fontFamily', () {
      final strutStyle = strutStyleUtility.fontFamily('Roboto');

      expect(strutStyle.value.fontFamily, 'Roboto');
    });

    test('fontSize', () {
      final strutStyle = strutStyleUtility.fontSize(24.0);

      expect(strutStyle.value.fontSize, 24.0);
    });

    test('height', () {
      final strutStyle = strutStyleUtility.height(2.0);

      expect(strutStyle.value.height, 2.0);
    });

    test('leading', () {
      final strutStyle = strutStyleUtility.leading(1.0);

      expect(strutStyle.value.leading, 1.0);
    });

    test('fontWeight', () {
      final strutStyle = strutStyleUtility.fontWeight(FontWeight.bold);

      expect(strutStyle.value.fontWeight, FontWeight.bold);
    });

    test('fontStyle', () {
      final strutStyle = strutStyleUtility.fontStyle(FontStyle.italic);

      expect(strutStyle.value.fontStyle, FontStyle.italic);
    });

    test('forceStrutHeight', () {
      final strutStyle = strutStyleUtility.forceStrutHeight(true);

      expect(strutStyle.value.forceStrutHeight, true);
    });

    test('as', () {
      final strutStyle = RandomGenerator.strutStyle();
      final attribute = strutStyleUtility.as(strutStyle);

      expect(attribute.value, isA<StrutStyleDto>());
      expect(attribute.value, equals(StrutStyleDto.from(strutStyle)));
      expect(attribute.value.resolve(EmptyMixData), equals(strutStyle));
    });
  });
}
