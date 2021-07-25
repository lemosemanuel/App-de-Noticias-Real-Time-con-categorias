import 'package:app_de_noticias/src/services/news_services.dart';
import 'package:app_de_noticias/src/widgets/lista_noticias.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// lo hago Statefull y ademas lo mezclo con el AutomaticKeepAliveClientMixin para que no destruya el estado
// osea que si me voy a otra pagina y vuelvo siga con el scroll down que habia hecho anteriormente
class Tab1Page extends StatefulWidget {
  @override
  _Tab1PageState createState() => _Tab1PageState();
}

class _Tab1PageState extends State<Tab1Page>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    final headline = Provider.of<NewService>(context).headline;
    // tenemos todos los headlines en newServices.headlines

    return Scaffold(
      // llamo la lista de noticias que traigo del widget de lista_noticias.dart
      // a esto le tengo que pasar la lista de noticias y me lo va a iterar y convertir en
      // un ListView.builder
      body: (headline!.length == 0)
          ? Center(child: CircularProgressIndicator())
          : ListaNoticias(headline),
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
