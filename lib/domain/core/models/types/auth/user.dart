import 'dart:convert';
import 'package:equatable/equatable.dart';
import 'package:pusherman/domain/core/error/exceptions.dart';
import 'package:pusherman/domain/core/models/value_objects/exception_message.dart';
import 'package:pusherman/domain/core/models/value_objects/non_empty_string.dart';
import 'package:pusherman/domain/core/models/types/type_defs.dart';

// part 'user.g.dart';
//
// @JsonSerializable(explicitToJson: true)
abstract class User extends Equatable {
  const User(this._id, this._userName);

  // User fromJson(String source) {
  //   final map = json.decode(source) as Map<String, Object?>;
  //
  //   return User(
  //     minimumPrice: map['id'] as String,
  //     maximumPrice: map['userName'] as String,
  //   );
  // }

  Json toJson() {
    // TODO(wltiii) return type should be Json
    return <String, Object?> {
      'id': id,
      'userName': name
    };
  }


  // /// Connect the generated [_$PersonFromJson] function to the `fromJson`
  // /// factory.
  // factory User.fromJson(Json json) => _$UserFromJson(json);
  //
  // /// Connect the generated [_$PersonToJson] function to the `toJson` method.
  // Json toJson() => _$UserToJson(this);

  final UserId _id;
  final UserName _userName;

  String get id => _id.value;

  String get name => _userName.value;

  @override
  List<Object?> get props => [_id, _userName];

  @override
  bool get stringify => true;
}

class Dependent extends User {
  const Dependent(UserId id, UserName userName) : super(id, userName);

  // factory Dependent.fromJson(id, userName) {
  //   return super.fromJson(id, userName);
  // }
  factory Dependent.fromJson(String source) {
    final map = json.decode(source) as Map<String, Object?>;

    return Dependent(
      UserId(map['id'] as String),
      UserName(map['userName'] as String),
    );
  }


  Json toJson() {
    return super.toJson();
  }
}

class CareGiver extends User {
  const CareGiver(UserId id, UserName userName) : super(id, userName);
}

class CareProvider extends User {
  const CareProvider(UserId id, UserName userName) : super(id, userName);
}

/// [UserId] is a unique identifier of a user.
///
/// It is a [NonEmptyString], thus  must not be empty. Instantiating with an
/// empty String will throw a [ValueException].
///
// TODO(wltiii): allow empty and generate a unique id???
// TODO(wltiii): or use StoreMetaData???
class UserId extends NonEmptyString {
  UserId(String value)
      : super(
          value,
          validators: [
            (String value) => {
                  if (value.trimRight().isEmpty)
                    throw ValueException(
                      ExceptionMessage('User id must not be empty.'),
                    ),
                },
          ],
        );
}

/// [UserName] is a user friendly name associated with the given user.
///
/// It is a [NonEmptyString], thus  must not be empty. Instantiating with an
/// empty String will throw a [ValueException].
///
class UserName extends NonEmptyString {
  UserName(String value)
      : super(
          value,
          validators: [
            (String value) => {
                  if (value.trimRight().isEmpty)
                    throw ValueException(
                      ExceptionMessage('User name must not be empty.'),
                    ),
                },
          ],
        );
}