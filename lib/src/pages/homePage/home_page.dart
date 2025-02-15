import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vilaexplorer/l10n/app_localizations.dart';
import 'package:vilaexplorer/providers/map_state_provider.dart';
import 'package:vilaexplorer/providers/page_provider.dart';
import 'package:vilaexplorer/service/lugar_interes_service.dart';
import 'package:vilaexplorer/src/pages/cuentaPage/cuenta_page.dart';
import 'package:vilaexplorer/src/pages/homePage/app_bar_custom.dart';
import 'package:vilaexplorer/src/pages/homePage/background_map.dart';
import 'package:vilaexplorer/src/pages/homePage/routes.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      _fetchUserData();
    });
  }

  void _fetchUserData() async {
    final lugaresDeInteresService =
        Provider.of<LugarDeInteresService>(context, listen: false);
    await lugaresDeInteresService.fetchLugaresDeInteresActivos();
  }

  @override
  Widget build(BuildContext context) {
    final pageProvider = Provider.of<PageProvider>(context, listen: true);
    final mapProvider = Provider.of<MapStateProvider>(context, listen: true);
    final isMapLoaded = mapProvider.isMapLoaded;

    return Scaffold(
      body: Stack(
        children: [
          BackgroundMap(),
          if (isMapLoaded) ...[
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: AppBarCustom(),
            ),
            Positioned.fill(
              child: Offstage(
                offstage: pageProvider.currentPage != 'routes',
                child: RoutesPage(
                  onClose: () => pageProvider.changePage('map'),
                ),
              ),
            ),
            Positioned.fill(
              child: Offstage(
                offstage: pageProvider.currentPage != 'cuenta',
                child: CuentaPage(),
              ),
            ),
            if (pageProvider.currentPage == 'map' &&
                pageProvider.idLugarDeInteres == null)
              Positioned(
                bottom: 145.h,
                right: 20.w,
                child: FloatingActionButton(
                  heroTag: "FAB-${UniqueKey()}",
                  backgroundColor: const Color.fromARGB(230, 50, 50, 50),
                  onPressed: () {
                    pageProvider.changePage('routes');
                  },
                  tooltip: AppLocalizations.of(context)!.translate('save_route'),
                  child: const Icon(
                    Icons.route_rounded,
                    color: Colors.white,
                  ),
                ),
              ),
            if (pageProvider.currentPage == 'map' &&
                pageProvider.idLugarDeInteres == null)
              Positioned(
                bottom: 75.h,
                right: 20.w,
                child: FloatingActionButton(
                  heroTag: "FAB-${UniqueKey()}",
                  backgroundColor: const Color.fromARGB(230, 50, 50, 50),
                  onPressed: () => mapProvider.toggleMapStyle(),
                  tooltip: AppLocalizations.of(context)!.translate('change_map_style'),
                  child: const Icon(
                    Icons.map,
                    color: Colors.white,
                  ),
                ),
              ),
          ]
        ],
      ),
    );
  }
}
