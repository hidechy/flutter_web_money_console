enum APIPath {
  moneydl,
}

extension APIPathExtension on APIPath {
  String? get value {
    switch (this) {
      case APIPath.moneydl:
        return 'moneydl';
    }
  }
}
