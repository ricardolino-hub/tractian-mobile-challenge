
class CompanyModel {
  final String name;
  final String id;

  CompanyModel({required this.name, required this.id});

  factory CompanyModel.fromJson(Map<String, dynamic> json) {
    return CompanyModel(
      name: json['name'],
      id: json['id'],
    );
  }
}