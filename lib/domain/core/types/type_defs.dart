/// Json is an alias for _Map<String, dynamic>_
///
/// Example usage:
/// class User {
///   final String name;
///   final int age;  User.fromJson(Json json) :
///         name = json['name'],
///         age = json['age'];Json get json => {
///     'name': name,
///     'age': age,
///   };
/// }
typedef Json = Map<String, dynamic>;
