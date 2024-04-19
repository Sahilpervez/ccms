// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:ccms/src/models/events.dart';

class Speaker {
  final int speakerId;
  final String speakerName;
  final String? speakerBio;
  final List<Event> events;
  Speaker({
    this.speakerId = 0,
    this.speakerName = '',
    this.speakerBio,
    this.events = const [],
  });

  // Prisma Schema
  //
  // model Speaker {
  //   speaker_id   Int      @id @default(autoincrement())
  //   speaker_name String   @db.VarChar
  //   speaker_bio  String?  @db.VarChar
  //   events       EventToSpeaker[]

  //   @@map("speakers")
  // }



  Speaker copyWith({
    int? speakerId,
    String? speakerName,
    String? speakerBio,
    List<Event>? events,
  }) {
    return Speaker(
      speakerId: speakerId ?? this.speakerId,
      speakerName: speakerName ?? this.speakerName,
      speakerBio: speakerBio ?? this.speakerBio,
      events: events ?? this.events,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'speakerId': speakerId,
      'speakerName': speakerName,
      'speakerBio': speakerBio,
      'events': events.map((x) => x.toMap()).toList(),
    };
  }

  factory Speaker.fromMap(Map<String, dynamic> map) {
    return Speaker(
      speakerId: map['speakerId'] as int,
      speakerName: map['speakerName'] as String,
      speakerBio: map['speakerBio'] != null ? map['speakerBio'] as String : null,
      events: List<Event>.from((map['events'] as List<int>).map<Event>((x) => Event.fromMap(x as Map<String,dynamic>),),),
    );
  }

  String toJson() => json.encode(toMap());

  factory Speaker.fromJson(String source) => Speaker.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Speaker(speakerId: $speakerId, speakerName: $speakerName, speakerBio: $speakerBio, events: $events)';
  }

  @override
  bool operator ==(covariant Speaker other) {
    if (identical(this, other)) return true;
  
    return 
      other.speakerId == speakerId &&
      other.speakerName == speakerName &&
      other.speakerBio == speakerBio &&
      listEquals(other.events, events);
  }

  @override
  int get hashCode {
    return speakerId.hashCode ^
      speakerName.hashCode ^
      speakerBio.hashCode ^
      events.hashCode;
  }
}
