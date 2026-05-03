from database import get_connection

class VueloModel:

    def __init__(self, id=0, aerolinea="", logo=None, origen="", destino="", hora_salida=None, hora_llegada=None, duracion="", precio=0.0, escalas=0, created_at=None):
        self.id = id
        self.aerolinea = aerolinea
        self.logo = logo
        self.origen = origen
        self.destino = destino
        self.hora_salida = hora_salida
        self.hora_llegada = hora_llegada
        self.duracion = duracion
        self.precio = precio
        self.escalas = escalas
        self.created_at = created_at

    def serializar(self) -> dict:
        return {
            'id': self.id,
            'aerolinea': self.aerolinea,
            'logo': self.logo,
            'origen': self.origen,
            'destino': self.destino,
            'horaSalida': str(self.hora_salida) if self.hora_salida else None,
            'horaLlegada': str(self.hora_llegada) if self.hora_llegada else None,
            'duracion': self.duracion,
            'precio': float(self.precio),
            'escalas': self.escalas,
            'created_at': str(self.created_at)
        }

    @staticmethod
    def deserializar(data: dict):
        return VueloModel(
            id=data.get('id', 0),
            aerolinea=data.get('aerolinea', ''),
            logo=data.get('logo'),
            origen=data.get('origen', ''),
            destino=data.get('destino', ''),
            hora_salida=data.get('hora_salida'),
            hora_llegada=data.get('hora_llegada'),
            duracion=data.get('duracion', ''),
            precio=data.get('precio', 0.0),
            escalas=data.get('escalas', 0),
            created_at=data.get('created_at')
        )

    @staticmethod
    def obtener_todos():
        conn = get_connection()
        cursor = conn.cursor(dictionary=True)
        cursor.execute("SELECT * FROM vuelos")
        data = cursor.fetchall()
        cursor.close()
        conn.close()
        return [VueloModel.deserializar(v) for v in data]

    @staticmethod
    def obtener_por_id(id):
        conn = get_connection()
        cursor = conn.cursor(dictionary=True)
        cursor.execute("SELECT * FROM vuelos WHERE id = %s", (id,))
        data = cursor.fetchone()
        cursor.close()
        conn.close()
        return VueloModel.deserializar(data) if data else None

    @staticmethod
    def buscar(origen=None, destino=None, fecha_ida=None, pasajeros=None):
        conn = get_connection()
        cursor = conn.cursor(dictionary=True)
        query = "SELECT * FROM vuelos WHERE 1"
        params = []
        if origen:
            query += " AND origen LIKE %s"
            params.append(f"%{origen}%")
        if destino:
            query += " AND destino LIKE %s"
            params.append(f"%{destino}%")
        if fecha_ida:
            query += " AND DATE(hora_salida) = %s"
            params.append(fecha_ida)
        cursor.execute(query, params)
        data = cursor.fetchall()
        cursor.close()
        conn.close()
        return [VueloModel.deserializar(v) for v in data]