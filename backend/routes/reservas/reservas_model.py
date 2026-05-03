from database import get_connection

class ReservaModel:

    def __init__(self, id=0, usuario_id=0, hotel_id=None, vuelo_id=None, fecha_entrada=None, fecha_salida=None, estado='pendiente', created_at=None, hotel=None, vuelo=None):
        self.id = id
        self.usuario_id = usuario_id
        self.hotel_id = hotel_id
        self.vuelo_id = vuelo_id
        self.fecha_entrada = fecha_entrada
        self.fecha_salida = fecha_salida
        self.estado = estado
        self.created_at = created_at
        self.hotel = hotel
        self.vuelo = vuelo

    def serializar(self) -> dict:
        return {
            'id': self.id,
            'usuario_id': self.usuario_id,
            'hotel_id': self.hotel_id,
            'vuelo_id': self.vuelo_id,
            'fecha_entrada': str(self.fecha_entrada) if self.fecha_entrada else None,
            'fecha_salida': str(self.fecha_salida) if self.fecha_salida else None,
            'estado': self.estado,
            'created_at': str(self.created_at),
            'hotel': self.hotel,
            'vuelo': self.vuelo
        }

    @staticmethod
    def deserializar(data: dict):
        return ReservaModel(
            id=data.get('id', 0),
            usuario_id=data.get('usuario_id', 0),
            hotel_id=data.get('hotel_id'),
            vuelo_id=data.get('vuelo_id'),
            fecha_entrada=data.get('fecha_entrada'),
            fecha_salida=data.get('fecha_salida'),
            estado=data.get('estado', 'pendiente'),
            created_at=data.get('created_at')
        )

    @staticmethod
    def obtener_por_usuario(usuario_id):
        conn = get_connection()
        cursor = conn.cursor(dictionary=True)
        cursor.execute("""
            SELECT r.*,
                h.nombre AS hotel_nombre, h.ubicacion AS hotel_ubicacion, h.imagen AS hotel_imagen,
                v.aerolinea AS vuelo_aerolinea, v.origen AS vuelo_origen, v.destino AS vuelo_destino,
                v.hora_salida AS vuelo_hora_salida, v.hora_llegada AS vuelo_hora_llegada
            FROM reservas r
            LEFT JOIN hoteles h ON r.hotel_id = h.id
            LEFT JOIN vuelos v ON r.vuelo_id = v.id
            WHERE r.usuario_id = %s
            ORDER BY r.created_at DESC
        """, (usuario_id,))
        data = cursor.fetchall()
        cursor.close()
        conn.close()

        reservas = []
        for row in data:
            reserva = ReservaModel.deserializar(row)
            if row.get('hotel_nombre'):
                reserva.hotel = {
                    'id': row['hotel_id'],
                    'nombre': row['hotel_nombre'],
                    'ubicacion': row['hotel_ubicacion'],
                    'imagen': row['hotel_imagen']
                }
            if row.get('vuelo_aerolinea'):
                reserva.vuelo = {
                    'id': row['vuelo_id'],
                    'aerolinea': row['vuelo_aerolinea'],
                    'origen': row['vuelo_origen'],
                    'destino': row['vuelo_destino'],
                    'hora_salida': str(row['vuelo_hora_salida']),
                    'hora_llegada': str(row['vuelo_hora_llegada'])
                }
            reservas.append(reserva)
        return reservas

    @staticmethod
    def obtener_por_id(id):
        conn = get_connection()
        cursor = conn.cursor(dictionary=True)
        cursor.execute("SELECT * FROM reservas WHERE id = %s", (id,))
        data = cursor.fetchone()
        cursor.close()
        conn.close()
        return ReservaModel.deserializar(data) if data else None

    @staticmethod
    def crear(usuario_id, hotel_id=None, vuelo_id=None, fecha_entrada=None, fecha_salida=None):
        conn = get_connection()
        cursor = conn.cursor()
        cursor.execute(
            "INSERT INTO reservas (usuario_id, hotel_id, vuelo_id, fecha_entrada, fecha_salida) VALUES (%s, %s, %s, %s, %s)",
            (usuario_id, hotel_id, vuelo_id, fecha_entrada, fecha_salida)
        )
        conn.commit()
        id_nuevo = cursor.lastrowid
        cursor.close()
        conn.close()
        return ReservaModel.obtener_por_id(id_nuevo)

    @staticmethod
    def actualizar_estado(id, estado):
        conn = get_connection()
        cursor = conn.cursor()
        cursor.execute(
            "UPDATE reservas SET estado = %s WHERE id = %s",
            (estado, id)
        )
        conn.commit()
        cursor.close()
        conn.close()