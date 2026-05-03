from flask import request, jsonify
from routes.vuelos.vuelos_model import VueloModel

def controller_obtener_vuelos():
    vuelos = VueloModel.obtener_todos()
    return jsonify([v.serializar() for v in vuelos]), 200

def controller_obtener_vuelo(id):
    vuelo = VueloModel.obtener_por_id(id)
    if not vuelo:
        return jsonify({'message': 'Vuelo no encontrado.'}), 404
    return jsonify(vuelo.serializar()), 200

def controller_buscar_vuelos():
    origen = request.args.get('origen')
    destino = request.args.get('destino')
    fecha_ida = request.args.get('fecha_ida')
    pasajeros = request.args.get('pasajeros')

    vuelos = VueloModel.buscar(origen, destino, fecha_ida, pasajeros)
    return jsonify([v.serializar() for v in vuelos]), 200