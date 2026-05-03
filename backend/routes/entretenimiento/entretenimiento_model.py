from database import get_connection

class EntretenimientoModel:

    def __init__(self, id=0, titulo="", ubicacion="", fecha=None, tipo="", imagen="", descripcion="", created_at=None):
        self.id = id
        self.titulo = titulo
        self.ubicacion = ubicacion
        self.fecha = fecha
        self.tipo = tipo
        self.imagen = imagen
        self.descripcion = descripcion
        self.created_at = created_at

    def serializar(self) -> dict:
        return {
            'id': self.id,
            'titulo': self.titulo,
            'ubicacion': self.ubicacion,
            'fecha': str(self.fecha) if self.fecha else None,
            'tipo': self.tipo,
            'imagen': self.imagen,
            'descripcion': self.descripcion,
            'created_at': str(self.created_at)
        }

    @staticmethod
    def deserializar(data: dict):
        return EntretenimientoModel(
            id=data.get('id', 0),
            titulo=data.get('titulo', ''),
            ubicacion=data.get('ubicacion', ''),
            fecha=data.get('fecha'),
            tipo=data.get('tipo', ''),
            imagen=data.get('imagen', ''),
            descripcion=data.get('descripcion', ''),
            created_at=data.get('created_at')
        )

    @staticmethod
    def obtener_todos():
        conn = get_connection()
        cursor = conn.cursor(dictionary=True)
        cursor.execute("SELECT * FROM entretenimiento")
        data = cursor.fetchall()
        cursor.close()
        conn.close()
        return [EntretenimientoModel.deserializar(e) for e in data]

    @staticmethod
    def obtener_por_id(id):
        conn = get_connection()
        cursor = conn.cursor(dictionary=True)
        cursor.execute("SELECT * FROM entretenimiento WHERE id = %s", (id,))
        data = cursor.fetchone()
        cursor.close()
        conn.close()
        return EntretenimientoModel.deserializar(data) if data else None

    @staticmethod
    def buscar(destino=None, tipo=None, fecha=None):
        conn = get_connection()
        cursor = conn.cursor(dictionary=True)
        query = "SELECT * FROM entretenimiento WHERE 1"
        params = []
        if destino:
            query += " AND ubicacion LIKE %s"
            params.append(f"%{destino}%")
        if tipo:
            query += " AND tipo = %s"
            params.append(tipo)
        if fecha:
            query += " AND fecha = %s"
            params.append(fecha)
        cursor.execute(query, params)
        data = cursor.fetchall()
        cursor.close()
        conn.close()
        return [EntretenimientoModel.deserializar(e) for e in data]