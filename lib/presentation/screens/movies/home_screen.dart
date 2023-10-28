import 'package:flutter/material.dart';
import 'package:cinemapedia/presentation/views/views.dart';
import 'package:cinemapedia/presentation/widgets/widgets.dart';

class HomeScreen extends StatefulWidget {

  static const name = 'home-screen';
  final int pageIndex;

  const HomeScreen({
    super.key, 
    required this.pageIndex
  });

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

//! AutomaticKeepAliveClientMixin -> Mantiene el estado del Pageview
class _HomeScreenState extends State<HomeScreen> with AutomaticKeepAliveClientMixin {

  late PageController pageController;

  @override
  void initState() {    
    super.initState();
    pageController = PageController(
      keepPage: true //! El controlador memoriza cuál es la página activa
    );
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();    
  }

  final viewRoutes = const <Widget>[
    HomeView(),
    PopularView(),
    FavoritesView()
  ];

  @override
  Widget build(BuildContext context) {    
    super.build(context);
    if ( pageController.hasClients ) {
      pageController.animateToPage(
        widget.pageIndex, 
        duration: const Duration( milliseconds: 250 ), 
        curve: Curves.easeInOut
      );
    }

    return Scaffold(
      body: PageView(
        physics: const NeverScrollableScrollPhysics(), //! Evita el deslizamiento manual entre páginas
        controller: pageController,        
        children: viewRoutes,
      ),
      bottomNavigationBar: CustomBottomNavigation(
        currentIndex: widget.pageIndex 
      )
    );
  }
  
  @override  
  bool get wantKeepAlive => true;
}

