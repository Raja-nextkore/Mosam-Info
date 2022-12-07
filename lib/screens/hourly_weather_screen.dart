import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mosam_info/helper/utils.dart';
import 'package:provider/provider.dart';

import '../provider/weather_provider.dart';

class HourlyWeatherScreen extends StatelessWidget {
  static const routeName = '/hourlyScreen';

  const HourlyWeatherScreen({Key key}) : super(key: key);

  Widget dailyWidget(dynamic weather, BuildContext context) {
    final time = weather.date;
    final hours = DateFormat.Hm().format(time);
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 5.0),
      padding: const EdgeInsets.symmetric(horizontal: 15.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            blurRadius: 5.0,
            offset: const Offset(2.0, 6.0),
          ),
        ],
      ),
      child: Row(
        children: [
          Text(
            hours ?? '',
            style: const TextStyle(
              color: Colors.black,
              fontSize: 20.0,
              fontWeight: FontWeight.w400,
            ),
          ),
          const Spacer(),
          Text(
            '${weather.dailyTemp.toStringAsFixed(1)}°',
            style: const TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.w400,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 15.0, bottom: 15.0),
            child: MapString.mapStringToIcon(weather.condition, context, 25.0),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final weatherData = Provider.of<WeatherProvider>(context, listen: false);
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.transparent,
          title: const Text(
            'Next 24 Hours',
            style: TextStyle(
              color: Colors.black,
            ),
          ),
        ),
        body: SizedBox(
          height: mediaQuery.size.height,
          width: mediaQuery.size.width,
          child: ListView(
            children: weatherData.hourly24Weather
                .map((item) => dailyWidget(item, context))
                .toList(),
          ),
        ),
      ),
    );
  }
}
