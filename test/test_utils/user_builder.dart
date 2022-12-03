import 'package:pusherman/domain/core/models/types/auth/user.dart';

class UserBuilder {
  static const String DEFAULT_ID = "42";
  static const String DEFAULT_NAME = "John Smith";

  String id = DEFAULT_ID;
  String name = DEFAULT_NAME;

  UserBuilder._() {}

  UserBuilder.aUser();

  // static UserBuilder aUser() {
  //   return new UserBuilder();
  // }

  static UserBuilder aDefaultUser() {
    return UserBuilder.aUser().withName(DEFAULT_NAME);
  }

  // static UserBuilder aUserWithNoPassword() {
  //   return UserBuilder.aDefaultUser().withNoPassword();
  // }
  //
  // static UserBuilder anAdmin() {
  //   return UserBuilder.aUser().inAdminRole();
  // }

  UserBuilder withName(String username) {
    this.name = username;
    return this;
  }

  // TODO building CareGiver for now. This should handle all user types.
  CareGiver buildCareGiver() {
    final anId = CareGiverId(id);
    final aName = CareGiverName(name);
    return new CareGiver(anId, aName);
  }
}
