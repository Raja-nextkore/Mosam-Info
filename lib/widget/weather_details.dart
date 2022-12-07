import 'package:flutter/material.dart';
import 'package:weather_icons/weather_icons.dart';

class WeatherDetail extends StatelessWidget {
  final wData;

  const WeatherDetail({Key key, this.wData}) : super(key: key);

  Widget _gridWeatherBuilder(String header, String body, IconData icon) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15.0),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.25),
            spreadRadius: 0.0,
            blurRadius: 10.0,
            offset: const Offset(6.0, 8.0),
          ),
        ],
      ),
      padding: const EdgeInsets.all(15.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 15.0, right: 5.0),
              child: Icon(
                icon,
                color: Colors.blue,
                size: icon == WeatherIcons.strong_wind ? 25.0 : 35.0,
              ),
            ),
          ),
          const SizedBox(width: 15.0),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: Text(
                  header,
                  style: const TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 18.0,
                  ),
                ),
              ),
              Expanded(
                child: Text(
                  body,
                  style: const TextStyle(
                      fontWeight: FontWeight.w400, fontSize: 15.0),
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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.only(left: 20.0),
          child: Text(
            'Today Details',
            style: TextStyle(
              fontSize: 17.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height / 3,
          width: MediaQuery.of(context).size.width,
          child: GridView(
            padding: const EdgeInsets.all(15.0),
            gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 250,
              childAspectRatio: 2 / 1,
              crossAxisSpacing: 15,
              mainAxisSpacing: 15,
            ),
            children: [
              _gridWeatherBuilder('${wData.weather.humidity}%', 'Humidity',
                  WeatherIcons.raindrop),
              _gridWeatherBuilder('${wData.weather.windSpeed} km/h', 'Wind',
                  WeatherIcons.strong_wind),
              _gridWeatherBuilder(
                  '${wData.weather.feelsLike.toStringAsFixed(1)}°C',
                  'Feels Like',
                  WeatherIcons.celsius),
              _gridWeatherBuilder('${wData.weather.pressure} hPa', 'Pressure',
                  WeatherIcons.barometer),
            ],
          ),
        ),
      ],
    );
  }
}
