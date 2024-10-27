import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class MenuPrincipal extends StatelessWidget {
  final Function()? onShowTradicionesPressed;
  final Function()? onShowGastronomiaPressed;

  const MenuPrincipal({
    super.key,
    this.onShowTradicionesPressed,
    this.onShowGastronomiaPressed,
  });

  @override
  Widget build(BuildContext context) {
    // CONTAINER DEL MENU PRINCIPAL
    return Container(
        decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30), topRight: Radius.circular(30)),
            color: Color.fromRGBO(32, 29, 29, 0.9)),
        height: MediaQuery.of(context).size.height / 2,
        child: Column(
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                  color: const Color.fromRGBO(39, 39, 39, 1).withOpacity(0.92),
                  borderRadius: const BorderRadius.all(Radius.circular(30))),
              // PRIMERA FILA -> BUSCADOR
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                      child: Padding(
                          padding: const EdgeInsets.only(
                              top: 10, right: 10, bottom: 10),
                          child: SizedBox(
                            height: 40,
                            child: Align(
                              alignment: Alignment.bottomCenter,
                              child: TextFormField(
                                style: const TextStyle(color: Colors.white),
                                decoration: InputDecoration(
                                  contentPadding:
                                      const EdgeInsets.only(left: 1),
                                  icon: const Padding(
                                    padding: EdgeInsets.only(
                                        top: 7, left: 20, bottom: 5),
                                    child: SizedBox(
                                      width: 35,
                                      child: MySvgWidget(
                                        path: "lib/icon/lupa.svg",
                                        height: 24,
                                        width: 24,
                                      ),
                                    ),
                                  ),
                                  hintText:
                                      'Buscar un lugar, evento o dirección...',
                                  hintStyle: const TextStyle(
                                    color: Color.fromRGBO(239, 239, 239, 0.8),
                                  ),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                    borderSide: BorderSide.none,
                                  ),
                                  filled: true,
                                  fillColor: const Color.fromRGBO(39, 39, 39, 1)
                                      .withOpacity(0.92),
                                ),
                                cursorColor: Colors.white,
                              ),
                            ),
                          ))),
                ],
              ),
            ),
            Divider(
              height: 5,
              color: Colors.black87.withOpacity(0),
            ),
            // FILA DE BOTONES -> MI CUENTA Y TRADICIONES
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Container(
                  margin: const EdgeInsets.only(right: 10),
                  child: Align(
                    alignment: Alignment.topRight,
                    child: _crearBoton(
                        120, "Tradiciones", "lib/icon/tradiciones.svg", 1),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(right: 10),
                  child: Align(
                    alignment: Alignment.center,
                    child: _crearBoton(
                        120, "Mi cuenta", "lib/icon/user_icon.svg", 1),
                  ),
                )
              ],
            ),

            Divider(
              height: 5,
              color: Colors.black87.withOpacity(0),
            ),
            // 2A FILA BOTONES -> GASTRONOMIA Y MONUMEBTOS
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Align(
                  alignment: Alignment.topLeft,
                  child: _crearBoton(
                      190, "Gastronomia", "lib/icon/gastronomia.svg", 1),
                ),
                Align(
                  alignment: Alignment.topRight,
                  child: _crearBoton(
                      190, "Monumentos", "lib/icon/monumentos.svg", 1),
                ),
              ],
            ),

            Divider(
              height: 5,
              color: Colors.black.withOpacity(0),
            ),
            // TERCERA FILA PARTE DE HISTORIAS
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.15,
              decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(13)),
                  color: Color.fromRGBO(39, 39, 39, 1)),
              padding: const EdgeInsets.all(15),
              margin: const EdgeInsets.only(left: 7, right: 7),
              child: const Stack(
                children: <Widget>[
                  Align(
                    alignment: Alignment.topLeft,
                    child: SizedBox(
                      height: 20,
                      child: Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          "Cerca",
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.topRight,
                    child: SizedBox(
                      height: 20,
                      child: Align(
                        alignment: Alignment.topRight,
                        child: Text(
                          "Ver más",
                          style: TextStyle(
                              color: Colors.blue, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ));
  }

  SizedBox _crearBoton(
      double mywidth, String texto, String imagePath, double tamanoTexto) {
    return SizedBox(
      width: mywidth,
      height: 110,
      child: ElevatedButton(
        style: ButtonStyle(
          padding: WidgetStateProperty.all<EdgeInsetsGeometry>(
            const EdgeInsets.all(15),
          ),
          foregroundColor: const WidgetStatePropertyAll(Colors.white),
          backgroundColor: WidgetStateProperty.all<Color>(
              const Color.fromRGBO(39, 39, 39, 1).withOpacity(0.92)),
          shape: WidgetStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0))),
          visualDensity: const VisualDensity(horizontal: 0, vertical: -1),
          overlayColor:
              WidgetStatePropertyAll<Color>(Colors.white.withOpacity(0.3)),
        ),
        child: Stack(
          children: [
            Positioned(
                top: 0,
                left: 0,
                child: MySvgWidget(path: imagePath, width: 50, height: 50)),
            Center(
              child: Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Align(
                    alignment: Alignment.bottomCenter,
                    child: Text(
                      texto,
                      style: TextStyle(
                        fontSize: tamanoTexto * 16,
                      ),
                    )),
              ),
            ),
          ],
        ),
        onPressed: () {
          if (texto == "Tradiciones" && onShowTradicionesPressed != null) {
            onShowTradicionesPressed!();
          } else if (texto == "Gastronomia" &&
              onShowGastronomiaPressed != null) {
            onShowGastronomiaPressed!();
          }
        },
      ),
    );
  }
}

class MySvgWidget extends StatelessWidget {
  final String path;
  final double? height;
  final double? width;
  final Alignment? alignment;

  const MySvgWidget({
    super.key,
    required this.path,
    this.height,
    this.width,
    this.alignment,
  });

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(path, height: height, width: width);
  }
}