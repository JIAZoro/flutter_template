import 'dart:convert';

import 'package:collection/collection.dart';
import 'package:flutter/cupertino.dart';

import 'item.dart';

@immutable
class Section {
  final String? id;
  final String? title;
  final int? courseId;
  final String? description;
  final String? order;
  final double? percent;
  final List<Item>? items;

  const Section({
    this.id,
    this.title,
    this.courseId,
    this.description,
    this.order,
    this.percent,
    this.items,
  });

  @override
  String toString() {
    return 'Section(id: $id, title: $title, courseId: $courseId, description: $description, order: $order, percent: $percent, items: $items)';
  }

  factory Section.fromMap(Map<String, dynamic> data) => Section(
        id: data['id'] as String?,
        title: data['title'] as String?,
        courseId: data['course_id'] as int?,
        description: data['description'] as String?,
        order: data['order'] as String?,
        percent: (data['percent'] as num?)?.toDouble(),
        items: (data['items'] as List<dynamic>?)
            ?.map((e) => Item.fromMap(e as Map<String, dynamic>))
            .toList(),
      );

  Map<String, dynamic> toMap() => {
        'id': id,
        'title': title,
        'course_id': courseId,
        'description': description,
        'order': order,
        'percent': percent,
        'items': items?.map((e) => e.toMap()).toList(),
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [Section].
  factory Section.fromJson(String data) {
    return Section.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [Section] to a JSON string.
  String toJson() => json.encode(toMap());

  Section copyWith({
    String? id,
    String? title,
    int? courseId,
    String? description,
    String? order,
    double? percent,
    List<Item>? items,
  }) {
    return Section(
      id: id ?? this.id,
      title: title ?? this.title,
      courseId: courseId ?? this.courseId,
      description: description ?? this.description,
      order: order ?? this.order,
      percent: percent ?? this.percent,
      items: items ?? this.items,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    if (other is! Section) return false;
    final mapEquals = const DeepCollectionEquality().equals;
    return mapEquals(other.toMap(), toMap());
  }

  @override
  int get hashCode =>
      id.hashCode ^
      title.hashCode ^
      courseId.hashCode ^
      description.hashCode ^
      order.hashCode ^
      percent.hashCode ^
      items.hashCode;
}
