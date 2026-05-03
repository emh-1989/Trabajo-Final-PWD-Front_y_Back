// router/index.ts
import { createRouter, createWebHistory } from 'vue-router'
import { useAuthStore } from '@/stores/useAuthStore'

const HomeView = () => import('@/views/Inicio.vue')
const CondicionesView = () => import('@/views/condiciones_de_uso.vue')
const PrivacidadView = () => import('@/views/privacidad.vue')
const ContactoView = () => import('@/views/contacto.vue')
const HospedajeView = () => import('@/views/Hospedaje.vue')
const HotelDetalleView = () => import('@/views/Hoteldetalle.vue')
const EntretenimientoView = () => import('@/views/Entretenimiento.vue')
const VuelosView = () => import('@/views/Vuelos.vue')
const RestaurantView = () => import('@/views/Restaurant.vue')
const LoginView = () => import('@/views/Login.vue')
const RegisterView = () => import('@/views/Register.vue')
const PerfilView = () => import('@/views/Perfil.vue')
const FavoritosView = () => import('@/views/Favoritos.vue')
const MisReservasView = () => import('@/views/MisReservas.vue')
const MisPublicacionesView = () => import('@/views/MisPublicaciones.vue')
const PublicarPropiedadesView = () => import('@/views/PublicarPropiedades.vue')
const AdminPanelView = () => import('@/views/AdminPanel.vue')
const AdminUsuariosView = () => import('@/views/AdminUsuarios.vue')
const NotFoundView = () => import('@/views/NotFound.vue')

const router = createRouter({
  history: createWebHistory(import.meta.env.BASE_URL),
  routes: [
    { path: '/', name: 'home', component: HomeView },
    { path: '/condiciones_de_uso', name: 'condiciones', component: CondicionesView },
    { path: '/privacidad', name: 'privacidad', component: PrivacidadView },
    { path: '/contacto', name: 'contacto', component: ContactoView },
    { path: '/hospedaje', name: 'hospedaje', component: HospedajeView },
    { path: '/hotel/:id', name: 'hotelDetalle', component: HotelDetalleView, props: true },
    { path: '/entretenimiento', name: 'entretenimiento', component: EntretenimientoView },
    { path: '/vuelos', name: 'vuelos', component: VuelosView },
    { path: '/restaurant', name: 'restaurant', component: RestaurantView },
    { path: '/login', name: 'login', component: LoginView, meta: { guest: true } },
    { path: '/register', name: 'register', component: RegisterView, meta: { guest: true } },
    { path: '/perfil', name: 'perfil', component: PerfilView, meta: { requiresAuth: true } },
    {
      path: '/favoritos',
      name: 'favoritos',
      component: FavoritosView,
      meta: { requiresAuth: true },
    },
    {
      path: '/mis-reservas',
      name: 'misReservas',
      component: MisReservasView,
      meta: { requiresAuth: true },
    },
    {
      path: '/mis-publicaciones',
      name: 'misPublicaciones',
      component: MisPublicacionesView,
      meta: { requiresAuth: true, roles: ['anfitrion', 'admin'] },
    },
    {
      path: '/publicar',
      name: 'publicar',
      component: PublicarPropiedadesView,
      meta: { requiresAuth: true, roles: ['anfitrion', 'admin'] },
    },
    {
      path: '/publicar/:id',
      name: 'editarPublicacion',
      component: PublicarPropiedadesView,
      props: true,
      meta: { requiresAuth: true, roles: ['anfitrion', 'admin'] },
    },
    {
      path: '/admin',
      name: 'admin',
      component: AdminPanelView,
      meta: { requiresAuth: true, roles: ['admin'] },
    },
    {
      path: '/admin/usuarios',
      name: 'adminUsuarios',
      component: AdminUsuariosView,
      meta: { requiresAuth: true, roles: ['admin'] },
    },
    { path: '/:pathMatch(.*)*', name: 'notFound', component: NotFoundView },
  ],
})

// ── FIX: inicializar auth UNA vez antes del primer guard ──────────
// Evita el race condition donde el guard corre antes que inicializar() termine
let authListo = false

router.beforeEach(async (to, _from, next) => {
  const auth = useAuthStore()

  // Inicializar auth solo la primera vez (cuando hay token pero no usuario cargado)
  if (!authListo) {
    authListo = true
    if (auth.token && !auth.usuario) {
      await auth.inicializar()
    }
  }

  // 1. Rutas que requieren autenticación
  if (to.meta.requiresAuth && !auth.estaLogueado) {
    next({ name: 'login', query: { redirect: to.fullPath } })
    return
  }

  // 2. Rutas con roles específicos
  if (to.meta.roles) {
    const requiredRoles = to.meta.roles as string[]
    const userRole = auth.usuario?.rol
    if (!userRole || !requiredRoles.includes(userRole)) {
      next({ name: 'home' })
      return
    }
  }

  // 3. Rutas solo para invitados (login/register)
  if (to.meta.guest && auth.estaLogueado) {
    next({ name: 'home' })
    return
  }

  next()
})

export default router
