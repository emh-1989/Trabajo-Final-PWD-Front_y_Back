from flask import Blueprint
from routes.entretenimiento.entretenimiento_controller import (
    controller_obtener_entretenimiento,
    controller_obtener_evento,
    controller_buscar_entretenimiento
)

entretenimiento_bp = Blueprint('entretenimiento', __name__)

@entretenimiento_bp.route('/', methods=['GET'])
def obtener_entretenimiento():
    return controller_obtener_entretenimiento()

@entretenimiento_bp.route('/<int:id>', methods=['GET'])
def obtener_evento(id):
    return controller_obtener_evento(id)

@entretenimiento_bp.route('/buscar', methods=['GET'])
def buscar_entretenimiento():
    return controller_buscar_entretenimiento()