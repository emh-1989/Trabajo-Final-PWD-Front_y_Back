from database import get_connection

class FavoritoModel:

    def __init__(self, id=0, usuario_id=0, tipo="", referencia_id=0, nombre="", ubicacion=None, imagen=None, precio=None, rating=None, created_at=None):
        self.id = id
        self.usuario_id = usuario_id
        self.tipo = tipo
        self.referencia_id = referencia_id
        self.nombre = nombre
        self.ubicacion = ubicacion
        self.imagen = imagen
        self.precio = precio
        self.rating = rating
        self.created_at = created_at

    def serializar(self) -> dict:
        return {
            'id': self.id,
            'usuario_id': self.usuario_id,
            'tipo': self.tipo,
            'referencia_id': self.referencia_id,
            'nombre': self.nombre,
            'ubicacion': self.ubicacion,
            'imagen': self.imagen,
            'precio': float(self.precio) if self.precio else None,
            'rating': float(self.rating) if self.rating else None,
            'created_at': str(self.created_at)
        }

    @staticmethod
    def deserializar(data: dict):
        return FavoritoModel(
            id=data.get('id', 0),
            usuario_id=data.get('usuario_id', 0),
            tipo=data.get('tipo', ''),
            referencia_id=data.get('referencia_id', 0),
            nombre=data.get('nombre', ''),
            ubicacion=data.get('ubicacion'),
            imagen=data.get('imagen'),
            precio=data.get('precio'),
            rating=data.get('rating'),
            created_at=data.get('created_at')
        )

    @staticmethod
    def obtener_por_usuario(usuario_id):
        conn = get_connection()
        cursor = conn.cursor(dictionary=True)
        cursor.execute("""
            SELECT f.*,
                COALESCE(h.nombre, v.aerolinea, r.nombre, e.titulo) AS nombre,
                COALESCE(h.ubicacion, r.ubicacion, e.ubicacion) AS ubicacion,
                COALESCE(h.imagen, r.imagen, e.imagen) AS imagen,
                COALESCE(h.precio, r.precio) AS precio,
                COALESCE(h.rating, r.rating) AS rating
            FROM favoritos f
            LEFT JOIN hoteles h ON f.tipo = 'hotel' AND f.referencia_id = h.id
            LEFT JOIN vuelos v ON f.tipo = 'vuelo' AND f.referencia_id = v.id
            LEFT JOIN restaurantes r ON f.tipo = 'restaurante' AND f.referencia_id = r.id
            LEFT JOIN entretenimiento e ON f.tipo = 'entretenimiento' AND f.referencia_id = e.id
            WHERE f.usuario_id = %s
            ORDER BY f.created_at DESC
        """, (usuario_id,))
        data = cursor.fetchall()
        cursor.close()
        conn.close()
        return [FavoritoModel.deserializar(f) for f in data]

    @staticmethod
    def obtener_por_id(id):
        conn = get_connection()
        cursor = conn.cursor(dictionary=True)
        cursor.execute("SELECT * FROM favoritos WHERE id = %s", (id,))
        data = cursor.fetchone()
        cursor.close()
        conn.close()
        return FavoritoModel.deserializar(data) if data else None

    @staticmethod
    def existe(usuario_id, tipo, referencia_id):
        conn = get_connection()
        cursor = conn.cursor(dictionary=True)
        cursor.execute(
            "SELECT * FROM favoritos WHERE usuario_id = %s AND tipo = %s AND referencia_id = %s",
            (usuario_id, tipo, referencia_id)
        )
        data = cursor.fetchone()
        cursor.close()
        conn.close()
        return FavoritoModel.deserializar(data) if data else None

    @staticmethod
    def crear(usuario_id, tipo, referencia_id):
        conn = get_connection()
        cursor = conn.cursor()
        cursor.execute(
            "INSERT INTO favoritos (usuario_id, tipo, referencia_id) VALUES (%s, %s, %s)",
            (usuario_id, tipo, referencia_id)
        )
        conn.commit()
        id_nuevo = cursor.lastrowid
        cursor.close()
        conn.close()
        return FavoritoModel.obtener_por_id(id_nuevo)

    @staticmethod
    def eliminar(id):
        conn = get_connection()
        cursor = conn.cursor()
        cursor.execute("DELETE FROM favoritos WHERE id = %s", (id,))
        conn.commit()
        cursor.close()
        conn.close()