from flask import request, jsonify
from flask_jwt_extended import get_jwt_identity
from routes.reservas.reservas_model import ReservaModel

def controller_obtener_reservas():
    id_usuario = get_jwt_identity()
    reservas = ReservaModel.obtener_por_usuario(int(id_usuario))
    return jsonify([r.serializar() for r in reservas]), 200

def controller_crear_reserva():
    id_usuario = get_jwt_identity()
    datos = request.get_json()

    hotel_id = datos.get('hotel_id')
    vuelo_id = datos.get('vuelo_id')
    fecha_entrada = datos.get('fecha_entrada')
    fecha_salida = datos.get('fecha_salida')

    if not hotel_id and not vuelo_id:
        return jsonify({'message': 'La reserva debe incluir al menos un hotel o un vuelo.'}), 400

    reserva = ReservaModel.crear(
        usuario_id=int(id_usuario),
        hotel_id=hotel_id,
        vuelo_id=vuelo_id,
        fecha_entrada=fecha_entrada,
        fecha_salida=fecha_salida
    )
    return jsonify(reserva.serializar()), 201

def controller_cancelar_reserva(id):
    id_usuario = get_jwt_identity()
    reserva = ReservaModel.obtener_por_id(id)

    if not reserva:
        return jsonify({'message': 'Reserva no encontrada.'}), 404

    if reserva.usuario_id != int(id_usuario):
        return jsonify({'message': 'No tenés permiso para cancelar esta reserva.'}), 403

    ReservaModel.actualizar_estado(id, 'cancelada')
    reserva.estado = 'cancelada'
    return jsonify(reserva.serializar()), 200