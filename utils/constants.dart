import '../models/event_model.dart';

class AppConstants {
  static const String appName = 'EventBuzz';

  // Dummy events data
  static final List<Event> events = [
    Event(
      id: '1',
      title: 'Tech Conference 2024',
      date: 'Dec 15, 2024',
      location: 'San Francisco, CA',
      imageUrl: 'assets/event1.png',
      description: 'Annual technology conference featuring the latest innovations in AI, blockchain, and cloud computing.',
    ),
    Event(
      id: '2',
      title: 'Music Festival',
      date: 'Jan 20, 2024',
      location: 'Los Angeles, CA',
      imageUrl: 'assets/event2.png',
      description: 'Summer music festival with top artists and bands from around the world.',
    ),
    Event(
      id: '3',
      title: 'Business Workshop',
      date: 'Feb 10, 2024',
      location: 'New York, NY',
      imageUrl: 'assets/event3.png',
      description: 'Business strategy workshop for entrepreneurs and startup founders.',
    ),
    Event(
      id: '4',
      title: 'Food & Wine Expo',
      date: 'Mar 5, 2024',
      location: 'Chicago, IL',
      imageUrl: 'assets/event4.png',
      description: 'Experience the finest culinary delights and wine tasting sessions.',
    ),
    Event(
      id: '5',
      title: 'Startup Pitch Competition',
      date: 'Apr 12, 2024',
      location: 'Austin, TX',
      imageUrl: 'assets/startup_pitch.jpg',
      description: 'Watch innovative startups pitch their ideas to top investors.',
    ),
  ];
}
