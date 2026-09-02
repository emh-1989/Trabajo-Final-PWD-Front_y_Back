from flask import request, jsonify
from flask_jwt_extended import get_jwt_identity
from routes.destinos.destinos_model import DestinoModel
from routes.auth.auth_model import UsuarioModel


def verificar_admin(id_usuario):
    usuario = UsuarioModel.obtener_por_id(int(id_usuario))
    return usuario and usuario.rol == 'admin'


def controller_obtener_destinos():
    destinos = DestinoModel.obtener_todos()
    return jsonify([d.serializar() for d in destinos]), 200


def controller_crear_destino():
    id_usuario = get_jwt_identity()
    if not verificar_admin(id_usuario):
        return jsonify({'message': 'Acceso denegado.'}), 403

    datos = request.get_json()
    titulo = datos.get('titulo')
    emoji = datos.get('emoji')
    imagen = datos.get('imagen')
    descripcion = datos.get('descripcion')
    paisajes = datos.get('paisajes')
    comida = datos.get('comida')
    tips = datos.get('tips', [])
    orden = datos.get('orden', 0)

    if not titulo or not emoji or not imagen or not descripcion:
        return jsonify({'message': 'Faltan campos obligatorios.'}), 400

    destino = DestinoModel.crear(titulo, emoji, imagen, descripcion, paisajes, comida, tips, orden)
    return jsonify(destino.serializar()), 201


def controller_actualizar_destino(id):
    id_usuario = get_jwt_identity()
    if not verificar_admin(id_usuario):
        return jsonify({'message': 'Acceso denegado.'}), 403

    destino = DestinoModel.obtener_por_id(id)
    if not destino:
        return jsonify({'message': 'Destino no encontrado.'}), 404

    datos = request.get_json()
    titulo = datos.get('titulo', destino.titulo)
    emoji = datos.get('emoji', destino.emoji)
    imagen = datos.get('imagen', destino.imagen)
    descripcion = datos.get('descripcion', destino.descripcion)
    paisajes = datos.get('paisajes', destino.paisajes)
    comida = datos.get('comida', destino.comida)
    tips = datos.get('tips', destino.tips)
    orden = datos.get('orden', destino.orden)

    destino = DestinoModel.actualizar(id, titulo, emoji, imagen, descripcion, paisajes, comida, tips, orden)
    return jsonify(destino.serializar()), 200


def controller_eliminar_destino(id):
    id_usuario = get_jwt_identity()
    if not verificar_admin(id_usuario):
        return jsonify({'message': 'Acceso denegado.'}), 403

    destino = DestinoModel.obtener_por_id(id)
    if not destino:
        return jsonify({'message': 'Destino no encontrado.'}), 404

    DestinoModel.eliminar(id)
    return jsonify({'message': 'Destino eliminado.'}), 200