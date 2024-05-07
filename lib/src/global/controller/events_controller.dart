import 'dart:developer';

import 'package:ccms/src/core/core.dart';
import 'package:ccms/src/feature/all_clubs/controller/clubs_controller.dart';
import 'package:ccms/src/global/providers/common_providers.dart';
import 'package:ccms/src/global/repo/events_repo.dart';
import 'package:ccms/src/models/events.dart';
import 'package:ccms/src/res/strings.dart';
import 'package:ccms/src/utils/config.dart';
import 'package:ccms/src/utils/snackbar_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

final eventsControllerProvider =
    StateNotifierProvider<EventsController, List<Event>>((ref) {
  final repo = ref.watch(eventsRepoProvider);
  return EventsController(ref: ref, repo: repo);
});

class EventsController extends StateNotifier<List<Event>> {
  final EventsRepo _repo;
  final _name = "EVENTS CONTROLLER";
  EventsController({required ref, required repo})
      : _ref = ref,
        _repo = repo,
        super([]);
  final StateNotifierProviderRef<EventsController, List<Event>> _ref;

  bool isLoading = false;

  // Add Events;
  Future<void> addEvents(
      {required Event event, required BuildContext context}) async {
    // state.add(event);
    _ref.read(isEventsFetchedProvider.notifier).update(
          (state) => false,
        );
    await _repo.addEvent(event).then(
      (value) {
        value.fold(
          (Failure failure) {
            log(failure.message);
            log(FailureMessage.eventCreationFailed, name: _name);
            return;
          },
          (Event? event) {
            if (event != null) {
              var involvedCubs = _ref.read(clubsControllerProvider).where(
                (element) {
                  return (element.clubId == event.clubId);
                },
              ).toList();
              final organizingClubs = involvedCubs.map(
                (e) {
                  return e.clubName;
                },
              ).toList();
              state.insert(0, event.copyWith(organizingClubs: organizingClubs));
              state = [...state];
              SnackBarService.showSnackBar(
                  context: context, message: "Event Created Successfully");
              return;
            }
            SnackBarService.showSnackBar(
                context: context, message: "Couldn't create Event");
            return;
          },
        );

        if (value == true) {
          SnackBarService.showSnackBar(
              context: context, message: "Event Created Successfully");
          if (context.canPop()) {
            context.pop();
          }
        } else {
          SnackBarService.showSnackBar(
              context: context, message: "Couldn't create Event");
          return;
        }
      },
    );
  }

  Future<bool> enrollInEvent({required eventId, required studentId,BuildContext? context})async{
    final body = {
      "studentId" : studentId,
    };
    final result = await _repo.enrollInEvent(eventId: eventId, studentId: studentId);

    return result.fold((l) {
      log(l.message,name: _name);
      if(context!= null){
        SnackBarService.showSnackBar(context: context, message: "Some Error Occured");
      }
      return false;
    }, (r) {
      if(r == true){
        if(context!= null){
          SnackBarService.showSnackBar(context: context, message: "Event Enrollment Successfull");
        }
        return true;
      }else{
        if(context != null){
          SnackBarService.showSnackBar(context: context, message: "Couldn't Enroll in this Event");
        }
      }
      return false;
    },);
  }

  Future<void> getEventsFromRepo({BuildContext? context}) async {
    final eventsFetchStatus = _ref.read(isEventsFetchedProvider);
    if (eventsFetchStatus == true && state.isNotEmpty) {
      // _repo.getEvents().then(
      //   (value) {
      //     value.fold(
      //       (failure) {
      //         if (AppConfig.devMode && context != null) {
      //           SnackBarService.showSnackBar(
      //               context: context,
      //               message: "Events loading failed, Please try again later");
      //         }
      //         isLoading = false;
      //         return ;
      //       },
      //       (events) {
      //         if (AppConfig.devMode && context != null) {
      //           SnackBarService.showSnackBar(
      //               context: context, message: "Events loaded");
      //         }
      //         if (events != null) {
      //           state = [...events];
      //           isLoading = false;
      //         }
      //         _ref.read(isEventsFetchedProvider.notifier).update(
      //               (state) => true,
      //             );
      //       },
      //     );
      //   },
      // );
      return;
    }

    isLoading = true;

    final result = await _repo.getEvents();

    return result.fold(
      (failure) {
        if (AppConfig.devMode && context != null) {
          SnackBarService.showSnackBar(
              context: context,
              message: "Events loading failed, Please try again later");
        }
        isLoading = false;
        return null;
      },
      (events) {
        if (AppConfig.devMode && context != null) {
          SnackBarService.showSnackBar(
              context: context, message: "Events loaded");
        }
        if (events != null) {
          state = [...events];
          isLoading = false;
        }
        _ref.read(isEventsFetchedProvider.notifier).update(
              (state) => true,
            );
        return;
      },
    );
  }
}
