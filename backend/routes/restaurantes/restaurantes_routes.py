from flask import Blueprint
from routes.restaurantes.restaurantes_controller import (
    controller_obtener_restaurantes,
    controller_obtener_restaurante,
    controller_buscar_restaurantes
)

restaurantes_bp = Blueprint('restaurantes', __name__)

@restaurantes_bp.route('/', methods=['GET'])
def obtener_restaurantes():
    return controller_obtener_restaurantes()

@restaurantes_bp.route('/<int:id>', methods=['GET'])
def obtener_restaurante(id):
    return controller_obtener_restaurante(id)

@restaurantes_bp.route('/buscar', methods=['GET'])
def buscar_restaurantes():
    return controller_buscar_restaurantes()