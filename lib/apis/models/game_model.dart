// ignore_for_file: public_member_api_docs, sort_constructors_first
// To parse this JSON data, do
//
//     final gameModel = gameModelFromJson(jsonString);

import 'dart:convert';

import 'package:flutter/foundation.dart';

GameModel? gameModelFromJson(String str) =>
    GameModel.fromJson(json.decode(str));

String gameModelToJson(GameModel? data) => json.encode(data?.toJson());

class GameModel {
  bool? success;
  String? message;
  List<RandomResturent>? randomResturent;

  GameModel({
    this.success,
    this.message,
    this.randomResturent,
  });

  factory GameModel.fromJson(Map<String, dynamic> json) => GameModel(
        success: json["success"] as bool?,
        message: json["message"] as String?,
        randomResturent: json["randomResturent"] == null
            ? null
            : List<RandomResturent>.from(json["randomResturent"]
                .map((x) => RandomResturent.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "randomResturent": randomResturent == null
            ? null
            : List<dynamic>.from(randomResturent!.map((x) => x.toJson())),
      };

  GameModel copyWith({
    bool? success,
    String? message,
    List<RandomResturent>? randomResturent,
  }) {
    return GameModel(
      success: success ?? this.success,
      message: message ?? this.message,
      randomResturent: randomResturent ?? this.randomResturent,
    );
  }

  @override
  String toString() =>
      'GameModel(success: $success, message: $message, randomResturent: $randomResturent)';

  @override
  bool operator ==(covariant GameModel other) {
    if (identical(this, other)) return true;

    return other.success == success &&
        other.message == message &&
        listEquals(other.randomResturent, randomResturent);
  }

  @override
  int get hashCode =>
      success.hashCode ^ message.hashCode ^ randomResturent.hashCode;
}

class RandomResturent {
  String? id;
  String? gameUrl;
  String? gameName;
  DateTime? createdAt;
  DateTime? updatedAt;

  RandomResturent({
    this.id,
    this.gameUrl,
    this.gameName,
    this.createdAt,
    this.updatedAt,
  });

  factory RandomResturent.fromJson(Map<String, dynamic> json) =>
      RandomResturent(
        id: json["_id"] as String?,
        gameUrl: json["gameUrl"] as String?,
        gameName: json["gameName"] as String?,
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null
            ? null
            : DateTime.parse(json["updatedAt"]),
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "gameUrl": gameUrl,
        "gameName": gameName,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
      };

  RandomResturent copyWith({
    String? id,
    String? gameUrl,
    String? gameName,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return RandomResturent(
      id: id ?? this.id,
      gameUrl: gameUrl ?? this.gameUrl,
      gameName: gameName ?? this.gameName,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  bool operator ==(covariant RandomResturent other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.gameUrl == gameUrl &&
        other.gameName == gameName &&
        other.createdAt == createdAt &&
        other.updatedAt == updatedAt;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        gameUrl.hashCode ^
        gameName.hashCode ^
        createdAt.hashCode ^
        updatedAt.hashCode;
  }

  @override
  String toString() {
    return 'RandomResturent(id: $id, gameUrl: $gameUrl, gameName: $gameName, createdAt: $createdAt, updatedAt: $updatedAt)';
  }
}
