import 'dart:convert';

import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

import '/constants/models/booked_slot_model.dart';
import '/constants/models/event_model.dart';
import '../../../constants/models/registered_event.dart';
import '../../../constants/urls.dart';

part 'registered_events_and_orders_state.dart';

class RegisteredEventsAndOrdersCubit
    extends Cubit<RegisteredEventsAndOrdersState> {
  RegisteredEventsAndOrdersCubit() : super(RegisteredEventsAndOrdersLoading());

  Future<void> getRegisteredEventsAndOrders() async {
    emit(RegisteredEventsAndOrdersLoading());

    const storage = FlutterSecureStorage();
    var token = await storage.read(key: 'token');
    if (token != null) {
      http.Response? response;
      try {
        List<String> registeredCombos = [];

        response = await http.get(
          Uri.parse(EndPoints.transaction),
          headers: {
            "Content-Type": "application/json",
            "Authorization": "Bearer $token",
          },
        );
        var data = jsonDecode(response.body);
        List<RegisteredEvent> registeredOrders = data['transactions']
            .map<RegisteredEvent>((e) => RegisteredEvent.fromJson(e))
            .toList();
        //log(response.body);

        response = await http.get(
          Uri.parse(EndPoints.userEvents),
          headers: {
            "Content-Type": "application/json",
            "Authorization": "Bearer $token",
          },
        );
        var dataEve = jsonDecode(response.body);
        List<Events> registeredEvents =
            dataEve['events'].map<Events>((e) => Events.fromJson(e)).toList();
        //log(response.body);
        emit(RegisteredEventsAndOrdersLoaded(
          registeredEvents,
          registeredOrders,
          registeredCombos,
        ));
        return;
      } catch (e) {
        if (response == null) {
          //log('Registered Events Page Exception: $e');
          emit(RegisteredEventsAndOrdersError('Failed host lookup.'));
        } else {
          //log('Registered Events Page Exception: $e');
          emit(RegisteredEventsAndOrdersError(e.toString()));
        }
        return;
      }
    } else {
      emit(RegisteredEventsAndOrdersError('Logout and login again.'));
      return;
    }
  }

  Future<void> getUpdatedEvents(BuildContext context) async {
    emit(RegisteredOrdersandEventsUpdates());
    await getRegisteredEventsAndOrders();
  }

  Future<void> emitRegisteredEventsAndOrdersState(
    List<Events> registeredEvents,
    List<RegisteredEvent> registeredOrders,
    List<String> registeredCombos,
  ) async {
    emit(RegisteredEventsAndOrdersLoaded(
        registeredEvents, registeredOrders, registeredCombos));
  }

  Future<void> getOnlyRegisteredEvents() async {
    emit(RegisteredEventsAndOrdersLoading());

    const storage = FlutterSecureStorage();
    var token = await storage.read(key: 'token');
    if (token != null) {
      http.Response? response;
      try {
        response = await http.get(
          Uri.parse(EndPoints.userEvents),
          headers: {
            "Content-Type": "application/json",
            "Authorization": "Bearer $token",
          },
        );

        var dataEve = jsonDecode(response.body);
        List<BookedSlotModel> eventList = dataEve['events']
            .map<BookedSlotModel>((e) => BookedSlotModel.fromJson(e))
            .toList();
        //log(response.body);
        emit(RegisteredEvents(
          eventList,
        ));
      } catch (e) {
        if (response == null) {
          //log('Registered Events Page Exception: $e');
          emit(RegisteredEventsAndOrdersError('Failed host lookup.'));
        } else {
          //log('Registered Events Page Exception: $e');
          emit(RegisteredEventsAndOrdersError(e.toString()));
        }
      }
    } else {
      emit(RegisteredEventsAndOrdersError('Logout and login again.'));
    }
  }
}
