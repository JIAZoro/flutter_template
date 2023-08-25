import 'dart:convert';

import 'package:collection/collection.dart';
import 'package:flutter/cupertino.dart';

@immutable
class Item {
  final int? id;
  final String? type;
  final String? title;
  final bool? preview;
  final String? duration;
  final String? graduation;
  final String? status;
  final bool? locked;

  const Item({
    this.id,
    this.type,
    this.title,
    this.preview,
    this.duration,
    this.graduation,
    this.status,
    this.locked,
  });

  @override
  String toString() {
    return 'Item(id: $id, type: $type, title: $title, preview: $preview, duration: $duration, graduation: $graduation, status: $status, locked: $locked)';
  }

  factory Item.fromMap(Map<String, dynamic> data) => Item(
        id: data['id'] as int?,
        type: data['type'] as String?,
        title: data['title'] as String?,
        preview: data['preview'] as bool?,
        duration: data['duration'] as String?,
        graduation: data['graduation'] as String?,
        status: data['status'] as String?,
        locked: data['locked'] as bool?,
      );

  Map<String, dynamic> toMap() => {
        'id': id,
        'type': type,
        'title': title,
        'preview': preview,
        'duration': duration,
        'graduation': graduation,
        'status': status,
        'locked': locked,
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [Item].
  factory Item.fromJson(String data) {
    return Item.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [Item] to a JSON string.
  String toJson() => json.encode(toMap());

  Item copyWith({
    int? id,
    String? type,
    String? title,
    bool? preview,
    String? duration,
    String? graduation,
    String? status,
    bool? locked,
  }) {
    return Item(
      id: id ?? this.id,
      type: type ?? this.type,
      title: title ?? this.title,
      preview: preview ?? this.preview,
      duration: duration ?? this.duration,
      graduation: graduation ?? this.graduation,
      status: status ?? this.status,
      locked: locked ?? this.locked,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    if (other is! Item) return false;
    final mapEquals = const DeepCollectionEquality().equals;
    return mapEquals(other.toMap(), toMap());
  }

  @override
  int get hashCode =>
      id.hashCode ^
      type.hashCode ^
      title.hashCode ^
      preview.hashCode ^
      duration.hashCode ^
      graduation.hashCode ^
      status.hashCode ^
      locked.hashCode;
}
