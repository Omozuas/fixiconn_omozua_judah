// ignore_for_file: public_member_api_docs, sort_constructors_first
// To parse this JSON data, do
//
//     final videoModel = videoModelFromJson(jsonString);

import 'dart:convert';

import 'package:flutter/foundation.dart';

VideoModel? videoModelFromJson(String str) =>
    VideoModel.fromJson(json.decode(str));

String videoModelToJson(VideoModel? data) => json.encode(data?.toJson());

class VideoModel {
  bool? success;
  List<Datum>? data;
  String? message;

  VideoModel({
    this.success,
    this.data,
    this.message,
  });

  factory VideoModel.fromJson(Map<String, dynamic> json) => VideoModel(
        success: json["success"],
        message: json["message"],
        data: json["data"] == null
            ? null
            : List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "data": data == null
            ? null
            : List<dynamic>.from(data!.map((x) => x.toJson())),
      };

  VideoModel copyWith({
    bool? success,
    List<Datum>? data,
    String? message,
  }) {
    return VideoModel(
      success: success ?? this.success,
      data: data ?? this.data,
      message: message ?? this.message,
    );
  }

  @override
  String toString() =>
      'VideoModel(success: $success, data: $data, message: $message)';

  @override
  bool operator ==(covariant VideoModel other) {
    if (identical(this, other)) return true;

    return other.success == success &&
        listEquals(other.data, data) &&
        other.message == message;
  }

  @override
  int get hashCode => success.hashCode ^ data.hashCode ^ message.hashCode;
}

class Datum {
  String? id;
  String? username;
  String? about;
  String? profileImage;
  int? likes;
  int? comments;
  int? bookmark;
  int? shares;
  List<dynamic>? isLikes;
  String? videoUrl;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? v;

  Datum({
    this.id,
    this.username,
    this.about,
    this.profileImage,
    this.likes,
    this.comments,
    this.bookmark,
    this.shares,
    this.isLikes,
    this.videoUrl,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["_id"],
        username: json["username"],
        about: json["about"],
        profileImage: json["profileImage"],
        likes: json["likes"],
        comments: json["comments"],
        bookmark: json["bookmark"],
        shares: json["shares"],
        isLikes: json["isLikes"] == null
            ? null
            : List<dynamic>.from(json["isLikes"].map((x) => x)),
        videoUrl: json["videoUrl"],
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null
            ? null
            : DateTime.parse(json["updatedAt"]),
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "username": username,
        "about": about,
        "profileImage": profileImage,
        "likes": likes,
        "comments": comments,
        "bookmark": bookmark,
        "shares": shares,
        "isLikes":
            isLikes == null ? null : List<dynamic>.from(isLikes!.map((x) => x)),
        "videoUrl": videoUrl,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "__v": v,
      };

  Datum copyWith({
    String? id,
    String? username,
    String? about,
    String? profileImage,
    int? likes,
    int? comments,
    int? bookmark,
    int? shares,
    List<dynamic>? isLikes,
    String? videoUrl,
    DateTime? createdAt,
    DateTime? updatedAt,
    int? v,
  }) {
    return Datum(
      id: id ?? this.id,
      username: username ?? this.username,
      about: about ?? this.about,
      profileImage: profileImage ?? this.profileImage,
      likes: likes ?? this.likes,
      comments: comments ?? this.comments,
      bookmark: bookmark ?? this.bookmark,
      shares: shares ?? this.shares,
      isLikes: isLikes ?? this.isLikes,
      videoUrl: videoUrl ?? this.videoUrl,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      v: v ?? this.v,
    );
  }

  @override
  String toString() {
    return 'Datum(id: $id, username: $username, about: $about, profileImage: $profileImage, likes: $likes, comments: $comments, bookmark: $bookmark, shares: $shares, isLikes: $isLikes, videoUrl: $videoUrl, createdAt: $createdAt, updatedAt: $updatedAt, v: $v)';
  }

  @override
  bool operator ==(covariant Datum other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.username == username &&
        other.about == about &&
        other.profileImage == profileImage &&
        other.likes == likes &&
        other.comments == comments &&
        other.bookmark == bookmark &&
        other.shares == shares &&
        listEquals(other.isLikes, isLikes) &&
        other.videoUrl == videoUrl &&
        other.createdAt == createdAt &&
        other.updatedAt == updatedAt &&
        other.v == v;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        username.hashCode ^
        about.hashCode ^
        profileImage.hashCode ^
        likes.hashCode ^
        comments.hashCode ^
        bookmark.hashCode ^
        shares.hashCode ^
        isLikes.hashCode ^
        videoUrl.hashCode ^
        createdAt.hashCode ^
        updatedAt.hashCode ^
        v.hashCode;
  }
}
