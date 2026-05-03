from flask import request, jsonify
from routes.entretenimiento.entretenimiento_model import EntretenimientoModel

def controller_obtener_entretenimiento():
    eventos = EntretenimientoModel.obtener_todos()
    return jsonify([e.serializar() for e in eventos]), 200

def controller_obtener_evento(id):
    evento = EntretenimientoModel.obtener_por_id(id)
    if not evento:
        return jsonify({'message': 'Evento no encontrado.'}), 404
    return jsonify(evento.serializar()), 200

def controller_buscar_entretenimiento():
    destino = request.args.get('destino')
    tipo = request.args.get('tipo')
    fecha = request.args.get('fecha')

    eventos = EntretenimientoModel.buscar(destino, tipo, fecha)
    return jsonify([e.serializar() for e in eventos]), 200