from flask import Blueprint
from flask_jwt_extended import jwt_required
from routes.favoritos.favoritos_controller import (
    controller_obtener_favoritos,
    controller_agregar_favorito,
    controller_quitar_favorito
)

favoritos_bp = Blueprint('favoritos', __name__)
favoritos_bp.strict_slashes = False

@favoritos_bp.route('', methods=['GET'])
@jwt_required()
def obtener_favoritos():
    return controller_obtener_favoritos()

@favoritos_bp.route('', methods=['POST'])
@jwt_required()
def agregar_favorito():
    return controller_agregar_favorito()

@favoritos_bp.route('/<int:id>', methods=['DELETE'])
@jwt_required()
def quitar_favorito(id):
    return controller_quitar_favorito(id)