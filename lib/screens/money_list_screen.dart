import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../extensions/extensions.dart';
import '../model/money.dart';
import '../utility/utility.dart';
import '../viewmodel/home_viewmodel.dart';

// ignore: must_be_immutable
class MoneyListScreen extends StatelessWidget {
  MoneyListScreen({super.key});

  Utility utility = Utility();

  ///
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Consumer<HomeViewModel>(
        builder: (context, model, child) {
          return Padding(
            padding: const EdgeInsets.all(20),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  DefaultTextStyle(
                    style: const TextStyle(fontSize: 25, color: Colors.white),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          (model.date != '')
                              ? '${model.date}（${DateTime.parse('${model.date} 00:00:00').youbiStr.substring(0, 3)}）'
                              : '',
                        ),
                        Text((model.money.sum != 'null' && model.money.sum != '')
                            ? model.money.sum.toCurrency()
                            : (model.date != '')
                                ? '0'
                                : ''),
                      ],
                    ),
                  ),
                  if (model.money.yen10000 != 'null' && model.money.yen10000 != '') ...[
                    const SizedBox(height: 20),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(width: 180, child: _displayMoney(model.money)),
                        const SizedBox(width: 20),
                        SizedBox(width: 180, child: _displayBank(model.money)),
                        const SizedBox(width: 20),
                        SizedBox(width: 180, child: _displayPay(model.money)),
                      ],
                    ),
                  ],
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  ///
  Widget _displayMoney(Money money) {
    return Column(
      children: [
        _moneyDisplayUnit(key: '10000', value: money.yen10000),
        _moneyDisplayUnit(key: '5000', value: money.yen5000),
        _moneyDisplayUnit(key: '2000', value: money.yen2000),
        _moneyDisplayUnit(key: '1000', value: money.yen1000),
        _moneyDisplayUnit(key: '500', value: money.yen500),
        _moneyDisplayUnit(key: '100', value: money.yen100),
        _moneyDisplayUnit(key: '50', value: money.yen50),
        _moneyDisplayUnit(key: '10', value: money.yen10),
        _moneyDisplayUnit(key: '5', value: money.yen5),
        _moneyDisplayUnit(key: '1', value: money.yen1),
      ],
    );
  }

  ///
  Widget _displayBank(Money money) {
    return Column(
      children: [
        _moneyDisplayUnit(key: 'bank_a', value: money.bankA),
        _moneyDisplayUnit(key: 'bank_b', value: money.bankB),
        _moneyDisplayUnit(key: 'bank_c', value: money.bankC),
        _moneyDisplayUnit(key: 'bank_d', value: money.bankD),
        _moneyDisplayUnit(key: 'bank_e', value: money.bankE),
      ],
    );
  }

  ///
  Widget _displayPay(Money money) {
    return Column(
      children: [
        _moneyDisplayUnit(key: 'pay_a', value: money.payA),
        _moneyDisplayUnit(key: 'pay_b', value: money.payB),
        _moneyDisplayUnit(key: 'pay_c', value: money.payC),
        _moneyDisplayUnit(key: 'pay_d', value: money.payD),
        _moneyDisplayUnit(key: 'pay_e', value: money.payE),
      ],
    );
  }

  ///
  Widget _moneyDisplayUnit({required String key, required String value}) {
    final bankName = utility.getBankName();

    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(border: Border(bottom: BorderSide(color: Colors.white.withOpacity(0.3)))),
      height: 40,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(child: Text(bankName[key] ?? key)),
          Expanded(
            child: Container(
              alignment: Alignment.topRight,
              child: Text(value.toCurrency()),
            ),
          ),
        ],
      ),
    );
  }
}
