// aca vamos a hacer las peticiones http
// asi que me voy a importar de models el mapeo que hago

import 'package:app_de_noticias/src/models/category_model.dart';
import 'package:app_de_noticias/src/models/new_models.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;

final _urlGeneral = 'https://newsapi.org/v2';
final _apikey = '32fd985e20e540b4900cfd9db7afabff';

class NewService with ChangeNotifier {
  // necesito que esto se redibuje constantemente asi que lo voy a poner en el padre main con Provider
  List<Article>? headline = [];

  // me creo una lista de categorias
  List<Category> categories = [
    Category(FontAwesomeIcons.building, 'business'),
    Category(FontAwesomeIcons.tv, 'entertainment'),
    Category(FontAwesomeIcons.addressCard, 'general'),
    Category(FontAwesomeIcons.headSideVirus, 'health'),
    Category(FontAwesomeIcons.vials, 'science'),
    Category(FontAwesomeIcons.volleyballBall, 'sports'),
    Category(FontAwesomeIcons.memory, 'technology'),
  ];

  // indico la categoria seleccionada
  String _selectedCategory = 'business';

  // creo un mapa para almacenar la categoria seleccionada
  Map<String, List<Article>> categoryArticles = {};

  NewService() {
    this.getTopHeadLines();
    categories.forEach((element) {
      this.categoryArticles[element.name] = [];
    });
  }

  String get selectedCategory => this._selectedCategory;

  set selectedCategory(String valor) {
    this._selectedCategory = valor;
    this.getArticleByCategory(valor);

    notifyListeners();
  }

  List<Article>? get getArticulosCategoriaSeleccionada =>
      this.categoryArticles[this.selectedCategory];

  getTopHeadLines() async {
    // para dibujar los headlines primero necesito la url
    final url = '$_urlGeneral/top-headlines?apiKey=$_apikey&country=us';
    final resp = await http.get(Uri.parse(url));

    // esta funcion de newsResponseFromJson es la primera que aparece en el model
    // recibe un string y regresa una instancia del New Services con todo los articulos sources etc
    final newResponse = newsResponseFromJson(resp.body);

    // ahora agrego los articulos al headlines
    this.headline!.addAll(newResponse.articles!);

    // notifico para todas las ramas
    notifyListeners();
  }

  getArticleByCategory(String category) async {
    // si ya tengo data no voy a instertar nada en categoryArticles
    if (this.categoryArticles[category]!.length > 0) {
      return this.categoryArticles[category];
    }

    // para dibujar los headlines primero necesito la url
    final url =
        '$_urlGeneral/top-headlines?apiKey=$_apikey&country=us&category=$category';
    final resp = await http.get(Uri.parse(url));

    // esta funcion de newsResponseFromJson es la primera que aparece en el model
    // recibe un string y regresa una instancia del New Services con todo los articulos sources etc
    final newResponse = newsResponseFromJson(resp.body);

    this.categoryArticles[category]!.addAll(newResponse.articles!);

    // notifico para todas las ramas
    notifyListeners();
  }
}
