import 'package:app_de_noticias/src/models/category_model.dart';
import 'package:app_de_noticias/src/services/news_services.dart';
import 'package:app_de_noticias/src/theme/tema.dart';
import 'package:app_de_noticias/src/widgets/lista_noticias.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Tab2Page extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final newService = Provider.of<NewService>(context);
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            // muestro las categorias arriba en forma de botones
            _ListaCategorias(),

            //llamo a ListaNoticias que es igual que el tab1
            Expanded(
              child:
                  ListaNoticias(newService.getArticulosCategoriaSeleccionada!),
            )
          ],
        ),
      ),
    );
  }
}

class _ListaCategorias extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final categories = Provider.of<NewService>(context).categories;
    return Container(
      width: double.infinity,
      height: 125,
      // color: Colors.red,
      child: ListView.builder(
          physics: BouncingScrollPhysics(),
          scrollDirection: Axis.horizontal,
          itemCount: categories.length,
          itemBuilder: (BuildContext context, int index) {
            final categoriName = categories[index].name;
            return Container(
              // width: 105,
              child: Padding(
                padding: EdgeInsets.all(8),
                child: Column(
                  children: [
                    _CategoryButtom(categories[index]),
                    SizedBox(height: 5),
                    Text(
                        '${categoriName[0].toUpperCase()}${categoriName.substring(1)}')
                  ],
                ),
              ),
            );
          }),
    );
  }
}

class _CategoryButtom extends StatelessWidget {
  final Category categoria;

  const _CategoryButtom(this.categoria);

  @override
  Widget build(BuildContext context) {
    final newService = Provider.of<NewService>(context);

    // lo envuelvo en un gestureDetector para que pueda ser un boton ontap
    return GestureDetector(
      onTap: () {
        // print('${categoria.name}');
        final newService = Provider.of<NewService>(context, listen: false);
        newService.selectedCategory = categoria.name;
      },
      child: Container(
        width: 40,
        height: 40,
        margin: EdgeInsets.symmetric(horizontal: 10),
        decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.white),
        child: Icon(
          categoria.icon,
          color: (newService.selectedCategory == this.categoria.name)
              ? miTema.accentColor
              : Colors.black54,
        ),
      ),
    );
  }
}
