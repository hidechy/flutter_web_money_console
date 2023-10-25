import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

import '../repository/money_repository.dart';
import '../viewmodel/home_viewmodel.dart';

List<SingleChildWidget> globalProviders = [...independentModels, ...dependentModels, ...viewModels];

List<SingleChildWidget> independentModels = [
  Provider<MoneyRepository>(create: (_) => MoneyRepository()),
];
List<SingleChildWidget> dependentModels = [];
List<SingleChildWidget> viewModels = [
  ChangeNotifierProvider<HomeViewModel>(
    create: (context) => HomeViewModel(
      moneyRepository: context.read<MoneyRepository>(),
    ),
  ),
];
