import 'package:faker/faker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_components/flutter_chat_components.dart';
import 'package:flutter_chat_components/MessageFied.dart';
import 'package:flutter_models/models/MessageModel.dart';
import 'package:flutter_chat_components/ButtonScrollDown.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final ScrollController _scrollController = ScrollController();
  final Faker _faker = Faker();
  final List<MessageModel> _messages = List<MessageModel>();
  final List<String> _usersId = List<String>();

  bool _showScollButton = false;

  void _scrollToBottom() {
    if (_scrollController != null) {
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent + 100.0,
        duration: Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    }
  }

  @override
  void initState() {
    super.initState();

    _usersId.addAll([
      _faker.guid.guid(),
      _faker.guid.guid(),
    ]);

    DateTime date = DateTime.now().add(Duration(seconds: 30));

    _messages.add(
      MessageModel(
        uid: _faker.guid.guid(),
        userUid: _usersId[0],
        text: 'First message',
        sendAt: date.subtract(Duration(minutes: 31)).millisecondsSinceEpoch,
      ),
    );

    for (int i = 0; i < 30; i++) {
      int randInt = _faker.randomGenerator.integer(9);

      _messages.add(
        MessageModel(
          uid: _faker.guid.guid(),
          userUid: randInt % 2 != 0 ? _usersId[0] : _usersId[1],
          text: _faker.lorem.sentences(2).join('\n'),
          sendAt: date
              .subtract(Duration(minutes: 30 - (i + 1)))
              .millisecondsSinceEpoch,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 10.0,
          ),
          child: Chat(
            messages: _messages,
            currentUserUid: _usersId[0],
            scrollController: _scrollController,
            isBottom: (value) => setState(() => _showScollButton = value),
          ),
        ),
        floatingActionButton: ButtonScrollDown(
          scrollToBottom: _scrollToBottom,
          showScollButton: _showScollButton,
        ),
        bottomNavigationBar: MessageField(
          currentUserUid: _usersId[0],
          onSend: (MessageModel value) {
            print(value.toJson());
            setState(() => _messages.add(value));

            // Automatically scroll to the last message sent
            // if the scrollController is define in the Chat widget
            _scrollToBottom();

            setState(() => print('Refreshing view...'));
          },
        ),
      ),
    );
  }
}
