import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:vilaexplorer/src/pages/homePage/history_page.dart';
import 'dart:convert';
import 'package:flutter/services.dart';

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
    return FutureBuilder<Map<String, Map<String, String>>>(
      future: _loadHistoriasFromJson(),  // Asegúrate de llamar a la función aquí
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else {
          final historiasMap = snapshot.data!; // Cargar el mapa de historias

          return Container(
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30),
                topRight: Radius.circular(30),
              ),
              color: Color.fromRGBO(32, 29, 29, 0.9),
            ),
            height: MediaQuery.of(context).size.height / 2,
            child: Column(
              children: <Widget>[
                // Buscador
                Container(
                  decoration: BoxDecoration(
                    color: const Color.fromRGBO(39, 39, 39, 1).withOpacity(0.92),
                    borderRadius: const BorderRadius.all(Radius.circular(30)),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(top: 10, right: 10, bottom: 10),
                          child: SizedBox(
                            height: 40,
                            child: Align(
                              alignment: Alignment.bottomCenter,
                              child: TextFormField(
                                style: const TextStyle(color: Colors.white),
                                decoration: InputDecoration(
                                  contentPadding: const EdgeInsets.only(left: 1),
                                  icon: const Padding(
                                    padding: EdgeInsets.only(top: 7, left: 20, bottom: 5),
                                    child: SizedBox(
                                      width: 35,
                                      child: MySvgWidget(
                                        path: "lib/icon/lupa.svg",
                                        height: 24,
                                        width: 24,
                                      ),
                                    ),
                                  ),
                                  hintText: 'Buscar un lugar, evento o dirección...',
                                  hintStyle: const TextStyle(
                                    color: Color.fromRGBO(239, 239, 239, 0.8),
                                  ),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                    borderSide: BorderSide.none,
                                  ),
                                  filled: true,
                                  fillColor: const Color.fromRGBO(39, 39, 39, 1).withOpacity(0.92),
                                ),
                                cursorColor: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const Divider(height: 5, color: Colors.transparent),

                // Botones principales
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    _crearBoton(120, "Tradiciones", "lib/icon/tradiciones.svg", 1),
                    _crearBoton(120, "Favoritos", "lib/icon/favorite.svg", 1),
                    _crearBoton(120, "Mi cuenta", "lib/icon/user_icon.svg", 1),
                  ],
                ),

                const Divider(height: 5, color: Colors.transparent),

                // Segunda fila de botones
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    _crearBoton(190, "Gastronomia", "lib/icon/gastronomia.svg", 1),
                    _crearBoton(190, "Monumentos", "lib/icon/monumentos.svg", 1),
                  ],
                ),

                const Divider(height: 5, color: Colors.transparent),

                // Historias
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height * 0.15,
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(13)),
                    color: Color.fromRGBO(39, 39, 39, 1),
                  ),
                  padding: const EdgeInsets.all(15),
                  margin: const EdgeInsets.only(left: 7, right: 7),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: const [
                          Text(
                            "Cerca",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            "Ver más",
                            style: TextStyle(
                              color: Colors.blue,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Expanded(
                        child: ListView(
                          scrollDirection: Axis.horizontal,
                          children: historiasMap.keys.map((imageUrl) {
                            return _buildHistoriaItem(context, imageUrl, historiasMap[imageUrl]!, historiasMap); // Pasamos historiasMap
                          }).toList(),
                        ),
                      ),

                    ],
                  ),
                ),
              ],
            ),
          );
        }
      },
    );
  }

  // Método para crear los botones del menú principal
  Widget _crearBoton(double mywidth, String texto, String imagePath, double tamanoTexto) {
    return SizedBox(
      width: mywidth,
      height: 110,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.all(15),
          foregroundColor: Colors.white,
          backgroundColor: const Color.fromRGBO(39, 39, 39, 0.92),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30.0),
          ),
          splashFactory: InkRipple.splashFactory,
          shadowColor: Colors.white.withOpacity(0.3),
        ),
        onPressed: () {
          if (texto == "Tradiciones" && onShowTradicionesPressed != null) {
            onShowTradicionesPressed!();
          } else if (texto == "Gastronomia" && onShowGastronomiaPressed != null) {
            onShowGastronomiaPressed!();
          }
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            MySvgWidget(path: imagePath, width: 50, height: 50),
            const SizedBox(height: 5),
            Text(
              texto,
              style: TextStyle(fontSize: tamanoTexto * 16),
            ),
          ],
        ),
      ),
    );
  }

  // Método para cargar el JSON desde los assets
  static Future<Map<String, Map<String, String>>> _loadHistoriasFromJson() async {
    final String response = await rootBundle.loadString('assets/historias.json');
    final Map<String, dynamic> data = json.decode(response);
    return data.map((key, value) => MapEntry(key, Map<String, String>.from(value)));
  }

  // Método para crear los ítems de historia
  // Método para crear los ítems de historia
  // Método para crear los ítems de historia
  Widget _buildHistoriaItem(BuildContext context, String imageUrl, Map<String, String> historia, Map<String, Map<String, String>> historiasMap) {
    return GestureDetector(
      onTap: () {
        // Aquí convertimos las historias a una lista y conseguimos el índice de la historia seleccionada
        List<Map<String, String>> historiasList = historiasMap.values.toList();
        int initialIndex = historiasMap.keys.toList().indexOf(imageUrl);
        
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => HistoriaScreen(
              historias: historiasList, // Pasamos todas las historias
              initialIndex: initialIndex, // Pasamos el índice de la historia
            ),
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 5),
        width: 80,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(15),
          child: Image.asset(
            imageUrl,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }


}

// Widget de SVG personalizado
class MySvgWidget extends StatelessWidget {
  final String path;
  final double? height;
  final double? width;

  const MySvgWidget({
    super.key,
    required this.path,
    this.height,
    this.width,
  });

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(path, height: height, width: width);
  }
}