abstract class JsonModel<T> {
  JsonModel fromJson(Map<String, dynamic> json);
  Map<String, dynamic> toJson();
}

