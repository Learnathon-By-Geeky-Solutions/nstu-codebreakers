class ProjectEntity {
  int? id;
  String? name;
  String? description;
  String? createdAt;
  String? updatedAt;
  int? createdBy;

  ProjectEntity({
    required this.id,
    required this.name,
    required this.description,
    required this.createdAt,
    required this.updatedAt,
    required this.createdBy,
  });
}
