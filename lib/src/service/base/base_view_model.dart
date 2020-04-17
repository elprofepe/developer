import 'package:flutter/services.dart';

class BaseViewModel {
  static dynamic errorMap(onError) {
    try {
      print("---...---...---\n${(onError as PlatformException).code}\n---...---...---");
      switch ((onError as PlatformException).code) {
        case 'ERROR_USER_NOT_FOUND': return [10, 'Correo no encontrado'];
          break;
        case 'ERROR_WRONG_PASSWORD': return [10, 'Contraseña no encontrado'];
          break;
        case 'ERROR_INVALID_EMAIL': return [10, 'Correo no encontrado'];
          break;
        case 'ERROR_NOT_AUTHORIZED': return [10, 'El usuario no está autorizado para realizar la acción deseada. Consulta las reglas para asegurarte de que sean correctas'];
          break;
        case 'ERROR_NOT_AUTHENTICATED': return [10, 'El usuario no se autenticó. Vuelve a intentarlo después de realizar la autenticación'];
          break;
        case 'ERROR_RETRY_LIMIT_EXCEEDED': return [10, 'Se superó el límite de tiempo máximo permitido para una operación (de carga, descarga, eliminación, etc.). Vuelve a intentarlo'];
          break;
        case 'ERROR_INVALID_CHECKSUM': return [10, 'El archivo del cliente no coincide con la suma de verificación del archivo que recibió el servidor. Vuelve a subirlo'];
          break;
        case 'ERROR_CANCELED': return [10, 'El usuario canceló la operación'];
          break;
        case 'ERROR_QUOTA_EXCEEDED': return [10, 'Se superó la cuota del depósito de Cloud Storage. Si estás en el nivel gratuito, deberás actualizar a un plan pago. Si estás en un plan pagado, comunícate con el personal de asistencia de Firebase'];
          break;
        case 'ERROR_OBJECT_NOT_FOUND': return [10, 'No existe ningún objeto en la referencia deseada'];
          break;
        case 'ERROR_BUCKET_NOT_FOUND': return [10, 'No se configuró ningún depósito para Cloud Storage'];
          break;
        case 'ERROR_PROJECT_NOT_FOUND': return [10, 'No se configuró ningún proyecto para Cloud Storage'];
          break;
        case 'ERROR_UNKNOWN': return [10, 'Hubo un error desconocido'];
          break;
        case 'ERROR_NETWORK_REQUEST_FAILED': return [10, 'Conexión inestable'];
          break;
        default: return [10, "Vuelva a intentarlo más tarde"];
      }
    } catch(e) {
        print("---.........---\n$onError\n---.........---");
        return [11, "Error Desconocido"];
    }
  }
}