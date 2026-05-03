from flask import Blueprint
from flask_jwt_extended import jwt_required
from routes.notificaciones.notificaciones_controller import (
    controller_obtener_notificaciones,
    controller_marcar_leida,
    controller_marcar_todas_leidas,
    controller_eliminar_notificacion
)

notificaciones_bp = Blueprint('notificaciones', __name__)

@notificaciones_bp.route('/', methods=['GET'])
@jwt_required()
def obtener_notificaciones():
    return controller_obtener_notificaciones()

@notificaciones_bp.route('/<int:id>', methods=['PUT'])
@jwt_required()
def marcar_leida(id):
    return controller_marcar_leida(id)

@notificaciones_bp.route('/leer-todas', methods=['PUT'])
@jwt_required()
def marcar_todas_leidas():
    return controller_marcar_todas_leidas()

@notificaciones_bp.route('/<int:id>', methods=['DELETE'])
@jwt_required()
def eliminar_notificacion(id):
    return controller_eliminar_notificacion(id)