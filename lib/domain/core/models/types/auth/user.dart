import 'dart:convert';
import 'package:equatable/equatable.dart';
import 'package:pusherman/domain/core/error/exceptions.dart';
import 'package:pusherman/domain/core/models/value_objects/exception_message.dart';
import 'package:pusherman/domain/core/models/value_objects/non_empty_string.dart';
import 'package:pusherman/domain/core/models/types/type_defs.dart';

abstract class User extends Equatable {
  const User(this._id, this._name,);

  static User fromJson(String source) {
    final map = json.decode(source) as Map<String, Object?>;

    final type =
        map['runtimeType'] is String ? map['runtimeType'] as String : '';

    switch (type) {
      case 'Dependent':
        return Dependent(
          UserId(map['id'] as String),
          UserName(map['userName'] as String),
        );
      case 'CareGiver':
        return CareGiver(
          UserId(map['id'] as String),
          UserName(map['userName'] as String),
        );
      case 'CareProvider':
        return CareProvider(
          UserId(map['id'] as String),
          UserName(map['userName'] as String),
        );
    }
    //TODO is there a test for this?
    throw ValueException(
        ExceptionMessage('Unrecognized value $type.')
    );
  }

  Json toJson() {
    return {
      'runtimeType': this.runtimeType.toString(),
      'id': id,
      'userName': name
    };
  }

  final UserId _id;
  final UserName _name;

  String get id => _id.value;

  String get name => _name.value;

  @override
  List<Object?> get props => [_id, _name];

  @override
  bool get stringify => true;
}

class Dependent extends User {
  const Dependent(UserId id, UserName userName) : super(id, userName);

  factory Dependent.fromJson(String source) {
    return User.fromJson(source) as Dependent;
  }
}

class CareGiver extends User {
  const CareGiver(UserId id, UserName userName) : super(id, userName);

  factory CareGiver.fromJson(String source) {
    return User.fromJson(source) as CareGiver;
  }
}

class CareProvider extends User {
  const CareProvider(UserId id, UserName userName) : super(id, userName);

  factory CareProvider.fromJson(String source) {
    return User.fromJson(source) as CareProvider;
  }
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
// TODO(wltiii): this should extend Person, which would have First, Middle, Last, Suffix, possibly nickname. FullName convenience method should return 'William Lodge Turner III', and reversed as `Turner, William Lodge, Jr`
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