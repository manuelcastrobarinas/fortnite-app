import 'dart:async';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/services.dart';

class CustomApiErrors implements Exception {
  final String message;

  CustomApiErrors(this.message);

  @override
  String toString() {
    return message;
  }

  factory CustomApiErrors.fromError(dynamic error) {
    if (error is TimeoutException)  return CustomApiErrors('TimeOut: could not obtain the resource. ${error.toString()}');
    if (error is PlatformException) return CustomApiErrors(error.message ?? '@Algo esta mal con la plataforma. ${error.toString()}');
    if (error is FormatException)   return CustomApiErrors('@Error en el formato. ${error.toString()}');
    if (error is SocketException)   return CustomApiErrors('@Socket Error. ${error.toString()}');
    if (error is DioException) {
      if (error.type == DioExceptionType.connectionTimeout) return CustomApiErrors('Tiempo de espera de conexion: no se ´pudo establecer la conexión con el servidor');
      if (error.type == DioExceptionType.sendTimeout)       return CustomApiErrors('Hubo un problema al enviar la solicitud al servidor. Por favor, intentarlo de nuevo');
      if (error.type == DioExceptionType.receiveTimeout)    return CustomApiErrors('Recibir tiempo de espera: Se Ha excedido el tiempo de espera para recibir la respuesta del servidor. Porfavor inténtalo mas tarde.');
      if (error.error is TimeoutException)  return CustomApiErrors('No se pudieron obtener el recurso debido  a un problema de tiempo de espera. Por favor, verificar la conexion a internet y vuelve a intentarlo.');
      if (error.error is PlatformException) return CustomApiErrors('Algo salió mal al intentar obtener el recurso. Porfavor, intentalo mas tarde.');
      if (error.error is FormatException)   return CustomApiErrors('Se produjo un error al procesar los datos del recurso. Por favor, inténtalo más tarde.');
      if (error.error is SocketException)   return CustomApiErrors('Ha ocurrido un problema de conexión. Verifica tu conexión a internet e intenta nuevamente.');
      if (error.response != null && (error.response!.statusCode == 400 || error.response?.statusCode == 500)) return CustomApiErrors(error.response!.data['error_message'].toString());
      if (error.response?.statusCode == 404)  return CustomApiErrors('El recurso que estás buscando no se ha encontrado en el servidor. Verifica la información e inténtalo nuevamente. ${error.response?.statusMessage.toString()}');
      if (error.type == DioExceptionType.badResponse) return CustomApiErrors('Ha ocurrido un error al procesar la respuesta del servidor. Por favor, inténtalo más tarde. ${error.message.toString()}');
      if (error.type == DioExceptionType.unknown)     return CustomApiErrors('Se ha producido un error intesperado. Por favor, inténtalo nuevamente. ${error.message.toString()}');
      if (error.type == DioExceptionType.cancel)      return CustomApiErrors('La solicitud ha sido cancelada. Por favor, intentalo nuevamente. ${error.message.toString()}');
    }
    return CustomApiErrors('@Error obteniendo el recurso. ${error.toString()}');
  }
}