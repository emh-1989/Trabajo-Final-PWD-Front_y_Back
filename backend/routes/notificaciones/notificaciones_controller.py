from flask import request, jsonify
from flask_jwt_extended import get_jwt_identity
from routes.notificaciones.notificaciones_model import NotificacionModel

def controller_obtener_notificaciones():
    id_usuario = get_jwt_identity()
    notificaciones = NotificacionModel.obtener_por_usuario(int(id_usuario))
    return jsonify([n.serializar() for n in notificaciones]), 200

def controller_marcar_leida(id):
    id_usuario = get_jwt_identity()
    notificacion = NotificacionModel.obtener_por_id(id)

    if not notificacion:
        return jsonify({'message': 'Notificación no encontrada.'}), 404

    if notificacion.usuario_id != int(id_usuario):
        return jsonify({'message': 'No tenés permiso para modificar esta notificación.'}), 403

    NotificacionModel.marcar_leida(id)
    return jsonify({'message': 'Notificación marcada como leída.'}), 200

def controller_marcar_todas_leidas():
    id_usuario = get_jwt_identity()
    NotificacionModel.marcar_todas_leidas(int(id_usuario))
    return jsonify({'message': 'Todas las notificaciones marcadas como leídas.'}), 200

def controller_eliminar_notificacion(id):
    id_usuario = get_jwt_identity()
    notificacion = NotificacionModel.obtener_por_id(id)

    if not notificacion:
        return jsonify({'message': 'Notificación no encontrada.'}), 404

    if notificacion.usuario_id != int(id_usuario):
        return jsonify({'message': 'No tenés permiso para eliminar esta notificación.'}), 403

    NotificacionModel.eliminar(id)
    return jsonify({'message': 'Notificación eliminada.'}), 200