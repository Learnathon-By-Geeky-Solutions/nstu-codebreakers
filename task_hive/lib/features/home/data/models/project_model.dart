import 'package:task_hive/features/home/domain/entities/project_entity.dart';

class ProjectModel {
  int? id;
  String? name;
  String? description;
  String? createdAt;
  String? updatedAt;
  int? createdBy;

  ProjectModel({
    this.id,
    this.name,
    this.description,
    this.createdAt,
    this.updatedAt,
    this.createdBy,
  });

  ProjectModel.fromJson(Map<String, dynamic> json) {
    id = json['id'] ?? 0;
    name = json['name'] ?? 'No name';
    description = json['description'] ?? 'No description';
    createdAt = json['created_at'] ?? DateTime.now().toIso8601String();
    updatedAt = json['updated_at'] ?? DateTime.now().toIso8601String();
    createdBy = json['created_by'] ?? 'No creator';
  }
  ProjectEntity toEntity() {
    return ProjectEntity(
      id: id,
      name: name,
      description: description,
      createdAt: DateTime.tryParse(createdAt ?? '') ?? DateTime.now(),
      updatedAt: DateTime.tryParse(updatedAt ?? '') ?? DateTime.now(),
      createdBy: createdBy,
    );
  }
}
