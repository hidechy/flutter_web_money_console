enum APIPath {
  moneydl,
  getAllMoney,
}

extension APIPathExtension on APIPath {
  String? get value {
    switch (this) {
      case APIPath.moneydl:
        return 'moneydl';
      case APIPath.getAllMoney:
        return 'getAllMoney';
    }
  }
}
