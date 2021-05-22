import 'package:flutter/material.dart';

class LocationHistoryMapper extends StatelessWidget {
  final _locationName;
  final _locationVisitDate;

  const LocationHistoryMapper(locationName, locationVisitDate)
      : _locationName = locationName,
        _locationVisitDate = locationVisitDate;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      title:
          Text(_locationName, style: Theme.of(context).textTheme.bodyText1) ??
              '',
      subtitle: Text(
            _locationVisitDate,
            style: Theme.of(context).textTheme.headline4,
          ) ??
          '',
    );
  }
}
