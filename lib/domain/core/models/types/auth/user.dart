import 'package:equatable/equatable.dart';
import 'package:pusherman/domain/core/error/exceptions.dart';
import 'package:pusherman/domain/core/models/value_objects/exception_message.dart';
import 'package:pusherman/domain/core/models/value_objects/non_empty_string.dart';

abstract class User extends Equatable {
  const User(this._id, this._userName);

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
}

class Caregiver extends User {
  const Caregiver(UserId id, UserName userName) : super(id, userName);
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
