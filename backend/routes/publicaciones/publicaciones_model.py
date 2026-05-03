from database import get_connection

class PublicacionModel:

    def __init__(self, id=0, usuario_id=0, nombre="", tipo="hotel", ubicacion="", destino="", precio_noche=0.0, descripcion="", estado="pendiente", motivo_rechazo=None, created_at=None):
        self.id = id
        self.usuario_id = usuario_id
        self.nombre = nombre
        self.tipo = tipo
        self.ubicacion = ubicacion
        self.destino = destino
        self.precio_noche = precio_noche
        self.descripcion = descripcion
        self.estado = estado
        self.motivo_rechazo = motivo_rechazo
        self.created_at = created_at

    def serializar(self) -> dict:
        return {
            'id': self.id,
            'usuario_id': self.usuario_id,
            'nombre': self.nombre,
            'tipo': self.tipo,
            'ubicacion': self.ubicacion,
            'destino': self.destino,
            'precio_noche': float(self.precio_noche),
            'descripcion': self.descripcion,
            'estado': self.estado,
            'motivo_rechazo': self.motivo_rechazo,
            'created_at': str(self.created_at)
        }

    @staticmethod
    def deserializar(data: dict):
        return PublicacionModel(
            id=data.get('id', 0),
            usuario_id=data.get('usuario_id', 0),
            nombre=data.get('nombre', ''),
            tipo=data.get('tipo', 'hotel'),
            ubicacion=data.get('ubicacion', ''),
            destino=data.get('destino', ''),
            precio_noche=data.get('precio_noche', 0.0),
            descripcion=data.get('descripcion', ''),
            estado=data.get('estado', 'pendiente'),
            motivo_rechazo=data.get('motivo_rechazo'),
            created_at=data.get('created_at')
        )

    @staticmethod
    def obtener_por_usuario(usuario_id):
        conn = get_connection()
        cursor = conn.cursor(dictionary=True)
        cursor.execute(
            "SELECT * FROM publicaciones WHERE usuario_id = %s ORDER BY created_at DESC",
            (usuario_id,)
        )
        data = cursor.fetchall()
        cursor.close()
        conn.close()
        return [PublicacionModel.deserializar(p) for p in data]

    @staticmethod
    def obtener_todas():
        conn = get_connection()
        cursor = conn.cursor(dictionary=True)
        cursor.execute("SELECT * FROM publicaciones ORDER BY created_at DESC")
        data = cursor.fetchall()
        cursor.close()
        conn.close()
        return [PublicacionModel.deserializar(p) for p in data]

    @staticmethod
    def obtener_por_id(id):
        conn = get_connection()
        cursor = conn.cursor(dictionary=True)
        cursor.execute("SELECT * FROM publicaciones WHERE id = %s", (id,))
        data = cursor.fetchone()
        cursor.close()
        conn.close()
        return PublicacionModel.deserializar(data) if data else None

    @staticmethod
    def crear(usuario_id, nombre, tipo, ubicacion, destino, precio_noche, descripcion):
        conn = get_connection()
        cursor = conn.cursor()
        cursor.execute(
            "INSERT INTO publicaciones (usuario_id, nombre, tipo, ubicacion, destino, precio_noche, descripcion) VALUES (%s, %s, %s, %s, %s, %s, %s)",
            (usuario_id, nombre, tipo, ubicacion, destino, precio_noche, descripcion)
        )
        conn.commit()
        id_nuevo = cursor.lastrowid
        cursor.close()
        conn.close()
        return PublicacionModel.obtener_por_id(id_nuevo)

    @staticmethod
    def actualizar(id, nombre, tipo, ubicacion, destino, precio_noche, descripcion):
        conn = get_connection()
        cursor = conn.cursor()
        cursor.execute(
            "UPDATE publicaciones SET nombre=%s, tipo=%s, ubicacion=%s, destino=%s, precio_noche=%s, descripcion=%s WHERE id=%s",
            (nombre, tipo, ubicacion, destino, precio_noche, descripcion, id)
        )
        conn.commit()
        cursor.close()
        conn.close()
        return PublicacionModel.obtener_por_id(id)

    @staticmethod
    def actualizar_estado(id, estado, motivo_rechazo=None):
        conn = get_connection()
        cursor = conn.cursor()
        cursor.execute(
            "UPDATE publicaciones SET estado=%s, motivo_rechazo=%s WHERE id=%s",
            (estado, motivo_rechazo, id)
        )
        conn.commit()
        cursor.close()
        conn.close()

    @staticmethod
    def eliminar(id):
        conn = get_connection()
        cursor = conn.cursor()
        cursor.execute("DELETE FROM publicaciones WHERE id = %s", (id,))
        conn.commit()
        cursor.close()
        conn.close()