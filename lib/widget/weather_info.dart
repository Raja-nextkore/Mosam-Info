import 'package:flutter/material.dart';
import 'package:weather_icons/weather_icons.dart';

import '../helper/utils.dart';

class WeatherInfo extends StatelessWidget {
  final wData;
  const WeatherInfo({Key key, this.wData}) : super(key: key);

  Widget _weatherInfoBuilder(String header, String body, IconData icon,
      double rightPad, double iconSize) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 5.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(bottom: 15.0, right: rightPad),
            child: Icon(
              icon,
              color: Colors.blue,
              size: iconSize,
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              FittedBox(
                child: Text(
                  header,
                  style: const TextStyle(
                      fontWeight: FontWeight.w400, fontSize: 15.0),
                ),
              ),
              FittedBox(
                child: Text(
                  body,
                  style: const TextStyle(
                      fontWeight: FontWeight.w700, fontSize: 15.0),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 20.0),
      height: MediaQuery.of(context).size.height / 6,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15.0),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.4),
              blurRadius: 15.0,
              offset: const Offset(6.0, 8.0),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              child: _weatherInfoBuilder(
                'Precipitation',
                '${wData.precip}%',
                WeatherIcons.raindrop,
                0.0,
                50.0,
              ),
            ),
            const VerticalDivider(
              color: Colors.black,
              indent: 25.0,
              endIndent: 25.0,
            ),
            SizedBox(
              child: _weatherInfoBuilder(
                'UV Index',
                UvIndex.mapUviValueToString(uvi: wData.uvi),
                WeatherIcons.day_sunny,
                15.0,
                30.0,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
