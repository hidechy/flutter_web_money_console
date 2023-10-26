import 'package:flutter/material.dart';

import '../extensions/extensions.dart';
import '../model/money.dart';
import '../repository/money_repository.dart';

class HomeViewModel extends ChangeNotifier {
  HomeViewModel({required this.moneyRepository});

  final MoneyRepository moneyRepository;

  String yearmonth = DateTime.now().yyyymm;
  String date = '';

  Money money = Money(
    date: DateTime.now(),
    ym: '',
    yen10000: '',
    yen5000: '',
    yen2000: '',
    yen1000: '',
    yen500: '',
    yen100: '',
    yen50: '',
    yen10: '',
    yen5: '',
    yen1: '',
    bankA: '',
    bankB: '',
    bankC: '',
    bankD: '',
    bankE: '',
    payA: '',
    payB: '',
    payC: '',
    payD: '',
    payE: '',
    sum: '',
    currency: 0,
  );

  ///
  Future<void> getOnedayMoney({required String getDate}) async {
    date = getDate;
    money = await moneyRepository.getMoney(date: '$getDate 00:00:00'.toDateTime());
    notifyListeners();
  }

  ///
  void setPrevMonth({required String ym}) {
    yearmonth = DateTime(ym.split('-')[0].toInt(), ym.split('-')[1].toInt() - 1).yyyymm;
    notifyListeners();
  }

  ///
  void setNextMonth({required String ym}) {
    yearmonth = DateTime(ym.split('-')[0].toInt(), ym.split('-')[1].toInt() + 1).yyyymm;
    notifyListeners();
  }

  ///
  void setThisMonth({required String ym}) {
    yearmonth = DateTime(ym.split('-')[0].toInt(), ym.split('-')[1].toInt()).yyyymm;
    notifyListeners();
  }
}
