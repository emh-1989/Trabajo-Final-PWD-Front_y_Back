from flask import Flask
from flask_cors import CORS
from flask_jwt_extended import JWTManager
from config import Config

from routes.auth.auth_routes import auth_bp
from routes.hoteles.hoteles_routes import hoteles_bp
from routes.reservas.reservas_routes import reservas_bp
from routes.favoritos.favoritos_routes import favoritos_bp
from routes.publicaciones.publicaciones_routes import publicaciones_bp
from routes.notificaciones.notificaciones_routes import notificaciones_bp
from routes.vuelos.vuelos_routes import vuelos_bp
from routes.restaurantes.restaurantes_routes import restaurantes_bp
from routes.entretenimiento.entretenimiento_routes import entretenimiento_bp
from routes.admin.admin_routes import admin_bp

def create_app():
    app = Flask(__name__)
    app.config.from_object(Config)

    # CORS — permite requests desde el front en Vue
    CORS(app, resources={r"/api/*": {"origins": "http://localhost:5173"}})

    # JWT
    JWTManager(app)

    # Registrar blueprints
    app.register_blueprint(auth_bp,            url_prefix='/api/auth')
    app.register_blueprint(hoteles_bp,         url_prefix='/api/hoteles')
    app.register_blueprint(reservas_bp,        url_prefix='/api/reservas')
    app.register_blueprint(favoritos_bp,       url_prefix='/api/favoritos')
    app.register_blueprint(publicaciones_bp,   url_prefix='/api/publicaciones')
    app.register_blueprint(notificaciones_bp,  url_prefix='/api/notificaciones')
    app.register_blueprint(vuelos_bp,          url_prefix='/api/vuelos')
    app.register_blueprint(restaurantes_bp,    url_prefix='/api/restaurantes')
    app.register_blueprint(entretenimiento_bp, url_prefix='/api/entretenimiento')
    app.register_blueprint(admin_bp,           url_prefix='/api/admin')

    return app

if __name__ == '__main__':
    app = create_app()
    app.run(debug=True, port=5000)