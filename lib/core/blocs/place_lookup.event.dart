part of 'place_lookup.dart';

@freezed
class PlaceLookupEvent with _$PlaceLookupEvent {
  const factory PlaceLookupEvent.onStarted() = _OnStarted;
  const factory PlaceLookupEvent.onQueryChanged(String? query) = _OnQueryChanged;
}
