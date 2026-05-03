from database import get_connection

class HotelModel:

    def __init__(self, id=0, nombre="", ubicacion="", descripcion="", precio=0.0, rating=0.0, tipo="hotel", imagen="", propietario_id=None, created_at=None):
        self.id = id
        self.nombre = nombre
        self.ubicacion = ubicacion
        self.descripcion = descripcion
        self.precio = precio
        self.rating = rating
        self.tipo = tipo
        self.imagen = imagen
        self.propietario_id = propietario_id
        self.created_at = created_at

    def serializar(self) -> dict:
        return {
            'id': self.id,
            'nombre': self.nombre,
            'ubicacion': self.ubicacion,
            'descripcion': self.descripcion,
            'precio': float(self.precio),
            'rating': float(self.rating),
            'tipo': self.tipo,
            'imagen': self.imagen,
            'propietario_id': self.propietario_id,
            'created_at': str(self.created_at)
        }

    @staticmethod
    def deserializar(data: dict):
        return HotelModel(
            id=data.get('id', 0),
            nombre=data.get('nombre', ''),
            ubicacion=data.get('ubicacion', ''),
            descripcion=data.get('descripcion', ''),
            precio=data.get('precio', 0.0),
            rating=data.get('rating', 0.0),
            tipo=data.get('tipo', 'hotel'),
            imagen=data.get('imagen', ''),
            propietario_id=data.get('propietario_id'),
            created_at=data.get('created_at')
        )

    @staticmethod
    def obtener_todos():
        conn = get_connection()
        cursor = conn.cursor(dictionary=True)
        cursor.execute("SELECT * FROM hoteles WHERE 1")
        data = cursor.fetchall()
        cursor.close()
        conn.close()
        return [HotelModel.deserializar(h) for h in data]

    @staticmethod
    def obtener_por_id(id):
        conn = get_connection()
        cursor = conn.cursor(dictionary=True)
        cursor.execute("SELECT * FROM hoteles WHERE id = %s", (id,))
        data = cursor.fetchone()
        cursor.close()
        conn.close()
        return HotelModel.deserializar(data) if data else None

    @staticmethod
    def buscar(destino=None, checkin=None, checkout=None, pasajeros=None):
        conn = get_connection()
        cursor = conn.cursor(dictionary=True)
        query = "SELECT * FROM hoteles WHERE 1"
        params = []
        if destino:
            query += " AND ubicacion LIKE %s"
            params.append(f"%{destino}%")
        cursor.execute(query, params)
        data = cursor.fetchall()
        cursor.close()
        conn.close()
        return [HotelModel.deserializar(h) for h in data]

    @staticmethod
    def crear(nombre, ubicacion, descripcion, precio, tipo, imagen, propietario_id):
        conn = get_connection()
        cursor = conn.cursor()
        cursor.execute(
            "INSERT INTO hoteles (nombre, ubicacion, descripcion, precio, tipo, imagen, propietario_id) VALUES (%s, %s, %s, %s, %s, %s, %s)",
            (nombre, ubicacion, descripcion, precio, tipo, imagen, propietario_id)
        )
        conn.commit()
        id_nuevo = cursor.lastrowid
        cursor.close()
        conn.close()
        return HotelModel.obtener_por_id(id_nuevo)

    @staticmethod
    def eliminar(id):
        conn = get_connection()
        cursor = conn.cursor()
        cursor.execute("DELETE FROM hoteles WHERE id = %s", (id,))
        conn.commit()
        cursor.close()
        conn.close()