class LocationModel {
  final String id;
  final String name;
  final String? parentId;
  final List<dynamic>? children = [];

  LocationModel({required this.id, required this.name, this.parentId});

  factory LocationModel.fromJson(Map<String, dynamic> json) {
    return LocationModel(
      id: json['id'],
      name: json['name'],
      parentId: json['parentId'],
    );
  }
}