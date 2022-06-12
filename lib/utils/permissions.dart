import 'package:egresadoapp/api/endpoints/api_colaboracion.dart';
import 'package:egresadoapp/api/endpoints/api_eventos.dart';
import 'package:egresadoapp/api/endpoints/api_ofertas.dart';
import 'package:egresadoapp/api/endpoints/api_usuario.dart';
import 'package:flutter/material.dart';

// USUARIOS
Future<bool> puedeEditarRol(BuildContext? context) async {
  bool allowed = false;
  try {
    allowed = await ApiUsuario.canEditRol();
  } catch (e) {}
  // return allowed;
  return true;
}

// OFERTAS LABORALES
Future<bool> puedeCrearOferta(BuildContext? context) async {
  bool allowed = false;
  try {
    allowed = await ApiOfertas.canCreate();
  } catch (e) {}
  return allowed;
}

Future<bool> puedeEditarOferta(BuildContext? context) async {
  bool allowed = false;
  try {
    allowed = await ApiOfertas.canEdit();
  } catch (e) {}
  return allowed;
}

Future<bool> puedeEliminarOferta(BuildContext? context) async {
  bool allowed = false;
  try {
    allowed = await ApiOfertas.canDelete();
  } catch (e) {}
  return allowed;
}

// EVENTOS
Future<bool> puedeCrearEvento(BuildContext? context) async {
  bool allowed = false;
  try {
    allowed = await ApiEventos.canCreate();
  } catch (e) {}
  return allowed;
}

Future<bool> puedeEditarEvento(BuildContext? context) async {
  bool allowed = false;
  try {
    allowed = await ApiEventos.canEdit();
  } catch (e) {}
  return allowed;
}

Future<bool> puedeEliminarEvento(BuildContext? context) async {
  bool allowed = false;
  try {
    allowed = await ApiEventos.canDelete();
  } catch (e) {}
  return allowed;
}

// COLABORACIONES
Future<bool> puedeCrearColaboracion(BuildContext? context) async {
  bool allowed = false;
  try {
    allowed = await ApiColaboracion.canCreate();
  } catch (e) {}
  return allowed;
}

Future<bool> puedeEditarColaboracion(BuildContext? context) async {
  bool allowed = false;
  try {
    allowed = await ApiColaboracion.canEdit();
  } catch (e) {}
  return allowed;
}

Future<bool> puedeEliminarColaboracion(BuildContext? context) async {
  bool allowed = false;
  try {
    allowed = await ApiColaboracion.canDelete();
  } catch (e) {}
  return allowed;
}
