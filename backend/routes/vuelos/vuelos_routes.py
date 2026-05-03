from flask import Blueprint
from routes.vuelos.vuelos_controller import (
    controller_obtener_vuelos,
    controller_obtener_vuelo,
    controller_buscar_vuelos
)

vuelos_bp = Blueprint('vuelos', __name__)

@vuelos_bp.route('/', methods=['GET'])
def obtener_vuelos():
    return controller_obtener_vuelos()

@vuelos_bp.route('/<int:id>', methods=['GET'])
def obtener_vuelo(id):
    return controller_obtener_vuelo(id)

@vuelos_bp.route('/buscar', methods=['GET'])
def buscar_vuelos():
    return controller_buscar_vuelos()