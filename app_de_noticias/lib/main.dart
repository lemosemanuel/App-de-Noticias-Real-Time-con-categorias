import 'package:app_de_noticias/src/pages/tabs_page.dart';
import 'package:app_de_noticias/src/services/news_services.dart';
import 'package:app_de_noticias/src/theme/tema.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      // me traigo el NewService de la Lista de la portada
      providers: [ChangeNotifierProvider(create: (_) => NewService())],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: miTema,
        title: 'Material App',
        home: TabsPage(),
      ),
    );
  }
}
