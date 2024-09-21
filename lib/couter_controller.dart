import 'package:flutter/material.dart';

class CounterController extends ChangeNotifier {
  //PASO 1: Mi sección de propiedades (Variables, objetos, repositios, etc)
  // ------------------------------------------------------
  int _count = 0;

  // PASO 2: Tu seccion de getters
  // ------------------------------------------------------

  //Un getter es una función que su unico objetivos es retornar una propiedad privada
  int get getCount => _count;

  //PASO 3: Tu sección de funciones que efectuan la logica de tu frontend
  void increment() {
    //PASO 3.1 Logica de la función: Notificar cambio realizado
    _count++;

    //PASO 3.2: Notificar cambio realizado
    notifyListeners();
  }
}
