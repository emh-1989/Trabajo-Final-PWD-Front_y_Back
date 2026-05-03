from flask import request, jsonify
from flask_jwt_extended import get_jwt_identity
from routes.favoritos.favoritos_model import FavoritoModel

def controller_obtener_favoritos():
    id_usuario = get_jwt_identity()
    favoritos = FavoritoModel.obtener_por_usuario(int(id_usuario))
    return jsonify([f.serializar() for f in favoritos]), 200

def controller_agregar_favorito():
    id_usuario = get_jwt_identity()
    datos = request.get_json()

    tipo = datos.get('tipo')
    referencia_id = datos.get('referencia_id')

    if not tipo or not referencia_id:
        return jsonify({'message': 'Tipo y referencia_id son obligatorios.'}), 400

    if FavoritoModel.existe(int(id_usuario), tipo, referencia_id):
        return jsonify({'message': 'Ya está en favoritos.'}), 400

    favorito = FavoritoModel.crear(int(id_usuario), tipo, referencia_id)
    return jsonify(favorito.serializar()), 201

def controller_quitar_favorito(id):
    id_usuario = get_jwt_identity()
    favorito = FavoritoModel.obtener_por_id(id)

    if not favorito:
        return jsonify({'message': 'Favorito no encontrado.'}), 404

    if favorito.usuario_id != int(id_usuario):
        return jsonify({'message': 'No tenés permiso para eliminar este favorito.'}), 403

    FavoritoModel.eliminar(id)
    return jsonify({'message': 'Favorito eliminado.'}), 200