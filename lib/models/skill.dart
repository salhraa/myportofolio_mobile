import 'package:json_annotation/json_annotation.dart';

part 'skill.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class Skill {
  @JsonKey(includeToJson: false)
  final String id;

  final String name;
  final String level;
  final String description;
  final String? skillImageUrl;
  final int starCount;
  final bool isStarred;
  final String starredByNames;

  const Skill({
    required this.id,
    required this.name,
    required this.level,
    required this.description,
    this.skillImageUrl,
    required this.starCount,
    required this.isStarred,
    required this.starredByNames,
  });

  factory Skill.fromJson(Map<String, dynamic> json) => _$SkillFromJson(json);

  Map<String, dynamic> toJson() => _$SkillToJson(this);
}
