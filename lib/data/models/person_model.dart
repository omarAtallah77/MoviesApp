class PersonModel {
  final int id;
  final String name;
  final String? profilePath;
  final String? knownForDepartment;

  PersonModel({
    required this.id,
    required this.name,
    this.profilePath,
    this.knownForDepartment,
  });

  factory PersonModel.fromJson(Map<String, dynamic> json) {
    return PersonModel(
      id: json['id'],
      name: json['name'] ?? '',
      profilePath: json['profile_path'],
      knownForDepartment: json['known_for_department'],
    );
  }
}
