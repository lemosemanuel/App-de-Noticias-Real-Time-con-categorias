import 'package:app_de_noticias/src/pages/tab1_page.dart';
import 'package:app_de_noticias/src/pages/tab2_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TabsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // llamo al provider ya que quiero que _paginas y _navegacion se comuniquen
    return ChangeNotifierProvider(
      // me cree el widget _NavegacionModel para que haga de comunicador
      create: (_) => _NavegacionModel(),
      child: Scaffold(
        // creo un pageVie para desplazar al costado
        body: _Paginas(),
        bottomNavigationBar: _Navegacion(),
      ),
    );
  }
}

class _Navegacion extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // recordar que context tiene toda la info del arbol de widget
    // por ende alli se encuentra la intancia de Provider
    // asi que busco del context mi <_NavegacionModel>
    final navegacionModel = Provider.of<_NavegacionModel>(context);

    return BottomNavigationBar(
      currentIndex: navegacionModel.paginaActual,
      onTap: (i) => navegacionModel.paginaActual = i,
      items: [
        BottomNavigationBarItem(
            icon: Icon(Icons.person_outline), title: Text('Para ti')),
        BottomNavigationBarItem(
            icon: Icon(Icons.public), title: Text('Encabezados')),
      ],
    );
  }
}

class _Paginas extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // recordar que context tiene toda la info del arbol de widget
    // por ende alli se encuentra la intancia de Provider
    // asi que busco del context mi <_NavegacionModel>
    final navegacionModel = Provider.of<_NavegacionModel>(context);

    return PageView(
      // para controlar las paginas controller: PageController(initialPage: 0),
      // pero voy a acceder directamente desde navegacionModel

      controller: navegacionModel.pageController,

      // el fisic es para marcar que ya no puede ir mas para el costa
      // physics: BouncingScrollPhysics(),
      // con necer lo bloqueo , osea no me deja moverlo , ya que lo quiero mover con el bottomNavigator
      physics: NeverScrollableScrollPhysics(),
      children: [
        Tab1Page(),
        Tab2Page(),
      ],
    );
  }
}

// esto me va a ayudar a que se redibuje todo (osea cuando toque el bottomNavigator se cambie de pagina) ya que ahora estan en dos widget diferentes
class _NavegacionModel with ChangeNotifier {
  // este va a tener Geter y Seter porque me interesa que se cambie y que lo escuchen
  int _paginaActual = 0;

  // este en cambio no va a tener Seter porque no quiero que nadie lo cambie
  PageController _pageController = PageController();

  int get paginaActual => this._paginaActual;
  PageController get pageController => this._pageController;

  set paginaActual(int valor) {
    this._paginaActual = valor;

    // disparo el metodo de pageController para que se redibuje tambien
    _pageController.animateToPage(valor,
        duration: Duration(milliseconds: 250), curve: Curves.easeOutSine);
    // notifico a todos los widget para que se redibujen
    notifyListeners();
  }
}
