import 'package:flutter/material.dart';
import 'package:flutter_chat_components/MessageFied.dart';
import 'package:flutter_models/models/MessageModel.dart';
import 'package:flutter_test/flutter_test.dart';

main() {
  testWidgets('Should send an message model', (WidgetTester tester) async {
    // ARRANGE
    MessageModel messageModel;

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          bottomNavigationBar: MessageField(
            onSend: (message) => messageModel = message,
            currentUserUid: null,
          ),
        ),
      ),
    );

    // ACT
    final Finder textFieldFinder = find.byType(TextField);
    await tester.enterText(textFieldFinder, 'hello world');

    await tester.pumpAndSettle();

    final Finder sendButtonFinder = find.byIcon(Icons.send);
    await tester.tap(sendButtonFinder);

    await tester.pumpAndSettle();

    // ASSERT
    expect(messageModel.text, 'hello world');

    // ACT
    final Finder textFinder = find.text('hello world');

    // ASSERT
    expect(textFinder, findsNothing);
  });

  testWidgets('Should check that button is disabled',
      (WidgetTester tester) async {
    // ARRANGE
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          bottomNavigationBar: MessageField(
            onSend: (message) => null,
            currentUserUid: null,
          ),
        ),
      ),
    );

    // ACT
    final Finder sendButtonFinder = find.byType(IconButton);
    final IconButton iconButton =
        tester.firstWidget(sendButtonFinder) as IconButton;

    // ASSERT
    expect(iconButton.onPressed, null);
  });
}
