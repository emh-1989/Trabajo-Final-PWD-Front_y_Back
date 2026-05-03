from database import get_connection

class UsuarioModel:

    def __init__(self, id=0, nombre="", email="", password="", avatar=None, rol="viajero", created_at=None):
        self.id = id
        self.nombre = nombre
        self.email = email
        self.password = password
        self.avatar = avatar
        self.rol = rol
        self.created_at = created_at

    def serializar(self) -> dict:
        return {
            'id': self.id,
            'nombre': self.nombre,
            'email': self.email,
            'avatar': self.avatar,
            'rol': self.rol,
            'created_at': self.created_at
        }

    @staticmethod
    def deserializar(data: dict):
        return UsuarioModel(
            id=data.get('id', 0),
            nombre=data.get('nombre', ''),
            email=data.get('email', ''),
            password=data.get('password', ''),
            avatar=data.get('avatar'),
            rol=data.get('rol', 'viajero'),
            created_at=data.get('created_at')
        )

    @staticmethod
    def obtener_por_email(email):
        conn = get_connection()
        cursor = conn.cursor(dictionary=True)
        cursor.execute("SELECT * FROM usuarios WHERE email = %s", (email,))
        data = cursor.fetchone()
        cursor.close()
        conn.close()
        return UsuarioModel.deserializar(data) if data else None

    @staticmethod
    def obtener_por_id(id):
        conn = get_connection()
        cursor = conn.cursor(dictionary=True)
        cursor.execute("SELECT * FROM usuarios WHERE id = %s", (id,))
        data = cursor.fetchone()
        cursor.close()
        conn.close()
        return UsuarioModel.deserializar(data) if data else None

    @staticmethod
    def crear(nombre, email, password_hash):
        conn = get_connection()
        cursor = conn.cursor()
        cursor.execute(
            "INSERT INTO usuarios (nombre, email, password) VALUES (%s, %s, %s)",
            (nombre, email, password_hash)
        )
        conn.commit()
        id_nuevo = cursor.lastrowid
        cursor.close()
        conn.close()
        return UsuarioModel.obtener_por_id(id_nuevo)

    @staticmethod
    def actualizar_perfil(id, nombre, email):
        conn = get_connection()
        cursor = conn.cursor()
        cursor.execute(
            "UPDATE usuarios SET nombre = %s, email = %s WHERE id = %s",
            (nombre, email, id)
        )
        conn.commit()
        cursor.close()
        conn.close()

    @staticmethod
    def actualizar_password(id, password_hash):
        conn = get_connection()
        cursor = conn.cursor()
        cursor.execute(
            "UPDATE usuarios SET password = %s WHERE id = %s",
            (password_hash, id)
        )
        conn.commit()
        cursor.close()
        conn.close()

    @staticmethod
    def actualizar_avatar(id, url):
        conn = get_connection()
        cursor = conn.cursor()
        cursor.execute(
            "UPDATE usuarios SET avatar = %s WHERE id = %s",
            (url, id)
        )
        conn.commit()
        cursor.close()
        conn.close()

    @staticmethod
    def actualizar_rol(id, rol):
        conn = get_connection()
        cursor = conn.cursor()
        cursor.execute(
            "UPDATE usuarios SET rol = %s WHERE id = %s",
            (rol, id)
        )
        conn.commit()
        cursor.close()
        conn.close()