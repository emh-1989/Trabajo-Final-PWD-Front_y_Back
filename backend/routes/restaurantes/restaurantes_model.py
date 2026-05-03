from database import get_connection

class RestauranteModel:

    def __init__(self, id=0, nombre="", ubicacion="", tipo="", precio=0.0, rating=0.0, imagen="", created_at=None):
        self.id = id
        self.nombre = nombre
        self.ubicacion = ubicacion
        self.tipo = tipo
        self.precio = precio
        self.rating = rating
        self.imagen = imagen
        self.created_at = created_at

    def serializar(self) -> dict:
        return {
            'id': self.id,
            'nombre': self.nombre,
            'ubicacion': self.ubicacion,
            'tipo': self.tipo,
            'precio': float(self.precio) if self.precio else None,
            'rating': float(self.rating) if self.rating else None,
            'imagen': self.imagen,
            'created_at': str(self.created_at)
        }

    @staticmethod
    def deserializar(data: dict):
        return RestauranteModel(
            id=data.get('id', 0),
            nombre=data.get('nombre', ''),
            ubicacion=data.get('ubicacion', ''),
            tipo=data.get('tipo', ''),
            precio=data.get('precio', 0.0),
            rating=data.get('rating', 0.0),
            imagen=data.get('imagen', ''),
            created_at=data.get('created_at')
        )

    @staticmethod
    def obtener_todos():
        conn = get_connection()
        cursor = conn.cursor(dictionary=True)
        cursor.execute("SELECT * FROM restaurantes")
        data = cursor.fetchall()
        cursor.close()
        conn.close()
        return [RestauranteModel.deserializar(r) for r in data]

    @staticmethod
    def obtener_por_id(id):
        conn = get_connection()
        cursor = conn.cursor(dictionary=True)
        cursor.execute("SELECT * FROM restaurantes WHERE id = %s", (id,))
        data = cursor.fetchone()
        cursor.close()
        conn.close()
        return RestauranteModel.deserializar(data) if data else None

    @staticmethod
    def buscar(destino=None, tipo=None):
        conn = get_connection()
        cursor = conn.cursor(dictionary=True)
        query = "SELECT * FROM restaurantes WHERE 1"
        params = []
        if destino:
            query += " AND ubicacion LIKE %s"
            params.append(f"%{destino}%")
        if tipo:
            query += " AND tipo = %s"
            params.append(tipo)
        cursor.execute(query, params)
        data = cursor.fetchall()
        cursor.close()
        conn.close()
        return [RestauranteModel.deserializar(r) for r in data]