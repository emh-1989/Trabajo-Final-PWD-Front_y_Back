from flask import request, jsonify
from flask_jwt_extended import get_jwt_identity
from routes.hoteles.hoteles_model import HotelModel

def controller_obtener_hoteles():
    hoteles = HotelModel.obtener_todos()
    return jsonify([h.serializar() for h in hoteles]), 200

def controller_obtener_hotel(id):
    hotel = HotelModel.obtener_por_id(id)
    if not hotel:
        return jsonify({'message': 'Hotel no encontrado.'}), 404
    return jsonify(hotel.serializar()), 200

def controller_buscar_hoteles():
    destino = request.args.get('destino')
    checkin = request.args.get('checkin')
    checkout = request.args.get('checkout')
    pasajeros = request.args.get('pasajeros')

    hoteles = HotelModel.buscar(destino, checkin, checkout, pasajeros)
    return jsonify([h.serializar() for h in hoteles]), 200

def controller_crear_hotel():
    id_usuario = get_jwt_identity()
    datos = request.get_json()

    nombre = datos.get('nombre')
    ubicacion = datos.get('ubicacion')
    descripcion = datos.get('descripcion', '')
    precio = datos.get('precio')
    tipo = datos.get('tipo')
    imagen = datos.get('imagen', '')

    if not nombre or not ubicacion or not precio or not tipo:
        return jsonify({'message': 'Faltan campos obligatorios.'}), 400

    hotel = HotelModel.crear(nombre, ubicacion, descripcion, precio, tipo, imagen, int(id_usuario))
    return jsonify(hotel.serializar()), 201

def controller_eliminar_hotel(id):
    hotel = HotelModel.obtener_por_id(id)
    if not hotel:
        return jsonify({'message': 'Hotel no encontrado.'}), 404
    HotelModel.eliminar(id)
    return jsonify({'message': 'Hotel eliminado.'}), 200