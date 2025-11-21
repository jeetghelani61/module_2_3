// models/event_model.dart
class Event {
  final String id;
  final String title;
  final String date;
  final String location;
  final String imageUrl;
  final String description;
  bool isRegistered;

  Event({
    required this.id,
    required this.title,
    required this.date,
    required this.location,
    required this.imageUrl,
    required this.description,
    this.isRegistered = false,
  });

  Event copyWith({bool? isRegistered}) {
    return Event(
      id: id,
      title: title,
      date: date,
      location: location,
      imageUrl: imageUrl,
      description: description,
      isRegistered: isRegistered ?? this.isRegistered,
    );
  }
}
