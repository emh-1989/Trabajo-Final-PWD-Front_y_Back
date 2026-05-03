from flask import request, jsonify
from flask_jwt_extended import get_jwt_identity
from routes.admin.admin_model import AdminModel
from routes.auth.auth_model import UsuarioModel
from routes.publicaciones.publicaciones_model import PublicacionModel
from routes.notificaciones.notificaciones_model import NotificacionModel

def verificar_admin(id_usuario):
    usuario = UsuarioModel.obtener_por_id(int(id_usuario))
    return usuario and usuario.rol == 'admin'

def controller_obtener_publicaciones():
    id_usuario = get_jwt_identity()
    if not verificar_admin(id_usuario):
        return jsonify({'message': 'Acceso denegado.'}), 403
    publicaciones = AdminModel.obtener_todas_publicaciones()
    return jsonify(publicaciones), 200

def controller_aprobar_publicacion(id):
    id_usuario = get_jwt_identity()
    if not verificar_admin(id_usuario):
        return jsonify({'message': 'Acceso denegado.'}), 403

    publicacion = PublicacionModel.obtener_por_id(id)
    if not publicacion:
        return jsonify({'message': 'Publicación no encontrada.'}), 404

    AdminModel.aprobar_publicacion(id)

    # Notificar al propietario
    NotificacionModel.crear(
        publicacion.usuario_id,
        'publicacion_aprobada',
        f'Tu publicación "{publicacion.nombre}" fue aprobada.'
    )

    return jsonify({'message': 'Publicación aprobada.'}), 200

def controller_rechazar_publicacion(id):
    id_usuario = get_jwt_identity()
    if not verificar_admin(id_usuario):
        return jsonify({'message': 'Acceso denegado.'}), 403

    publicacion = PublicacionModel.obtener_por_id(id)
    if not publicacion:
        return jsonify({'message': 'Publicación no encontrada.'}), 404

    datos = request.get_json()
    motivo = datos.get('motivo', 'Sin motivo especificado.')

    AdminModel.rechazar_publicacion(id, motivo)

    # Notificar al propietario
    NotificacionModel.crear(
        publicacion.usuario_id,
        'publicacion_rechazada',
        f'Tu publicación "{publicacion.nombre}" fue rechazada. Motivo: {motivo}'
    )

    return jsonify({'message': 'Publicación rechazada.'}), 200

def controller_obtener_usuarios():
    id_usuario = get_jwt_identity()
    if not verificar_admin(id_usuario):
        return jsonify({'message': 'Acceso denegado.'}), 403
    usuarios = AdminModel.obtener_todos_usuarios()
    return jsonify(usuarios), 200

def controller_cambiar_rol(id):
    id_usuario = get_jwt_identity()
    if not verificar_admin(id_usuario):
        return jsonify({'message': 'Acceso denegado.'}), 403

    datos = request.get_json()
    rol = datos.get('rol')

    if rol not in ['viajero', 'anfitrion', 'admin']:
        return jsonify({'message': 'Rol inválido.'}), 400

    AdminModel.cambiar_rol(id, rol)
    usuario = UsuarioModel.obtener_por_id(id)
    return jsonify(usuario.serializar()), 200

def controller_eliminar_usuario(id):
    id_usuario = get_jwt_identity()
    if not verificar_admin(id_usuario):
        return jsonify({'message': 'Acceso denegado.'}), 403

    usuario = UsuarioModel.obtener_por_id(id)
    if not usuario:
        return jsonify({'message': 'Usuario no encontrado.'}), 404

    if usuario.rol == 'admin':
        return jsonify({'message': 'No podés eliminar un usuario admin.'}), 403

    AdminModel.eliminar_usuario(id)
    return jsonify({'message': 'Usuario eliminado.'}), 200