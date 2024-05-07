import 'dart:convert';
import 'dart:developer';
import 'package:ccms/src/models/events.dart';
import 'package:ccms/src/res/endpoints.dart';
import 'package:ccms/src/res/strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ccms/src/core/core.dart';
import 'package:fpdart/fpdart.dart';
import 'package:http/http.dart';

final eventsRepoProvider = Provider<EventsRepo>((ref) {
  final api = ref.watch(networkRepoProvider);
  return EventsRepo(api: api);
});

// class NearestEventsRepo extends StateNotifier<List<NearestEvents>> {
class EventsRepo {
  final NetworkRepo _api;
  final _name = "EVENT_CONTROLLER";
  EventsRepo({required api}) : _api = api;

  FutureEither<Event?> addEvent(Event event) async {
    final eventDate = event.eventDate.copyWith(hour:event.eventTime.hour,minute: event.eventTime.minute);
    print(eventDate);
    final eventDateToSend = eventDate.toIso8601String().substring(0,19) + "Z";
    final eventModifiedOn = event.createdOn.toIso8601String().substring(0,19) + "Z";
    log("DATE TIME : ${eventDateToSend}");
    final body = {
      "club_id" : event.clubId,
      "event_title" : event.eventTitle,
      "event_description" : event.eventDescription,
      "event_date" : eventDateToSend,
      "event_time" : eventDateToSend,
      "event_location" : event.eventLocation,
      "created_on" : eventModifiedOn,
      "created_by" : event.createdBy,
      "last_modified_on": eventModifiedOn,
    };
    final result = await _api.postRequest(url: EndPoints.createEvent,requireAuth: false,body: body);
    
    return result.fold((Failure failure) {
      log(failure.message, name: _name);
      return Left(failure);
    }, (Response response) {
      final data = jsonDecode(response.body);
      print(data);
      final recievedEvent = Event.fromMap(data['body']['data']);
      if(data['status'] == true){
        return Right(recievedEvent);
      }
      return const Right(null);
    },);
  }

  FutureEither<bool?> enrollInEvent({required eventId, required studentId})async{
    final body = {
      "studentId" : studentId,
    };
    print("URL = ${"${EndPoints.enrollInEvent}$eventId"}");
    final result = await _api.postRequest(url: "${EndPoints.enrollInEvent}$eventId",requireAuth: false,body: body);

    return result.fold((Failure failure) {
      log(failure.message,name: _name);
      return Left(failure);
    }, (Response response) {
      final data = jsonDecode(response.body);
      if(data['status'] == true){
        return const Right(true);
      }
      return const Right(false);
    },);
  } 
  

  FutureEither<List<Event>?> getEvents() async {
    final result =
        await _api.getRequest(url: EndPoints.getEvents, requireAuth: false);
    return result.fold(
      (Failure failure) {
        log(failure.message, name: _name);
        return Left(failure);
      },
      (Response response) {
        try {
          final data = jsonDecode(response.body);
          final eventsMap = data['body']['data'];
          int i = 1;
          final List<Event> events = [];
          eventsMap.forEach((e) {
            
            events.add(
              Event.fromMap(e)
            );
            
            i++;
          });
          // for(dynamic product in eventJson){
          //   products.add(Event.fromMap(product));
          // }
          log("Value Returned");
          return Right(events);
        } catch (e, stktrc) {
          log(FailureMessage.jsonParsingFailed, name: _name);
          return Left(Failure(
            message: FailureMessage.jsonParsingFailed,
            stackTrace: stktrc,
          ));
        }
      },
    );

    // return [..._events];
  }
}
