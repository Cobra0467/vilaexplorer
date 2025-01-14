import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vilaexplorer/l10n/app_localizations.dart';
import 'package:vilaexplorer/main.dart';  // Asegúrate de importar el archivo main.dart
import 'package:vilaexplorer/src/pages/homePage/menu_principal.dart';

class AppBarCustom extends StatelessWidget {
  final Function() onMenuPressed;
  const AppBarCustom({super.key, required this.onMenuPressed});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      backgroundColor: Colors.black87.withOpacity(0),
      foregroundColor: Colors.white,
      title: Row(
        children: _contentAppBar(context), // Pasa el context a la función para poder usarlo
      ),
    );
  }

  List<Widget> _contentAppBar(BuildContext context) {
    return <Widget>[
      Padding(
        padding: EdgeInsets.only(left: 5.w, right: 10.w),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 1.w, vertical: 1.h),
          decoration: BoxDecoration(
              color: Color.fromRGBO(36, 36, 36, 1),
              borderRadius: BorderRadius.all(Radius.circular(15.r))),
          child: GestureDetector(
            onTap: onMenuPressed,
            child: Container(
              height: 54.h,
              width: 50.w,
              decoration: BoxDecoration(
                  color: Color.fromRGBO(36, 36, 36, 1),
                  borderRadius: BorderRadius.all(Radius.circular(12.r))),
              child: Icon(
                Icons.menu,
                size: 30.r,
              ),
            ),
          ),
        ),
      ),
      Padding(
        padding: EdgeInsets.only(right: 50.r),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 5.h),
          decoration: BoxDecoration(
            color: Color.fromRGBO(36, 36, 36, 1),
            borderRadius: BorderRadius.all(Radius.circular(20.r)),
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 8.h),
            child: Row(
              children: [
                Padding(
                  padding: EdgeInsets.only(right: 10.w),
                  child: MySvgWidget(path: 'lib/icon/location.svg'),
                ),
                Text(
                  AppLocalizations.of(context)!.translate('villajoyosa'),
                  style: TextStyle(
                    fontFamily: 'assets/fonts/Poppins-ExtraLight.ttf',
                    fontSize: 20.sp,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      Spacer(), // Para separar el tiempo del menú y ubicación
      // Contenedor redondeado para el tiempo
      Container(
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
        decoration: BoxDecoration(
          color: Color.fromRGBO(36, 36, 36, 1),
          borderRadius: BorderRadius.all(Radius.circular(20.r)),  // Redondear el borde
        ),
        child: Row(
          children: [
            Padding(
              padding: EdgeInsets.only(right: 5.w),
              child: MySvgWidget(path: "lib/icon/sol_icon.svg", height: 20.h),
            ),
            Text(AppLocalizations.of(context)!.translate('weather_number')),
            // Aquí eliminamos el IconButton para el idioma
          ],
        ),
      ),
    ];
  }

  // Método para cambiar el idioma
  void _changeLanguage(BuildContext context, Locale locale) {
    // Llamar al método estático para cambiar el idioma sin usar setState
    MyApp.setLocale(context, locale);
  }
}
