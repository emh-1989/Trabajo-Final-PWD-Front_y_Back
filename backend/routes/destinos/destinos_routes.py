from flask import Blueprint
from flask_jwt_extended import jwt_required
from routes.destinos.destinos_controller import (
    controller_obtener_destinos,
    controller_crear_destino,
    controller_actualizar_destino,
    controller_eliminar_destino,
)

destinos_bp = Blueprint('destinos', __name__)


@destinos_bp.route('/', methods=['GET'])
def obtener_destinos():
    return controller_obtener_destinos()


@destinos_bp.route('/', methods=['POST'])
@jwt_required()
def crear_destino():
    return controller_crear_destino()


@destinos_bp.route('/<int:id>', methods=['PUT'])
@jwt_required()
def actualizar_destino(id):
    return controller_actualizar_destino(id)


@destinos_bp.route('/<int:id>', methods=['DELETE'])
@jwt_required()
def eliminar_destino(id):
    return controller_eliminar_destino(id)