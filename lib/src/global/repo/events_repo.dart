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

  final _events = [
    // Event(
    //   eventDate: DateTime.now().copyWith(hour: 18, minute: 15),
    //   eventLength: const Duration(hours: 4),
    //   eventName: "Follow up with the client",
    //   priority: "High",
    //   icon: {"icon":ImageAssets.kiNearestEventsActive,"color" :const Color(0xff3F8CFF)},
    // ),
    // Event(
    //   eventDate: DateTime.now().copyWith(hour: 17, minute: 30).add(const Duration(days: 1)),
    //   eventLength: const Duration(hours: 4),
    //   eventName: "Meeting with Development Team",
    //   priority: "High",
    //   icon: {"icon":ImageAssets.kiNearestEventsMeeting,"color" :const Color(0xffFDC748)}
    // ),
    // Event(
    //   eventDate: DateTime.now().copyWith(hour: 17,minute: 10),
    //   eventLength: const Duration(hours: 2),
    //   eventName: "Abhigyna Birthday",
    //   priority: "Low",icon: {"icon":ImageAssets.kiNearestEventsBirthDay,"color" :const Color(0xffDE92EB)},
    // ),
    // Event(
    //   eventDate: DateTime(2023,9,15),
    //   eventLength: const Duration(hours: 3),
    //   eventName: "Connecting new lead",
    //   priority: "Low",
    //   icon: {"icon" : ImageAssets.kiNearestEventsConnect,"color" :const Color(0xff6D5DD3)}
    // ),
  ];

  Future<void> fetchEventsFromAPI() async {
    // Populate state with items from api if not exist in state
  }

  // Future<List> getEvents() async {
  //   // TODO: Make API Call and populate the _events List and also the state
  //   // fetchEventsFromAPI();
  //   return [..._events];
  // }

  // Future<void> addEvent(NearestEvents event) async{
  //   // TODO: Make API Call to add Event
  //   _events.add(event);
  //   // state.add(event);
  // }

  Future<bool?> addEvent(Event event) async {
    final eventDate = event.eventDate.copyWith(hour:event.eventTime.hour,minute: event.eventTime.minute);
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
      return null;
    }, (Response response) {
      final data = jsonDecode(response.body);
      if(data['status'] == true){
        return true;
      }
      return false;
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
