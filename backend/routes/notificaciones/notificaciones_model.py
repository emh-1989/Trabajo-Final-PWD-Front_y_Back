from database import get_connection

class NotificacionModel:

    def __init__(self, id=0, usuario_id=0, tipo="", mensaje="", leida=False, created_at=None):
        self.id = id
        self.usuario_id = usuario_id
        self.tipo = tipo
        self.mensaje = mensaje
        self.leida = leida
        self.created_at = created_at

    def serializar(self) -> dict:
        return {
            'id': self.id,
            'usuario_id': self.usuario_id,
            'tipo': self.tipo,
            'mensaje': self.mensaje,
            'leida': bool(self.leida),
            'created_at': str(self.created_at)
        }

    @staticmethod
    def deserializar(data: dict):
        return NotificacionModel(
            id=data.get('id', 0),
            usuario_id=data.get('usuario_id', 0),
            tipo=data.get('tipo', ''),
            mensaje=data.get('mensaje', ''),
            leida=data.get('leida', False),
            created_at=data.get('created_at')
        )

    @staticmethod
    def obtener_por_usuario(usuario_id):
        conn = get_connection()
        cursor = conn.cursor(dictionary=True)
        cursor.execute(
            "SELECT * FROM notificaciones WHERE usuario_id = %s ORDER BY created_at DESC",
            (usuario_id,)
        )
        data = cursor.fetchall()
        cursor.close()
        conn.close()
        return [NotificacionModel.deserializar(n) for n in data]

    @staticmethod
    def obtener_por_id(id):
        conn = get_connection()
        cursor = conn.cursor(dictionary=True)
        cursor.execute("SELECT * FROM notificaciones WHERE id = %s", (id,))
        data = cursor.fetchone()
        cursor.close()
        conn.close()
        return NotificacionModel.deserializar(data) if data else None

    @staticmethod
    def crear(usuario_id, tipo, mensaje):
        conn = get_connection()
        cursor = conn.cursor()
        cursor.execute(
            "INSERT INTO notificaciones (usuario_id, tipo, mensaje) VALUES (%s, %s, %s)",
            (usuario_id, tipo, mensaje)
        )
        conn.commit()
        id_nuevo = cursor.lastrowid
        cursor.close()
        conn.close()
        return NotificacionModel.obtener_por_id(id_nuevo)

    @staticmethod
    def marcar_leida(id):
        conn = get_connection()
        cursor = conn.cursor()
        cursor.execute(
            "UPDATE notificaciones SET leida = TRUE WHERE id = %s",
            (id,)
        )
        conn.commit()
        cursor.close()
        conn.close()

    @staticmethod
    def marcar_todas_leidas(usuario_id):
        conn = get_connection()
        cursor = conn.cursor()
        cursor.execute(
            "UPDATE notificaciones SET leida = TRUE WHERE usuario_id = %s",
            (usuario_id,)
        )
        conn.commit()
        cursor.close()
        conn.close()

    @staticmethod
    def eliminar(id):
        conn = get_connection()
        cursor = conn.cursor()
        cursor.execute("DELETE FROM notificaciones WHERE id = %s", (id,))
        conn.commit()
        cursor.close()
        conn.close()