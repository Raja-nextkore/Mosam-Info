import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../helper/utils.dart';
import '../models/dailyWeather_model.dart';
import '../screens/hourly_weather_screen.dart';

class HourlyForecast extends StatelessWidget {
  final List<DailyWeather> hourlyForecast;

  const HourlyForecast({Key key, this.hourlyForecast}) : super(key: key);

  Widget hourlyWidget(dynamic weather, BuildContext context) {
    final currentTime = weather.date;
    final hours = DateFormat.Hm().format(currentTime);

    return Expanded(
      child: Container(
        //padding: const EdgeInsets.all( 5.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15.0),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.3),
              spreadRadius: 1.0,
              blurRadius: 10.0,
              offset: const Offset(6.0, 8.0),
            ),
          ],
        ),
        height: 175.0,
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    hours,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 18.0,
                      color: Colors.black,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 25.0),
                    child: MapString.mapStringToIcon(
                        '${weather.condition}', context, 40.0),
                  ),
                  SizedBox(
                    width: 80.0,
                    child: Text(
                      "${weather.dailyTemp.toStringAsFixed(1)}°C",
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 20.0,
                        color: Colors.black,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 15.0),
      width: MediaQuery.of(context).size.width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Padding(
                padding: EdgeInsets.only(left: 5.0),
                child: Text(
                  'Next 3 Hours',
                  style: TextStyle(
                    fontSize: 17.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              TextButton(
                child: const Text(
                  'See More',
                  style: TextStyle(color: Colors.blue),
                ),
                onPressed: () {
                  Navigator.of(context)
                      .pushNamed(HourlyWeatherScreen.routeName);
                },
              ),
            ],
          ),
          const SizedBox(height: 5.0),
          Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: hourlyForecast
                  .map((item) => hourlyWidget(item, context))
                  .toList()),
        ],
      ),
    );
  }
}
