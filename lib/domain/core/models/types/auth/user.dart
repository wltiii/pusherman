import 'package:equatable/equatable.dart';
import 'package:pusherman/domain/core/models/model.dart';
import 'package:pusherman/domain/core/models/types/type_defs.dart';
import 'package:unrepresentable_state/unrepresentable_state.dart';

abstract class User extends Equatable {
  const User(
    this._id,
    this._name,
  );

  // TODO: should not handcoded...
  static User fromJson(Json json) {
    final type = json['runtimeType'] is String ? json['runtimeType'] as String : '';

    switch (type) {
      case 'Dependent':
        return Dependent(
          DependentId(json['id'] as String),
          DependentName(json['userName'] as String),
        );
      case 'CareGiver':
        return CareGiver(
          CareGiverId(json['id'] as String),
          CareGiverName(json['userName'] as String),
        );
      case 'CareProvider':
        return CareProvider(
          CareProviderId(json['id'] as String),
          CareProviderName(json['userName'] as String),
        );
    }
    throw ValueException(ExceptionMessage('Unrecognized value $type.'));
  }

  Json toJson() {
    return {'runtimeType': this.runtimeType.toString(), 'id': id, 'userName': name};
  }

  final Id _id;
  final Name _name;

  String get id => _id.value;

  String get name => _name.value;

  @override
  List<Object?> get props => [_id, _name];

  @override
  bool get stringify => true;
}

class DependentId extends Id {
  DependentId(String value) : super(value);
}

class CareGiverId extends Id {
  CareGiverId(String value) : super(value);
}

class CareProviderId extends Id {
  CareProviderId(String value) : super(value);
}

class Dependent extends User {
  const Dependent(DependentId id, DependentName userName) : super(id, userName);

  factory Dependent.fromJson(Json json) {
    return User.fromJson(json) as Dependent;
  }
}

class CareGiver extends User implements Model {
  const CareGiver(CareGiverId id, CareGiverName userName) : super(id, userName);

  factory CareGiver.fromJson(Json json) {
    return User.fromJson(json) as CareGiver;
  }
}

class CareProvider extends User {
  const CareProvider(CareProviderId id, CareProviderName userName) : super(id, userName);

  factory CareProvider.fromJson(Json json) {
    return User.fromJson(json) as CareProvider;
  }
}

/// [DependentName] is a user friendly name associated with the given user.
///
/// It is a [NonEmptyString], thus  must not be empty. Instantiating with an
/// empty String will throw a [ValueException].
///
// TODO(wltiii): this should extend Person, which would have First, Middle, Last, Suffix, possibly nickname. FullName convenience method should return 'William Lodge Turner III', and reversed as `Turner, William Lodge, Jr`
class DependentName extends Name {
  DependentName(String value)
      : super(
          value,
          // validators: [
          //   (String value) => {
          //         if (value.trimRight().isEmpty)
          //           throw ValueException(
          //             ExceptionMessage('User name must not be empty.'),
          //           ),
          //       },
          // ],
        );
}

/// [CareGiverName] is a user friendly name associated with the given user.
///
/// It is a [NonEmptyString], thus  must not be empty. Instantiating with an
/// empty String will throw a [ValueException].
///
// TODO(wltiii): this should extend Person, which would have First, Middle, Last, Suffix, possibly nickname. FullName convenience method should return 'William Lodge Turner III', and reversed as `Turner, William Lodge, Jr`
class CareGiverName extends Name {
  CareGiverName(String value)
      : super(
          value,
          // validators: [
          //   (String value) => {
          //         if (value.trimRight().isEmpty)
          //           throw ValueException(
          //             ExceptionMessage('User name must not be empty.'),
          //           ),
          //       },
          // ],
        );
}

/// [CareProviderName] is a user friendly name associated with the given user.
///
/// It is a [NonEmptyString], thus  must not be empty. Instantiating with an
/// empty String will throw a [ValueException].
///
// TODO(wltiii): this should extend Person, which would have First, Middle, Last, Suffix, possibly nickname. FullName convenience method should return 'William Lodge Turner III', and reversed as `Turner, William Lodge, Jr`
class CareProviderName extends Name {
  CareProviderName(String value)
      : super(
          value,
          // validators: [
          //   (String value) => {
          //         if (value.trimRight().isEmpty)
          //           throw ValueException(
          //             ExceptionMessage('User name must not be empty.'),
          //           ),
          //       },
          // ],
        );
}
