import { instance as axios } from '@/plugins/axios'

class ApiService {
  static async getAll(resource: string) {
    return axios.get(resource)
  }

  static async getOne(resource: string, id: number) {
    return axios.get(`${resource}/${id}`)
  }

  static async create(resource: string, data: object) {
    return axios.post(resource, data)
  }

  // Acepta tanto number como string (para endpoints como 'leer-todas')
  static async update(resource: string, id: number | string, data: object) {
    return axios.put(`${resource}/${id}`, data)
  }

  static async destroy(resource: string, id: number) {
    return axios.delete(`${resource}/${id}`)
  }
}

export default ApiService
