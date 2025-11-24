class PersonModel {
  final int id;
  final String name;
  final String? profilePath;
  final String? knownForDepartment;
  final String? biography;

  PersonModel({
    required this.id,
    required this.name,
    this.profilePath,
    this.knownForDepartment,
    this.biography,
  });

  factory PersonModel.fromJson(Map<String, dynamic> json) {
    return PersonModel(
      id: json['id'] ?? 0,
      name: json['name'] ?? "Unknown",
      profilePath: json['profile_path'] as String?,
      knownForDepartment: json['known_for_department'] as String?,
      biography: json['biography'] as String?,
    );
  }
}
