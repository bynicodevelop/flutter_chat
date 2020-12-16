class MessageModel {
  static final UID = 'uid';
  static final USER_UID = 'userUid';
  static final TEXT = 'text';
  static final SEND_AT = 'sendAt';

  final String uid;
  final String userUid;
  final String text;
  final String sendAt;

  const MessageModel({
    this.uid,
    this.userUid,
    this.text,
    this.sendAt,
  });

  Map<String, dynamic> toJson() => _$MessageModelToJson(this);
}

Map<String, dynamic> _$MessageModelToJson(MessageModel instance) =>
    <String, dynamic>{
      MessageModel.UID: instance.uid,
      MessageModel.USER_UID: instance.userUid,
      MessageModel.TEXT: instance.text,
      MessageModel.SEND_AT: instance.sendAt,
    };
