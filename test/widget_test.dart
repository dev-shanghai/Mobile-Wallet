// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mobile_wallet/constants/app_colors.dart';
import 'package:mobile_wallet/widgets/button_widget.dart';

import 'test_material_app_widget.dart';

void main() {
  Widget _wrapWithMaterialApp(ButtonWidget buttonWidget) {
    return TestMaterialAppWidget(
      home: buttonWidget,
    );
  }

  testWidgets("ButtonWidget display test.", (WidgetTester tester) async {
    //  given
    final widget = ButtonWidget(
      buttonTitle: "LOGIN",
      backgroundColor: AppColors.darkBlack,
      textColor: AppColors.textWhite,
      onPressButtonCallback: () {},
    );

    //  when
    await tester.pumpWidget(_wrapWithMaterialApp(widget));

    //  then
    expect(find.byType(ButtonWidget), findsOneWidget);
    expect(find.text('LOGIN'), findsOneWidget);
  });

  testWidgets("ButtonWidget interaction test.", (WidgetTester tester) async {
    //  given
    var pressed = false;
    final widget = ButtonWidget(
      buttonTitle: "LOGIN",
      backgroundColor: AppColors.darkBlack,
      textColor: AppColors.textWhite,
      onPressButtonCallback: () {
        pressed = true;
      },
    );

    //  when
    await tester.pumpWidget(_wrapWithMaterialApp(widget));
    await tester.tap((find.byType(ButtonWidget)));

    //  then
    expect(pressed, true);
  });

  testWidgets("ButtonWidget display test.", (WidgetTester tester) async {
    //  given
    final widget = ButtonWidget(
      buttonTitle: "LOGIN",
      backgroundColor: AppColors.darkBlack,
      textColor: AppColors.textWhite,
      onPressButtonCallback: () {},
    );
    //  when
    await tester.pumpWidget(_wrapWithMaterialApp(widget));
    final buttonWidget = tester.widget<ButtonWidget>(find.byType(ButtonWidget));

    //  then
    expect(buttonWidget.textColor, AppColors.textWhite);
    expect(buttonWidget.backgroundColor, AppColors.darkBlack);
  });

  testWidgets('ButtonWidget title test.', (WidgetTester tester) async {
    //  given
    final widget = ButtonWidget(
      buttonTitle: "LOGIN",
      backgroundColor: AppColors.darkBlack,
      textColor: AppColors.textWhite,
      onPressButtonCallback: () {},
    );
    //  when
    await tester.pumpWidget(_wrapWithMaterialApp(widget));
    final buttonWidget = tester.widget<ButtonWidget>(find.byType(ButtonWidget));

    //  then
    expect(buttonWidget.buttonTitle, "LOGIN");
  });
}
