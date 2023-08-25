import 'dart:convert';

import 'package:collection/collection.dart';
import 'package:flutter/cupertino.dart';

import 'section.dart';

@immutable
class RootModel {
  final List<Section>? sections;

  const RootModel({this.sections});

  @override
  String toString() => 'RootModel(sections: $sections)';

  factory RootModel.fromMap(Map<String, dynamic> data) => RootModel(
        sections: (data['sections'] as List<dynamic>?)
            ?.map((e) => Section.fromMap(e as Map<String, dynamic>))
            .toList(),
      );

  Map<String, dynamic> toMap() => {
        'sections': sections?.map((e) => e.toMap()).toList(),
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [RootModel].
  factory RootModel.fromJson(String data) {
    return RootModel.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [RootModel] to a JSON string.
  String toJson() => json.encode(toMap());

  RootModel copyWith({
    List<Section>? sections,
  }) {
    return RootModel(
      sections: sections ?? this.sections,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    if (other is! RootModel) return false;
    final mapEquals = const DeepCollectionEquality().equals;
    return mapEquals(other.toMap(), toMap());
  }

  @override
  int get hashCode => sections.hashCode;
}
