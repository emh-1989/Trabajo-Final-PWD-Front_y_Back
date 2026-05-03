from flask import Blueprint
from flask_jwt_extended import jwt_required
from routes.hoteles.hoteles_controller import (
    controller_obtener_hoteles,
    controller_obtener_hotel,
    controller_buscar_hoteles,
    controller_crear_hotel,
    controller_eliminar_hotel
)

hoteles_bp = Blueprint('hoteles', __name__)

@hoteles_bp.route('/', methods=['GET'])
def obtener_hoteles():
    return controller_obtener_hoteles()

@hoteles_bp.route('/<int:id>', methods=['GET'])
def obtener_hotel(id):
    return controller_obtener_hotel(id)

@hoteles_bp.route('/buscar', methods=['GET'])
def buscar_hoteles():
    return controller_buscar_hoteles()

@hoteles_bp.route('/', methods=['POST'])
@jwt_required()
def crear_hotel():
    return controller_crear_hotel()

@hoteles_bp.route('/<int:id>', methods=['DELETE'])
@jwt_required()
def eliminar_hotel(id):
    return controller_eliminar_hotel(id)