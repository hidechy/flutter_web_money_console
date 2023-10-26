// ignore_for_file: avoid_dynamic_calls

import '../data/http/client.dart';
import '../data/http/path.dart';
import '../extensions/extensions.dart';
import '../model/money.dart';
import '../utility/utility.dart';

class MoneyRepository {
  Utility utility = Utility();

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
  Future<Money> getMoney({required DateTime date}) async {
    await HttpClient().post(
      path: APIPath.moneydl,
      body: {'date': date.yyyymmdd},
    ).then((value) {
      var currency = 0;

      final currencyVal = <int>[];
      final currencyKey = [10000, 5000, 2000, 1000, 500, 100, 50, 10, 5, 1];
      currencyVal
        ..add(value['data']['yen_10000'] != null ? value['data']['yen_10000'].toString().toInt() : 0)
        ..add(value['data']['yen_5000'] != null ? value['data']['yen_5000'].toString().toInt() : 0)
        ..add(value['data']['yen_2000'] != null ? value['data']['yen_2000'].toString().toInt() : 0)
        ..add(value['data']['yen_1000'] != null ? value['data']['yen_1000'].toString().toInt() : 0)
        ..add(value['data']['yen_500'] != null ? value['data']['yen_500'].toString().toInt() : 0)
        ..add(value['data']['yen_100'] != null ? value['data']['yen_100'].toString().toInt() : 0)
        ..add(value['data']['yen_50'] != null ? value['data']['yen_50'].toString().toInt() : 0)
        ..add(value['data']['yen_10'] != null ? value['data']['yen_10'].toString().toInt() : 0)
        ..add(value['data']['yen_5'] != null ? value['data']['yen_5'].toString().toInt() : 0)
        ..add(value['data']['yen_1'] != null ? value['data']['yen_1'].toString().toInt() : 0);

      var i = 0;
      currencyVal.forEach((element) {
        if (element != 0) {
          currency += currencyKey[i] * element;
        }

        i++;
      });

      money = Money(
        date: date,
        ym: date.yyyymm,
        yen10000: value['data']['yen_10000'].toString(),
        yen5000: value['data']['yen_5000'].toString(),
        yen2000: value['data']['yen_2000'].toString(),
        yen1000: value['data']['yen_1000'].toString(),
        yen500: value['data']['yen_500'].toString(),
        yen100: value['data']['yen_100'].toString(),
        yen50: value['data']['yen_50'].toString(),
        yen10: value['data']['yen_10'].toString(),
        yen5: value['data']['yen_5'].toString(),
        yen1: value['data']['yen_1'].toString(),
        bankA: value['data']['bank_a'].toString(),
        bankB: value['data']['bank_b'].toString(),
        bankC: value['data']['bank_c'].toString(),
        bankD: value['data']['bank_d'].toString(),
        bankE: value['data']['bank_e'].toString(),
        payA: value['data']['pay_a'].toString(),
        payB: value['data']['pay_b'].toString(),
        payC: value['data']['pay_c'].toString(),
        payD: value['data']['pay_d'].toString(),
        payE: value['data']['pay_e'].toString(),
        sum: value['data']['sum'].toString(),
        currency: currency,
      );
      // ignore: body_might_complete_normally_catch_error
    }).catchError((error, _) {
      utility.showError('予期せぬエラーが発生しました');
    });

    return money;
  }

  ///
  Future<List<Money>> getMonthlyMoneyList({required String yearmonth}) async {
    final moneyList = <Money>[];

    await HttpClient().post(path: APIPath.getAllMoney).then((value) {
      for (var i = 0; i < value['data']?.length; i++) {
        final exData = value['data'][i].toString().split('|');

        if (yearmonth == exData[1]) {
          moneyList.add(
            Money(
              date: DateTime.parse('${exData[0]} 00:00:00'),
              ym: exData[1],
              yen10000: exData[2],
              yen5000: exData[3],
              yen2000: exData[4],
              yen1000: exData[5],
              yen500: exData[6],
              yen100: exData[7],
              yen50: exData[8],
              yen10: exData[9],
              yen5: exData[10],
              yen1: exData[11],
              bankA: exData[12],
              bankB: exData[13],
              bankC: exData[14],
              bankD: exData[15],
              bankE: exData[16],
              payA: exData[17],
              payB: exData[18],
              payC: exData[19],
              payD: exData[20],
              payE: exData[21],
              sum: '',
              currency: 0,
            ),
          );
        }
      }
    }).catchError((error, _) {
      utility.showError('予期せぬエラーが発生しました');
    });

    return moneyList;
  }
}
