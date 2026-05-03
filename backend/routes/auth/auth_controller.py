from flask import request, jsonify
from flask_jwt_extended import create_access_token, get_jwt_identity
from werkzeug.security import generate_password_hash, check_password_hash
from routes.auth.auth_model import UsuarioModel

def controller_register():
    datos = request.get_json()
    nombre = datos.get('nombre')
    email = datos.get('email')
    password = datos.get('password')

    if not nombre or not email or not password:
        return jsonify({'message': 'Todos los campos son obligatorios.'}), 400

    if UsuarioModel.obtener_por_email(email):
        return jsonify({'message': 'El email ya está registrado.'}), 400

    password_hash = generate_password_hash(password)
    usuario = UsuarioModel.crear(nombre, email, password_hash)
    token = create_access_token(identity=str(usuario.id))

    return jsonify({'token': token, 'usuario': usuario.serializar()}), 201


def controller_login():
    datos = request.get_json()
    email = datos.get('email')
    password = datos.get('password')

    if not email or not password:
        return jsonify({'message': 'Email y contraseña son obligatorios.'}), 400

    usuario = UsuarioModel.obtener_por_email(email)
    if not usuario or not check_password_hash(usuario.password, password):
        return jsonify({'message': 'Email o contraseña incorrectos.'}), 401

    token = create_access_token(identity=str(usuario.id))
    return jsonify({'token': token, 'usuario': usuario.serializar()}), 200


def controller_me():
    id_usuario = get_jwt_identity()
    usuario = UsuarioModel.obtener_por_id(int(id_usuario))
    if not usuario:
        return jsonify({'message': 'Usuario no encontrado.'}), 404
    return jsonify(usuario.serializar()), 200


def controller_actualizar_perfil():
    id_usuario = get_jwt_identity()
    datos = request.get_json()
    nombre = datos.get('nombre')
    email = datos.get('email')

    if not nombre or not email:
        return jsonify({'message': 'Nombre y email son obligatorios.'}), 400

    UsuarioModel.actualizar_perfil(int(id_usuario), nombre, email)
    usuario = UsuarioModel.obtener_por_id(int(id_usuario))
    return jsonify(usuario.serializar()), 200


def controller_cambiar_password():
    id_usuario = get_jwt_identity()
    datos = request.get_json()
    pass_actual = datos.get('passActual')
    pass_nueva = datos.get('passNueva')

    if not pass_actual or not pass_nueva:
        return jsonify({'message': 'Todos los campos son obligatorios.'}), 400

    usuario = UsuarioModel.obtener_por_id(int(id_usuario))
    usuario_con_pass = UsuarioModel.obtener_por_email(usuario.email)

    if not check_password_hash(usuario_con_pass.password, pass_actual):
        return jsonify({'message': 'La contraseña actual es incorrecta.'}), 401

    UsuarioModel.actualizar_password(int(id_usuario), generate_password_hash(pass_nueva))
    return jsonify({'message': 'Contraseña actualizada.'}), 200


def controller_actualizar_avatar():
    id_usuario = get_jwt_identity()
    datos = request.get_json()
    url = datos.get('url')

    if not url:
        return jsonify({'message': 'La URL es obligatoria.'}), 400

    UsuarioModel.actualizar_avatar(int(id_usuario), url)
    return jsonify({'message': 'Avatar actualizado.'}), 200


def controller_solicitar_anfitrion():
    id_usuario = get_jwt_identity()
    UsuarioModel.actualizar_rol(int(id_usuario), 'anfitrion')
    usuario = UsuarioModel.obtener_por_id(int(id_usuario))
    return jsonify(usuario.serializar()), 200