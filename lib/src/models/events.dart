// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'dart:convert';

// import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

// import 'package:ccms/src/models/club.dart';
// import 'package:ccms/src/models/speaker.dart';
// import 'package:ccms/src/models/student.dart';

class Event {
  final int eventId;
  final int clubId;
  final String eventTitle;
  final String? eventDescription;
  final DateTime eventDate;
  final TimeOfDay eventTime;
  final String eventLocation;
  final DateTime createdOn;
  final DateTime lastModifiedOn;
  final String createdBy; // 9 character long Student ID
  final List<String>? organizingClubs;
  final String? organizingStudent;
  // final List<String> attendance;
  // final List<Club> clubs;
  // final Student student; // Student Who Created the Event
  // final Speaker speakers;
  Event({
    this.eventId = 0,
    this.clubId = 0,
    this.eventTitle = '',
    this.eventDescription,
    required this.eventDate,
    required this.eventTime,
    this.eventLocation = '',
    required this.createdOn,
    required this.lastModifiedOn,
    this.createdBy = '',
    this.organizingClubs,
    this.organizingStudent,
    // this.attendance = const [],
    // this.clubs = const [],
    // required this.student,
    // required this.speakers,
  });

  // Pisma Schema
  //
  // model Event {
  //   event_id          Int          @id @default(autoincrement())
  //   club_id           Int          @default(autoincrement()) //auto-increment?
  //   event_title       String       @db.VarChar
  //   event_description String?
  //   event_date        DateTime?    @db.Date
  //   event_time        DateTime?    @db.Time(6)
  //   event_location    String?      @db.VarChar
  //   created_on        DateTime?    @db.Timestamp(6)
  //   last_modified_on  DateTime?    @db.Timestamp(6)
  //   created_by        String?      @db.VarChar(9)
  //   attendance        Attendance[] //what?
  //   clubs             Club         @relation(fields: [club_id], references: [club_id], onDelete: NoAction, onUpdate: NoAction, map: "events_club_id_clubs_club_id_fk")
  //   student           Student?     @relation(fields: [created_by], references: [enrollment_number], onDelete: NoAction, onUpdate: NoAction, map: "events_created_by_students_enrollment_number_fk")
  //   speakers           EventToSpeaker[]

  //   @@map("events")
  // }

  Event copyWith({
    int? eventId,
    int? clubId,
    String? eventTitle,
    String? eventDescription,
    DateTime? eventDate,
    TimeOfDay? eventTime,
    String? eventLocation,
    DateTime? createdOn,
    DateTime? lastModifiedOn,
    String? createdBy,
    List<String>? organizingClubs,
    String? organizingStudent,
    // List<String>? attendance,
    // List<Club>? clubs,
    // Student? student,
    // Speaker? speakers,
  }) {
    return Event(
      eventId: eventId ?? this.eventId,
      clubId: clubId ?? this.clubId,
      eventTitle: eventTitle ?? this.eventTitle,
      eventDescription: eventDescription ?? this.eventDescription,
      eventDate: eventDate ?? this.eventDate,
      eventTime: eventTime ?? this.eventTime,
      eventLocation: eventLocation ?? this.eventLocation,
      createdOn: createdOn ?? this.createdOn,
      lastModifiedOn: lastModifiedOn ?? this.lastModifiedOn,
      createdBy: createdBy ?? this.createdBy,
      organizingClubs: organizingClubs ?? this.organizingClubs,
      organizingStudent : organizingStudent ?? this.organizingStudent 
      // attendance: attendance ?? this.attendance,
      // clubs: clubs ?? this.clubs,
      // student: student ?? this.student,
      // speakers: speakers ?? this.speakers,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'event_id': eventId,
      'club_id': clubId,
      'event_title': eventTitle,
      'event_description': eventDescription,
      'event_date': eventDate.toIso8601String(),
      'event_time': eventTime.toString(),
      'event_location': eventLocation,
      'created_on': createdOn.toIso8601String(),
      'last_modified_on': lastModifiedOn.toIso8601String(),
      'created_by': createdBy,
      "clubs" : organizingClubs?.map((element) {
        return {'club_name' : element};
      },).toList(),
      'student' : {
        "first_name" : organizingStudent?.substring(0,organizingStudent?.indexOf(" ")),
        "last_name" : organizingStudent?.substring(organizingStudent?.indexOf(" ") ?? 0),
      }
      // 'attendance': attendance,
      // 'clubs': clubs.map((x) => x.toMap()).toList(),
      // 'student': student.toMap(),
      // 'speakers': speakers.toMap(),
    };
  }

  factory Event.fromMap(Map<String, dynamic> e) {
    // return Event(
    //   eventId: map['event_id'] as int,
    //   clubId: map['club_id'] as int,
    //   eventTitle: map['event_title'] as String,
    //   eventDescription: map['event_description'] != null ? map['event_description'] as String : null,
    //   eventDate: DateTime.fromMillisecondsSinceEpoch(map['event_date'] as int),
    //   eventTime: TimeOfDay.fromDateTime(DateTime.fromMillisecondsSinceEpoch(map['eventDate'] as int)),
    //   eventLocation: map['event_location'] as String,
    //   createdOn: DateTime.fromMillisecondsSinceEpoch(map['created_on'] as int),
    //   lastModifiedOn: DateTime.fromMillisecondsSinceEpoch(map['last_modified_on'] as int),
    //   createdBy: map['created_by'] as String,
    //   // attendance: List<String>.from((map['attendance'] as List<String>)),
    //   // clubs: List<Club>.from((map['clubs'] as List<int>).map<Club>((x) => Club.fromMap(x as Map<String,dynamic>),),),
    //   // student: Student.fromMap(map['student'] as Map<String,dynamic>),
    //   // speakers: Speaker.fromMap(map['speakers'] as Map<String,dynamic>),
    // );

    return Event(
      eventId: e['event_id'],
      clubId: e['club_id'],
      eventTitle: e['event_title'],
      eventDescription: e['event_description'],
      eventLocation: e['event_location'],
      eventDate: DateTime.parse(e['event_date']),
      eventTime: TimeOfDay.fromDateTime(DateTime.parse(e['event_date'])),
      createdOn: DateTime.parse(e['created_on']),
      lastModifiedOn: DateTime.parse(e['last_modified_on']),
      createdBy: e['created_by'],
      organizingClubs: [e['clubs']['club_name']],
      organizingStudent: e['student']['first_name'] + " " + e['student']['last_name'],
      // attendance: List<String>.from((map['attendance'] as List<String>)),
      // clubs: List<Club>.from((map['clubs'] as List<int>).map<Club>((x) => Club.fromMap(x as Map<String,dynamic>),),),
      // student: Student.fromMap(map['student'] as Map<String,dynamic>),
      // speakers: Speaker.fromMap(map['speakers'] as Map<String,dynamic>),
    );
  }

  String toJson() => json.encode(toMap());

  factory Event.fromJson(String source) =>
      Event.fromMap(jsonDecode(source) as Map<String, dynamic>);

  @override
  String toString() {
    // return 'Event(eventId: $eventId, clubId: $clubId, eventTitle: $eventTitle, eventDescription: $eventDescription, eventDate: $eventDate, EventTime: $eventTime, eventLocation: $eventLocation, createdOn: $createdOn, lastModifiedOn: $lastModifiedOn, createdBy: $createdBy, attendance: $attendance, clubs: $clubs, student: $student, speakers: $speakers)';

    return 'Event(eventId: $eventId, clubId: $clubId, eventTitle: $eventTitle, eventDescription: $eventDescription, eventDate: $eventDate, EventTime: $eventTime, eventLocation: $eventLocation, createdOn: $createdOn, lastModifiedOn: $lastModifiedOn, createdBy: $createdBy, organizingClubs : $organizingClubs, organizingStudent : $organizingStudent)';
  }

  @override
  bool operator ==(covariant Event other) {
    if (identical(this, other)) return true;

    return other.eventId == eventId &&
        other.clubId == clubId &&
        other.eventTitle == eventTitle &&
        other.eventDescription == eventDescription &&
        other.eventDate == eventDate &&
        other.eventTime == eventTime &&
        other.eventLocation == eventLocation &&
        other.createdOn == createdOn &&
        other.lastModifiedOn == lastModifiedOn &&
        other.createdBy == createdBy && 
        other.organizingClubs == organizingClubs &&
        other.organizingStudent == organizingStudent;
    // &&
    // listEquals(other.attendance, attendance) &&
    // listEquals(other.clubs, clubs) &&
    // other.student == student &&
    // other.speakers == speakers;
  }
}
