from flask import Blueprint
from flask_jwt_extended import jwt_required
from routes.admin.admin_controller import (
    controller_obtener_publicaciones,
    controller_aprobar_publicacion,
    controller_rechazar_publicacion,
    controller_obtener_usuarios,
    controller_cambiar_rol,
    controller_eliminar_usuario
)

admin_bp = Blueprint('admin', __name__)

@admin_bp.route('/publicaciones', methods=['GET'])
@jwt_required()
def obtener_publicaciones():
    return controller_obtener_publicaciones()

@admin_bp.route('/publicaciones/<int:id>', methods=['PUT'])
@jwt_required()
def aprobar_rechazar_publicacion(id):
    from flask import request
    datos = request.get_json()
    accion = datos.get('accion')
    if accion == 'aprobar':
        return controller_aprobar_publicacion(id)
    elif accion == 'rechazar':
        return controller_rechazar_publicacion(id)
    else:
        from flask import jsonify
        return jsonify({'message': 'Acción inválida.'}), 400

@admin_bp.route('/usuarios', methods=['GET'])
@jwt_required()
def obtener_usuarios():
    return controller_obtener_usuarios()

@admin_bp.route('/usuarios/<int:id>', methods=['PUT'])
@jwt_required()
def cambiar_rol(id):
    return controller_cambiar_rol(id)

@admin_bp.route('/usuarios/<int:id>', methods=['DELETE'])
@jwt_required()
def eliminar_usuario(id):
    return controller_eliminar_usuario(id)