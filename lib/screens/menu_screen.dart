import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../extensions/extensions.dart';
import '../viewmodel/home_viewmodel.dart';
import 'components/_money_dialog.dart';
import 'components/monthly_list_alert.dart';

// ignore: must_be_immutable
class MenuScreen extends StatelessWidget {
  MenuScreen({super.key});

  DateTime calendarMonthFirst = DateTime.now();

  List<String> youbiList = ['Sunday', 'Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday'];

  List<String> calendarDays = [];

  late BuildContext _context;

  ///
  @override
  Widget build(BuildContext context) {
    _context = context;

    final homeViewModel = context.read<HomeViewModel>();

    return Consumer<HomeViewModel>(
      builder: (context, model, child) {
        return SizedBox(
          width: double.infinity,
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      onPressed: () => homeViewModel.setPrevMonth(ym: model.yearmonth),
                      icon: const Icon(Icons.arrow_back),
                    ),
                    Text(model.yearmonth),
                    IconButton(
                      onPressed: () => homeViewModel.setNextMonth(ym: model.yearmonth),
                      icon: const Icon(Icons.arrow_forward),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                _getCalendar(
                  date: DateTime(model.yearmonth.split('-')[0].toInt(), model.yearmonth.split('-')[1].toInt()),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.black.withOpacity(0.4)),
                  onPressed: () {
                    homeViewModel.setThisMonth(ym: model.yearmonth);

                    MoneyDialog(context: context, widget: const MonthlyListAlert());
                  },
                  child: const Text('Monthly List'),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  ///
  Widget _getCalendar({required DateTime date}) {
    calendarMonthFirst = DateTime(date.year, date.month);

    final monthEnd = DateTime(date.year, date.month + 1, 0);

    final diff = monthEnd.difference(calendarMonthFirst).inDays;
    final monthDaysNum = diff + 1;

    final youbi = calendarMonthFirst.youbiStr;
    final youbiNum = youbiList.indexWhere((element) => element == youbi);

    final weekNum = ((monthDaysNum + youbiNum) <= 35) ? 5 : 6;

    calendarDays = List.generate(weekNum * 7, (index) => '');

    for (var i = 0; i < (weekNum * 7); i++) {
      if (i >= youbiNum) {
        final gendate = calendarMonthFirst.add(Duration(days: i - youbiNum));

        if (calendarMonthFirst.month == gendate.month) {
          calendarDays[i] = gendate.day.toString();
        }
      }
    }

    final list = <Widget>[];
    for (var i = 0; i < weekNum; i++) {
      list.add(_getCalendarRow(week: i));
    }

    return DefaultTextStyle(style: const TextStyle(fontSize: 10), child: Column(children: list));
  }

  ///
  Widget _getCalendarRow({required int week}) {
    final homeViewModel = _context.read<HomeViewModel>();

    final list = <Widget>[];

    for (var i = week * 7; i < ((week + 1) * 7); i++) {
      final cellBgColor =
          (DateTime.parse('${homeViewModel.yearmonth}-${calendarDays[i].padLeft(2, '0')} 00:00:00').yyyymmdd ==
                  DateTime.now().yyyymmdd)
              ? Colors.yellowAccent.withOpacity(0.2)
              : Colors.transparent;

      list.add(
        Expanded(
          child: GestureDetector(
            onTap: () {
              homeViewModel.getOnedayMoney(
                getDate: '${homeViewModel.yearmonth}-${calendarDays[i].padLeft(2, '0')}',
              );
            },
            child: Container(
              margin: const EdgeInsets.all(1),
              padding: const EdgeInsets.all(2),
              decoration: BoxDecoration(
                border: Border.all(color: (calendarDays[i] == '') ? Colors.transparent : Colors.white.withOpacity(0.4)),
                color: cellBgColor,
              ),
              child: (calendarDays[i] == '')
                  ? const Text('')
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(calendarDays[i].padLeft(2, '0'), style: const TextStyle(color: Colors.white)),
                        const SizedBox(height: 30),
                      ],
                    ),
            ),
          ),
        ),
      );
    }

    return Row(crossAxisAlignment: CrossAxisAlignment.start, children: list);
  }
}
