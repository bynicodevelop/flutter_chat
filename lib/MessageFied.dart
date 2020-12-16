import 'package:flutter/material.dart';
import 'package:flutter_chat_components/models/Message.dart';

class MessageField extends StatefulWidget {
  final Function(MessageModel) onSend;
  final String currentUserUid;

  const MessageField({
    Key key,
    @required this.onSend,
    @required this.currentUserUid,
  }) : super(key: key);

  @override
  _MessageFieldState createState() => _MessageFieldState();
}

class _MessageFieldState extends State<MessageField> {
  final TextEditingController _controller = TextEditingController();

  bool _disabled = true;

  @override
  void initState() {
    super.initState();

    _controller.addListener(() {
      if (_controller.text.length > 0) {
        setState(() => _disabled = false);
      } else {
        setState(() => _disabled = true);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Transform.translate(
      offset: Offset(
        0.0,
        -1 * MediaQuery.of(context).viewInsets.bottom,
      ),
      child: BottomAppBar(
        child: Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 10.0,
          ),
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  keyboardType: TextInputType.multiline,
                  maxLines: null,
                  controller: _controller,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    filled: true,
                    fillColor: Colors.white,
                    hintText: 'Entrez votre  message',
                  ),
                ),
              ),
              IconButton(
                icon: Icon(
                  Icons.send,
                ),
                onPressed: _disabled
                    ? null
                    : () async {
                        await widget.onSend(
                          MessageModel(
                            userUid: widget.currentUserUid,
                            text: _controller.text,
                          ),
                        );

                        _controller.clear();
                      },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
