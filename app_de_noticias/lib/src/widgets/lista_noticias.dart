import 'package:app_de_noticias/src/models/new_models.dart';
import 'package:app_de_noticias/src/theme/tema.dart';
import 'package:flutter/material.dart';

class ListaNoticias extends StatelessWidget {
  // esta lista lo que va a hacer es recibe una lista de noticias
  final List<Article> noticias;

  // necesito crear su contructor ya que recibo esa lista
  const ListaNoticias(this.noticias);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: this.noticias.length,
        itemBuilder: (BuildContext context, int index) {
          return _Noticias(noticias: this.noticias[index], index: index);
        });
  }
}

// creo los widgets independientes para hacer la maqueta y que no me quede todo junto

class _Noticias extends StatelessWidget {
  // recibe los articulos y el index
  final Article noticias;
  final int index;

  const _Noticias({required this.noticias, required this.index});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _TarjetaTopBar(noticias: noticias, index: index),
        _TarjetaTitulo(noticias: noticias),
        _TarjetaImagen(noticias: noticias),
        _TarjetaBody(noticias: noticias),
        _TarjetaBotones(),
        SizedBox(height: 10),
        Divider(),
      ],
    );
  }
}

class _TarjetaBotones extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          RawMaterialButton(
            onPressed: () {},
            fillColor: miTema.accentColor,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            child: Icon(Icons.star_border),
          ),
          SizedBox(width: 10),
          RawMaterialButton(
            onPressed: () {},
            fillColor: Colors.blue,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            child: Icon(Icons.more),
          )
        ],
      ),
    );
  }
}

class _TarjetaBody extends StatelessWidget {
  final Article noticias;

  const _TarjetaBody({required this.noticias});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Text((noticias.description != null) ? noticias.description! : ''),
    );
  }
}

class _TarjetaImagen extends StatelessWidget {
  final Article noticias;

  const _TarjetaImagen({required this.noticias});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: ClipRRect(
        // con ese clipRRect podemos cortar el contenedor y jugar con la forma
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(50), bottomRight: Radius.circular(50)),

        child: Container(
          child: (noticias.urlToImage != null)
              ? FadeInImage(
                  placeholder: AssetImage('assets/img/giphy.gif'),
                  image: NetworkImage(noticias.urlToImage.toString()),
                )
              : Image(image: AssetImage('assets/img/no-image.png')),
        ),
      ),
    );
  }
}

class _TarjetaTitulo extends StatelessWidget {
  final Article noticias;

  const _TarjetaTitulo({required this.noticias});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15),
      child: Text('${noticias.title}',
          style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600)),
    );
  }
}

class _TarjetaTopBar extends StatelessWidget {
  final Article noticias;
  final int index;

  const _TarjetaTopBar({required this.noticias, required this.index});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10),
      margin: EdgeInsets.only(bottom: 10),
      child: Row(
        children: [
          Text('${index + 1}. ', style: TextStyle(color: miTema.accentColor)),
          Text('${noticias.source!.name}. ')
        ],
      ),
    );
  }
}
