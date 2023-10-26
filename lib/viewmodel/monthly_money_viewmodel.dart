import 'package:flutter/material.dart';

import '../model/money.dart';
import '../repository/money_repository.dart';

class MonthlyMoneyViewModel extends ChangeNotifier {
  MonthlyMoneyViewModel({required this.moneyRepository});

  final MoneyRepository moneyRepository;

  List<Money> monthlyMoneyList = [];

  ///
  Future<List<Money>> getMonthlyMoneyList({required String yearmonth}) async {
    return moneyRepository.getMonthlyMoneyList(yearmonth: yearmonth);
  }
}
