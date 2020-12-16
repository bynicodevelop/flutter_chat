class UserModel {
  static final UID = 'uid';

  final String uid;

  const UserModel({
    this.uid,
  });

  Map<String, dynamic> toJson() => _$UserModelToJson(this);
}

Map<String, dynamic> _$UserModelToJson(UserModel instance) => <String, dynamic>{
      UserModel.UID: instance.uid,
    };
