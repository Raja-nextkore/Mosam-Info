import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../helper/utils.dart';
import '../models/dailyWeather_model.dart';

class SevenDayForecast extends StatelessWidget {
  final wData;
  final List<DailyWeather> dWeather;

  const SevenDayForecast({
    Key key,
    this.wData,
    this.dWeather,
  }) : super(key: key);

  Widget dailyWidget(dynamic weather, BuildContext context) {
    final dayOfWeek = DateFormat('EEE').format(weather.date);
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 7.0),
      child: Column(
        children: [
          FittedBox(
            child: Text(
              dayOfWeek ?? '',
              style: const TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(5.0, 5.0, 5.0, 20.0),
            child: MapString.mapStringToIcon(
                '${weather.condition}', context, 35.0),
          ),
          Text(
            '${weather.condition}',
          ),
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
          padding: EdgeInsets.only(top: 25.0, left: 20.0),
          child: Text(
            'Next 7 Days',
            style: TextStyle(
              fontSize: 17.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Container(
          height: MediaQuery.of(context).size.height / 3.5,
          width: MediaQuery.of(context).size.width,
          margin: const EdgeInsets.all(15.0),
          padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 10.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15.0),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.4),
                spreadRadius: 0.0,
                blurRadius: 15.0,
                offset: const Offset(6.0, 8.0),
              ),
            ],
          ),
          child: ListView(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Today',
                        style: TextStyle(
                          fontSize: 15.0,
                        ),
                      ),
                      Text(
                        '${wData.weather.temp.toStringAsFixed(1)}°',
                        style: const TextStyle(
                          fontSize: 30.0,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      MapString.mapInputToWeather(
                          '${wData.weather.currently}', context)
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 20.0),
                    child: MapString.mapStringToIcon(
                        '${wData.weather.currently}', context, 45.0),
                  ),
                ],
              ),
              const SizedBox(height: 15.0),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: dWeather
                      .map((item) => dailyWidget(item, context))
                      .toList(),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
