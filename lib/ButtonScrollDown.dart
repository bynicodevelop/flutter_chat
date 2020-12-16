import 'package:flutter/material.dart';

class ButtonScrollDown extends StatelessWidget {
  final Function scrollToBottom;
  final bool showScollButton;

  const ButtonScrollDown({
    Key key,
    @required this.scrollToBottom,
    @required this.showScollButton,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 60.0),
      child: SizedBox(
        height: 35.0,
        width: 35.0,
        child: showScollButton
            ? FloatingActionButton(
                backgroundColor: Theme.of(context).primaryColor.withOpacity(.7),
                child: Icon(
                  Icons.keyboard_arrow_down,
                ),
                onPressed: scrollToBottom,
              )
            : null,
      ),
    );
  }
}
