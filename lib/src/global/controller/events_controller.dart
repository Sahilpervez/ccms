import 'dart:developer';

import 'package:ccms/src/global/providers/common_providers.dart';
import 'package:ccms/src/global/repo/events_repo.dart';
import 'package:ccms/src/models/events.dart';
import 'package:ccms/src/utils/config.dart';
import 'package:ccms/src/utils/snackbar_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final eventsControllerProvider =
    StateNotifierProvider<EventsController, List<Event>>((ref) {
  final repo = ref.watch(eventsRepoProvider);
  return EventsController(ref: ref, repo: repo);
});

class EventsController extends StateNotifier<List<Event>> {
  final EventsRepo _repo;
  final _name = "EVENTS CONTROLLER";
  EventsController({required ref, required repo})
      : _ref = ref,_repo = repo,
        super([]);
  final StateNotifierProviderRef<EventsController, List<Event>> _ref;

  // Add Events;  
  void addEvents(Event event){
    state.add(event);
    _repo.addEvent(event);
  }

  Future<List<Event>?> getEventsFromRepo({ BuildContext? context }) async {
    final eventsFetchStatus = _ref.read(isEventsFetchedProvider);
    if(eventsFetchStatus == true && state.isNotEmpty){
      return [...state];
    }

    final result = await _repo.getEvents();
    
    return result.fold(
      (failure){
        if(AppConfig.devMode && context!=null){
          SnackBarService.showSnackBar(context: context, message: "Events loading failed, Please try again later");
        }
        return null;
      },
      (events){
        if(AppConfig.devMode && context!=null){
          SnackBarService.showSnackBar(context: context, message: "Events loaded");
        }
        if(events != null){
          state = [...events];
        }
        _ref.read(isEventsFetchedProvider.notifier).update((state) => true,);
        return events;
      },
    );
  }
  
  
}
