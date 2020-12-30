import 'package:flutter/material.dart';
import 'package:flutter_models/models/MessageModel.dart';
import 'package:flutter_chat_bubble/bubble_type.dart';
import 'package:flutter_chat_bubble/chat_bubble.dart';
import 'package:flutter_chat_bubble/clippers/chat_bubble_clipper_5.dart';
import 'package:time_formatter/time_formatter.dart';

class Chat extends StatefulWidget {
  final Function(bool) isBottom;
  final ScrollController scrollController;
  final List<MessageModel> messages;
  final String currentUserUid;
  final double deltaBottom;

  const Chat({
    Key key,
    @required this.messages,
    @required this.currentUserUid,
    this.isBottom,
    this.scrollController,
    this.deltaBottom = 200.0,
  }) : super(key: key);

  @override
  _ChatState createState() => _ChatState();
}

class _ChatState extends State<Chat> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (widget.scrollController != null) {
        widget.scrollController
            .jumpTo(widget.scrollController.position.maxScrollExtent + 100.0);

        widget.scrollController.addListener(() {
          double maxScroll = widget.scrollController.position.maxScrollExtent;
          double currentScroll = widget.scrollController.position.pixels;

          if (widget.isBottom != null) {
            widget.isBottom(maxScroll - currentScroll >= widget.deltaBottom);
          }
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return widget.messages.length > 0
        ? ListView.builder(
            controller: widget.scrollController,
            itemCount: widget.messages.length,
            itemBuilder: (context, index) {
              bool isCurrentUser =
                  widget.messages[index].userUid == widget.currentUserUid;

              return Padding(
                padding: EdgeInsets.only(
                  top: index == 0 ? 10.0 : 0,
                  bottom: 8.0,
                  left: isCurrentUser ? 50.0 : 2.0,
                  right: !isCurrentUser ? 50.0 : 2.0,
                ),
                child: ChatBubble(
                  backGroundColor: isCurrentUser ? Colors.blue : Colors.white,
                  clipper: ChatBubbleClipper5(
                    type: isCurrentUser
                        ? BubbleType.sendBubble
                        : BubbleType.receiverBubble,
                  ),
                  alignment:
                      isCurrentUser ? Alignment.topRight : Alignment.topLeft,
                  child: Column(
                    children: [
                      Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          widget.messages[index].text,
                          style: TextStyle(
                            color: isCurrentUser ? Colors.white : Colors.black,
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.bottomRight,
                        child: Padding(
                          padding: const EdgeInsets.only(
                            top: 4.0,
                          ),
                          child: Text(
                            formatTime(widget.messages[index].sendAt),
                            style: Theme.of(context).textTheme.caption.copyWith(
                                color: isCurrentUser
                                    ? Colors.white
                                    : Theme.of(context)
                                        .textTheme
                                        .caption
                                        .color),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          )
        : Container(
            child: Center(
              child: Text('No message found...'),
            ),
          );
  }

  @override
  void dispose() {
    widget.scrollController?.dispose();
    super.dispose();
  }
}
