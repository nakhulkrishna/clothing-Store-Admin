class ProuctsAttributesModel {
  String? name;
  final List<String>? values;

  ProuctsAttributesModel({this.name, this.values});

  toJson() {
    return {"Name": name, "Values": values};
  }

  factory ProuctsAttributesModel.fromJson(Map<String, dynamic> document) {
    final data = document;

    if (data.isEmpty) return ProuctsAttributesModel();

    return ProuctsAttributesModel(
      name: data.containsKey("Name") ? data["Name"] : '',
      values: List<String>.from(data['Values']),
    );
  }
}
