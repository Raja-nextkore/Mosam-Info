import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:provider/provider.dart';

import '../provider/weather_provider.dart';

class LocationError extends StatefulWidget {
  const LocationError({Key key}) : super(key: key);

  @override
  LocationErrorState createState() => LocationErrorState();
}

class LocationErrorState extends State<LocationError> {
  @override
  Widget build(BuildContext context) {
    Location locaion = Location();
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            Icons.location_off,
            color: Colors.black,
            size: 75,
          ),
          const SizedBox(
            height: 10.0,
          ),
          const Text(
            'Your Location is Disabled',
            style: TextStyle(
              color: Colors.black,
              fontSize: 25,
              fontWeight: FontWeight.w500,
            ),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 75.0, vertical: 10.0),
            child: Text(
              'Please turn on your location service and refresh the app',
              style: TextStyle(
                color: Colors.black,
                fontSize: 15.0,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              primary: Theme.of(context).primaryColor,
              textStyle: const TextStyle(
                color: Colors.white,
              ),
              padding: const EdgeInsets.symmetric(horizontal: 50.0),
            ),
            onPressed: () async {
              await locaion.requestService().then((value) async {
                if (value) {
                  await Provider.of<WeatherProvider>(context, listen: false)
                      .getWeatherData();
                } else {
                  showDialog(
                      context: context,
                      barrierDismissible: false,
                      builder: (context) {
                        return AlertDialog(
                          title: const Text('Cannot Get Your Location'),
                          content: SingleChildScrollView(
                            child: ListBody(
                              children: const [
                                Text(
                                    'This app uses your phone location to get your location accurate weather data'),
                              ],
                            ),
                          ),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: const Text('OK'),
                            ),
                          ],
                        );
                      });
                }
              });
            },
            child: const Text('Enable Location'),
          )
        ],
      ),
    );
  }
}
