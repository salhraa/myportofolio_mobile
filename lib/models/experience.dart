
import 'package:json_annotation/json_annotation.dart';

part 'experience.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class Experience {
  @JsonKey(includeToJson: false)
  final String id;

  final String title;
  final String description;
  final String category;
  final DateTime? startedAt;
  final DateTime? endedAt;
  final bool isOngoing;
  final int starCount;
  final bool isStarred;
  final String starredByNames;

  const Experience({
    required this.id,
    required this.title,
    required this.description,
    required this.category,
    this.startedAt,
    this.endedAt,
    required this.isOngoing,
    required this.starCount,
    required this.isStarred,
    required this.starredByNames,
  });

  factory Experience.fromJson(Map<String, dynamic> json) =>
      _$ExperienceFromJson(json);

  Map<String, dynamic> toJson() => _$ExperienceToJson(this);
}
