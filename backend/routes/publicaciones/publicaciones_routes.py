from flask import Blueprint
from flask_jwt_extended import jwt_required
from routes.publicaciones.publicaciones_controller import (
    controller_obtener_mis_publicaciones,
    controller_crear_publicacion,
    controller_editar_publicacion,
    controller_eliminar_publicacion
)

publicaciones_bp = Blueprint('publicaciones', __name__)

@publicaciones_bp.route('/mias', methods=['GET'])
@jwt_required()
def obtener_mis_publicaciones():
    return controller_obtener_mis_publicaciones()

@publicaciones_bp.route('/', methods=['POST'])
@jwt_required()
def crear_publicacion():
    return controller_crear_publicacion()

@publicaciones_bp.route('/<int:id>', methods=['PUT'])
@jwt_required()
def editar_publicacion(id):
    return controller_editar_publicacion(id)

@publicaciones_bp.route('/<int:id>', methods=['DELETE'])
@jwt_required()
def eliminar_publicacion(id):
    return controller_eliminar_publicacion(id)