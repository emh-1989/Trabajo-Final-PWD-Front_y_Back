from flask import request, jsonify
from routes.restaurantes.restaurantes_model import RestauranteModel

def controller_obtener_restaurantes():
    restaurantes = RestauranteModel.obtener_todos()
    return jsonify([r.serializar() for r in restaurantes]), 200

def controller_obtener_restaurante(id):
    restaurante = RestauranteModel.obtener_por_id(id)
    if not restaurante:
        return jsonify({'message': 'Restaurante no encontrado.'}), 404
    return jsonify(restaurante.serializar()), 200

def controller_buscar_restaurantes():
    destino = request.args.get('destino')
    tipo = request.args.get('tipo')

    restaurantes = RestauranteModel.buscar(destino, tipo)
    return jsonify([r.serializar() for r in restaurantes]), 200