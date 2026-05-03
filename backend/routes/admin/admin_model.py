from database import get_connection
from routes.publicaciones.publicaciones_model import PublicacionModel
from routes.auth.auth_model import UsuarioModel

class AdminModel:

    @staticmethod
    def obtener_todas_publicaciones():
        conn = get_connection()
        cursor = conn.cursor(dictionary=True)
        cursor.execute("""
            SELECT p.*, u.nombre AS propietario, u.email AS propietario_email
            FROM publicaciones p
            JOIN usuarios u ON p.usuario_id = u.id
            ORDER BY p.created_at DESC
        """)
        data = cursor.fetchall()
        cursor.close()
        conn.close()
        resultado = []
        for row in data:
            pub = PublicacionModel.deserializar(row)
            resultado.append({
                **pub.serializar(),
                'propietario': row['propietario'],
                'propietario_email': row['propietario_email'],
                'propietario_id': row['usuario_id']
            })
        return resultado

    @staticmethod
    def aprobar_publicacion(id):
        conn = get_connection()
        cursor = conn.cursor()
        cursor.execute(
            "UPDATE publicaciones SET estado = 'publicado', motivo_rechazo = NULL WHERE id = %s",
            (id,)
        )
        conn.commit()
        cursor.close()
        conn.close()

    @staticmethod
    def rechazar_publicacion(id, motivo):
        conn = get_connection()
        cursor = conn.cursor()
        cursor.execute(
            "UPDATE publicaciones SET estado = 'rechazado', motivo_rechazo = %s WHERE id = %s",
            (motivo, id)
        )
        conn.commit()
        cursor.close()
        conn.close()

    @staticmethod
    def obtener_todos_usuarios():
        conn = get_connection()
        cursor = conn.cursor(dictionary=True)
        cursor.execute("""
            SELECT u.*,
                COUNT(DISTINCT p.id) AS publicaciones,
                COUNT(DISTINCT r.id) AS reservas
            FROM usuarios u
            LEFT JOIN publicaciones p ON u.id = p.usuario_id
            LEFT JOIN reservas r ON u.id = r.usuario_id
            GROUP BY u.id
            ORDER BY u.created_at DESC
        """)
        data = cursor.fetchall()
        cursor.close()
        conn.close()
        resultado = []
        for row in data:
            usuario = UsuarioModel.deserializar(row)
            resultado.append({
                **usuario.serializar(),
                'publicaciones': row['publicaciones'],
                'reservas': row['reservas']
            })
        return resultado

    @staticmethod
    def cambiar_rol(id, rol):
        conn = get_connection()
        cursor = conn.cursor()
        cursor.execute(
            "UPDATE usuarios SET rol = %s WHERE id = %s",
            (rol, id)
        )
        conn.commit()
        cursor.close()
        conn.close()

    @staticmethod
    def eliminar_usuario(id):
        conn = get_connection()
        cursor = conn.cursor()
        cursor.execute("DELETE FROM usuarios WHERE id = %s", (id,))
        conn.commit()
        cursor.close()
        conn.close()