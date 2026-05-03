from flask import Blueprint
from flask_jwt_extended import jwt_required
from routes.auth.auth_controller import (
    controller_register,
    controller_login,
    controller_me,
    controller_actualizar_perfil,
    controller_cambiar_password,
    controller_actualizar_avatar,
    controller_solicitar_anfitrion
)

auth_bp = Blueprint('auth', __name__)

@auth_bp.route('/register', methods=['POST'])
def register():
    return controller_register()

@auth_bp.route('/login', methods=['POST'])
def login():
    return controller_login()

@auth_bp.route('/me', methods=['GET'])
@jwt_required()
def me():
    return controller_me()

@auth_bp.route('/perfil', methods=['PUT'])
@jwt_required()
def actualizar_perfil():
    return controller_actualizar_perfil()

@auth_bp.route('/password', methods=['PUT'])
@jwt_required()
def cambiar_password():
    return controller_cambiar_password()

@auth_bp.route('/avatar', methods=['PUT'])
@jwt_required()
def actualizar_avatar():
    return controller_actualizar_avatar()

@auth_bp.route('/solicitar-anfitrion', methods=['POST'])
@jwt_required()
def solicitar_anfitrion():
    return controller_solicitar_anfitrion()