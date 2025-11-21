import 'package:flutter/foundation.dart';
import '../models/event_model.dart';
import '../utils/constants.dart';

class EventProvider with ChangeNotifier {
  List<Event> _events = [];
  List<Event> _registeredEvents = [];

  EventProvider() {
    _loadEvents();
  }

  void _loadEvents() {
    _events = List.from(AppConstants.events);
    _registeredEvents = _events.where((event) => event.isRegistered).toList();
  }

  List<Event> get events => _events;
  List<Event> get registeredEvents => _registeredEvents;

  void registerForEvent(String eventId) {
    final index = _events.indexWhere((event) => event.id == eventId);
    if (index != -1) {
      _events[index] = _events[index].copyWith(isRegistered: true);
      _updateRegisteredEvents();
      notifyListeners();
    }
  }

  void cancelRegistration(String eventId) {
    final index = _events.indexWhere((event) => event.id == eventId);
    if (index != -1) {
      _events[index] = _events[index].copyWith(isRegistered: false);
      _updateRegisteredEvents();
      notifyListeners();
    }
  }

  void _updateRegisteredEvents() {
    _registeredEvents = _events.where((event) => event.isRegistered).toList();
  }

  bool isEventRegistered(String eventId) {
    return _events.any((event) => event.id == eventId && event.isRegistered);
  }
}
