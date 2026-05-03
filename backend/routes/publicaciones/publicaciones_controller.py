from flask import request, jsonify
from flask_jwt_extended import get_jwt_identity
from routes.publicaciones.publicaciones_model import PublicacionModel

def controller_obtener_mis_publicaciones():
    id_usuario = get_jwt_identity()
    publicaciones = PublicacionModel.obtener_por_usuario(int(id_usuario))
    return jsonify([p.serializar() for p in publicaciones]), 200

def controller_crear_publicacion():
    id_usuario = get_jwt_identity()
    datos = request.get_json()

    nombre = datos.get('nombre')
    tipo = datos.get('tipo')
    ubicacion = datos.get('ubicacion')
    destino = datos.get('destino', '')
    precio_noche = datos.get('precio_noche')
    descripcion = datos.get('descripcion', '')

    if not nombre or not tipo or not ubicacion or not precio_noche:
        return jsonify({'message': 'Faltan campos obligatorios.'}), 400

    publicacion = PublicacionModel.crear(
        int(id_usuario), nombre, tipo, ubicacion, destino, precio_noche, descripcion
    )
    return jsonify(publicacion.serializar()), 201

def controller_editar_publicacion(id):
    id_usuario = get_jwt_identity()
    publicacion = PublicacionModel.obtener_por_id(id)

    if not publicacion:
        return jsonify({'message': 'Publicación no encontrada.'}), 404

    if publicacion.usuario_id != int(id_usuario):
        return jsonify({'message': 'No tenés permiso para editar esta publicación.'}), 403

    datos = request.get_json()
    nombre = datos.get('nombre', publicacion.nombre)
    tipo = datos.get('tipo', publicacion.tipo)
    ubicacion = datos.get('ubicacion', publicacion.ubicacion)
    destino = datos.get('destino', publicacion.destino)
    precio_noche = datos.get('precio_noche', publicacion.precio_noche)
    descripcion = datos.get('descripcion', publicacion.descripcion)

    publicacion = PublicacionModel.actualizar(
        id, nombre, tipo, ubicacion, destino, precio_noche, descripcion
    )
    return jsonify(publicacion.serializar()), 200

def controller_eliminar_publicacion(id):
    id_usuario = get_jwt_identity()
    publicacion = PublicacionModel.obtener_por_id(id)

    if not publicacion:
        return jsonify({'message': 'Publicación no encontrada.'}), 404

    if publicacion.usuario_id != int(id_usuario):
        return jsonify({'message': 'No tenés permiso para eliminar esta publicación.'}), 403

    PublicacionModel.eliminar(id)
    return jsonify({'message': 'Publicación eliminada.'}), 200