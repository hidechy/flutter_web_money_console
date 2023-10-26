import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../extensions/extensions.dart';
import '../../model/money.dart';
import '../../viewmodel/home_viewmodel.dart';
import '../../viewmodel/monthly_money_viewmodel.dart';

class MonthlyListAlert extends StatelessWidget {
  const MonthlyListAlert({super.key});

  ///
  @override
  Widget build(BuildContext context) {
    final monthlyMoneyViewModel = context.read<MonthlyMoneyViewModel>();

    return AlertDialog(
      titlePadding: EdgeInsets.zero,
      contentPadding: EdgeInsets.zero,
      backgroundColor: Colors.transparent,
      insetPadding: EdgeInsets.zero,
      content: Consumer<HomeViewModel>(
        builder: (context, model, child) {
          return Container(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            width: double.infinity,
            height: double.infinity,
            child: DefaultTextStyle(
              style: const TextStyle(fontSize: 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 20),
                  Container(width: context.screenSize.width),
                  Text(model.yearmonth, style: const TextStyle(color: Colors.white)),
                  const SizedBox(height: 20),
                  FutureBuilder(
                    future: monthlyMoneyViewModel.getMonthlyMoneyList(yearmonth: model.yearmonth),
                    builder: (BuildContext context, AsyncSnapshot<List<Money>> snapshot) {
                      if (snapshot.hasData && snapshot.data != null) {
                        return SizedBox(
                          width: double.maxFinite,
                          height: context.screenSize.height * 0.7,
                          child: ListView.builder(
                            itemCount: snapshot.data!.length,
                            itemBuilder: (context, index) {
                              return DefaultTextStyle(
                                style: const TextStyle(color: Colors.white, fontSize: 10),
                                child: Expanded(child: monthlyMoneyListRow(snapshot, index)),
                              );
                            },
                          ),
                        );
                      } else {
                        return Container();
                      }
                    },
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  ///
  Widget monthlyMoneyListRow(AsyncSnapshot<List<Money>> snapshot, int index) {
    return Row(
      children: [
        monthlyMoneyListCell(value: snapshot.data![index].date.yyyymmdd, flex: 2, left: true),
        monthlyMoneyListCell(value: snapshot.data![index].yen10000, flex: 1),
        monthlyMoneyListCell(value: snapshot.data![index].yen5000, flex: 1),
        monthlyMoneyListCell(value: snapshot.data![index].yen2000, flex: 1),
        monthlyMoneyListCell(value: snapshot.data![index].yen1000, flex: 1),
        monthlyMoneyListCell(value: snapshot.data![index].yen500, flex: 1),
        monthlyMoneyListCell(value: snapshot.data![index].yen100, flex: 1),
        monthlyMoneyListCell(value: snapshot.data![index].yen50, flex: 1),
        monthlyMoneyListCell(value: snapshot.data![index].yen10, flex: 1),
        monthlyMoneyListCell(value: snapshot.data![index].yen5, flex: 1),
        monthlyMoneyListCell(value: snapshot.data![index].yen1, flex: 1),
        monthlyMoneyListCell(value: snapshot.data![index].bankA, flex: 2),
        monthlyMoneyListCell(value: snapshot.data![index].bankB, flex: 2),
        monthlyMoneyListCell(value: snapshot.data![index].bankC, flex: 2),
        monthlyMoneyListCell(value: snapshot.data![index].bankD, flex: 2),
        monthlyMoneyListCell(value: snapshot.data![index].bankE, flex: 2),
        monthlyMoneyListCell(value: snapshot.data![index].payA, flex: 2),
        monthlyMoneyListCell(value: snapshot.data![index].payB, flex: 2),
        monthlyMoneyListCell(value: snapshot.data![index].payC, flex: 2),
        monthlyMoneyListCell(value: snapshot.data![index].payD, flex: 2),
        monthlyMoneyListCell(value: snapshot.data![index].payE, flex: 2),
      ],
    );
  }

  ///
  Expanded monthlyMoneyListCell({required String value, required int flex, bool? left}) {
    return Expanded(
      flex: flex,
      child: Container(
        alignment: (left == true) ? Alignment.topLeft : Alignment.topRight,
        child: Text((left == true) ? value : value.toCurrency()),
      ),
    );
  }
}
