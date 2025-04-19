class ProjectEntity {
  int? id;
  String? name;
  String? description;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? createdBy;

  ProjectEntity({
    this.id,
    this.name,
    this.description,
    this.createdAt,
    this.updatedAt,
    this.createdBy,
  });

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'description': description,
      'created_by': createdBy,
    };
  }
}
