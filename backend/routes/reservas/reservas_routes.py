from flask import Blueprint
from flask_jwt_extended import jwt_required
from routes.reservas.reservas_controller import (
    controller_obtener_reservas,
    controller_crear_reserva,
    controller_cancelar_reserva
)

reservas_bp = Blueprint('reservas', __name__)

@reservas_bp.route('/', methods=['GET'])
@jwt_required()
def obtener_reservas():
    return controller_obtener_reservas()

@reservas_bp.route('/', methods=['POST'])
@jwt_required()
def crear_reserva():
    return controller_crear_reserva()

@reservas_bp.route('/<int:id>', methods=['PUT'])
@jwt_required()
def cancelar_reserva(id):
    return controller_cancelar_reserva(id)