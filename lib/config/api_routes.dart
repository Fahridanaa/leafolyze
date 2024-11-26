class ApiRoutes {
  // Base paths
  static const String _auth = 'auth';
  static const String _articles = 'articles';
  static const String _products = 'products';
  static const String _detections = 'detections';
  static const String _diseases = 'diseases';
  static const String _profile = 'profile';
  static const String _shop = 'shop';

  // Auth routes
  static const auth = _AuthRoutes();
  static const articles = _ArticleRoutes();
  static const products = _ProductRoutes();
  static const detections = _DetectionRoutes();
  static const diseases = _DiseaseRoutes();
  static const profile = _ProfileRoutes();
  static const shop = _ShopRoutes();
}

class _AuthRoutes {
  const _AuthRoutes();

  String get login => '${ApiRoutes._auth}/login';
  String get register => '${ApiRoutes._auth}/register';
  String get me => '${ApiRoutes._auth}/me';
  String get logout => '${ApiRoutes._auth}/logout';
  String get refresh => '${ApiRoutes._auth}/refresh';
}

class _ArticleRoutes {
  const _ArticleRoutes();

  String get list => ApiRoutes._articles;
  String show(int id) => '${ApiRoutes._articles}/$id';
}

class _ProductRoutes {
  const _ProductRoutes();

  String get list => ApiRoutes._products;
  String show(int id) => '${ApiRoutes._products}/$id';
  String byShop(int shopId) => '${ApiRoutes._products}/shop/$shopId';
  String byDisease(int diseaseId) =>
      '${ApiRoutes._products}/disease/$diseaseId';
}

class _DetectionRoutes {
  const _DetectionRoutes();

  String get list => ApiRoutes._detections;
  String show(int id) => '${ApiRoutes._detections}/$id';
  String get store => ApiRoutes._detections;
  String create() => '${ApiRoutes._detections}/create';
  String update(int id) => '${ApiRoutes._detections}/$id';
  String delete(int id) => '${ApiRoutes._detections}/$id';
}

class _DiseaseRoutes {
  const _DiseaseRoutes();

  String get list => ApiRoutes._diseases;
  String show(int id) => '${ApiRoutes._diseases}/$id';
}

class _ProfileRoutes {
  const _ProfileRoutes();

  String get show => ApiRoutes._profile;
  String get update => '${ApiRoutes._profile}/update';
  String get updatePassword => '${ApiRoutes._profile}/password';
}

class _ShopRoutes {
  const _ShopRoutes();
  String get list => ApiRoutes._shop;
  String show(int id) => '${ApiRoutes._shop}/$id';
}
