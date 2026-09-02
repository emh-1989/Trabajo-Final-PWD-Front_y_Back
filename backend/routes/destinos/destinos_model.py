from database import get_connection


class DestinoModel:
    def __init__(self, id=0, titulo="", emoji="", imagen="", descripcion="",
                 paisajes="", comida="", tips=None, orden=0, created_at=None):
        self.id = id
        self.titulo = titulo
        self.emoji = emoji
        self.imagen = imagen
        self.descripcion = descripcion
        self.paisajes = paisajes
        self.comida = comida
        self.tips = tips or []
        self.orden = orden
        self.created_at = created_at

    def serializar(self) -> dict:
        return {
            'id': self.id,
            'titulo': self.titulo,
            'emoji': self.emoji,
            'imagen': self.imagen,
            'descripcion': self.descripcion,
            'paisajes': self.paisajes,
            'comida': self.comida,
            'tips': self.tips,
            'orden': self.orden,
        }

    @staticmethod
    def deserializar(data: dict):
        tips_raw = data.get('tips') or ''
        return DestinoModel(
            id=data.get('id', 0),
            titulo=data.get('titulo', ''),
            emoji=data.get('emoji', ''),
            imagen=data.get('imagen', ''),
            descripcion=data.get('descripcion', ''),
            paisajes=data.get('paisajes', ''),
            comida=data.get('comida', ''),
            tips=tips_raw.split('|') if tips_raw else [],
            orden=data.get('orden', 0),
            created_at=data.get('created_at'),
        )

    @staticmethod
    def obtener_todos():
        conn = get_connection()
        cursor = conn.cursor(dictionary=True)
        cursor.execute("SELECT * FROM destinos ORDER BY orden ASC, id ASC")
        data = cursor.fetchall()
        cursor.close()
        conn.close()
        return [DestinoModel.deserializar(d) for d in data]

    @staticmethod
    def obtener_por_id(id):
        conn = get_connection()
        cursor = conn.cursor(dictionary=True)
        cursor.execute("SELECT * FROM destinos WHERE id = %s", (id,))
        data = cursor.fetchone()
        cursor.close()
        conn.close()
        return DestinoModel.deserializar(data) if data else None

    @staticmethod
    def crear(titulo, emoji, imagen, descripcion, paisajes, comida, tips, orden=0):
        conn = get_connection()
        cursor = conn.cursor()
        tips_str = '|'.join(tips) if isinstance(tips, list) else tips
        cursor.execute(
            """INSERT INTO destinos
               (titulo, emoji, imagen, descripcion, paisajes, comida, tips, orden)
               VALUES (%s, %s, %s, %s, %s, %s, %s, %s)""",
            (titulo, emoji, imagen, descripcion, paisajes, comida, tips_str, orden)
        )
        conn.commit()
        id_nuevo = cursor.lastrowid
        cursor.close()
        conn.close()
        return DestinoModel.obtener_por_id(id_nuevo)

    @staticmethod
    def actualizar(id, titulo, emoji, imagen, descripcion, paisajes, comida, tips, orden):
        conn = get_connection()
        cursor = conn.cursor()
        tips_str = '|'.join(tips) if isinstance(tips, list) else tips
        cursor.execute(
            """UPDATE destinos SET titulo=%s, emoji=%s, imagen=%s, descripcion=%s,
               paisajes=%s, comida=%s, tips=%s, orden=%s WHERE id=%s""",
            (titulo, emoji, imagen, descripcion, paisajes, comida, tips_str, orden, id)
        )
        conn.commit()
        cursor.close()
        conn.close()
        return DestinoModel.obtener_por_id(id)

    @staticmethod
    def eliminar(id):
        conn = get_connection()
        cursor = conn.cursor()
        cursor.execute("DELETE FROM destinos WHERE id = %s", (id,))
        conn.commit()
        cursor.close()
        conn.close()