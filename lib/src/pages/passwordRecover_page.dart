import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vilaexplorer/l10n/app_localizations.dart';
import 'dart:async';

class PasswordRecoverPage extends StatefulWidget {
  const PasswordRecoverPage({super.key});

  @override
  _PasswordRecoverPageState createState() => _PasswordRecoverPageState();
}

class _PasswordRecoverPageState extends State<PasswordRecoverPage> {
  bool _isButtonEnabled = true; // Estado del botón
  int _counter = 60; // Contador inicial
  Timer? _timer; // Temporizador
  final TextEditingController _emailController = TextEditingController(); // Controlador para el campo de texto

  @override
  void dispose() {
    _timer?.cancel(); // Cancelar el temporizador si la página se cierra
    _emailController.dispose(); // Limpiar el controlador cuando la página se cierra
    super.dispose();
  }

  void _startTimer() {
    setState(() {
      _isButtonEnabled = false; // Deshabilitar el botón al iniciar el temporizador
    });
    _counter = 60; // Reiniciar el contador

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_counter > 0) {
        setState(() {
          _counter--;
        });
      } else {
        _timer!.cancel();
        setState(() {
          _isButtonEnabled = true; // Habilitar el botón después de 60 segundos
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black54, // Fondo semitransparente
      body: Center(
        child: GestureDetector(
          onTap: () {
            // Cerrar la página si se toca fuera del cuadro
            Navigator.of(context).pop();
          },
          child: Stack(
            alignment: Alignment.topRight, // Alinear contenido en la parte superior derecha
            children: [
              Container(
                margin: EdgeInsets.symmetric(horizontal: 30.w),
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 28, 28, 28),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(height: 40.h), // Espacio superior para la X
                      Text(
                        AppLocalizations.of(context)!.translate('put_email'),
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 20),
                      TextField(
                        controller: _emailController, // Asignar el controlador
                        style: const TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                          labelText: AppLocalizations.of(context)!.translate('email'),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                      
                      const SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: _isButtonEnabled
                            ? () {
                                // Aquí puedes agregar lógica para enviar el correo
                                _startTimer(); // Iniciar el temporizador
                                _emailController.clear(); // Limpiar el campo de texto después de presionar el botón
                              }
                            : null, // Deshabilitar el botón si no se puede enviar
                        child: Text(AppLocalizations.of(context)!.translate('send')),
                      ),
                      const SizedBox(height: 20),
                      if (!_isButtonEnabled) // Mostrar el contador solo si el botón está deshabilitado
                        Column(
                          children: [
                            // Aquí agregamos otro texto antes del contador
                            Text(
                              AppLocalizations.of(context)!.translate('look_email'), // Nuevo texto
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                              ),
                            ),
                            const SizedBox(height: 10), 
                            
                            Divider(
                              color: Colors.white, 
                              thickness: 1, 
                              indent: 0, 
                              endIndent: 0, 
                            ),

                            const SizedBox(height: 10), 

                            Text(
                              AppLocalizations.of(context)!.translate('resend_in1') + _counter.toString() + AppLocalizations.of(context)!.translate('resend_in2'),
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                    ],
                  ),
                ),
              ),
              Positioned(
                right: 40,
                top: 10,
                child: IconButton(
                  icon: const Icon(Icons.close, color: Colors.white),
                  onPressed: () {
                    Navigator.of(context).pop(); // Cerrar la página
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }


  // Widget para mostrar una opción de idioma con la bandera
}
