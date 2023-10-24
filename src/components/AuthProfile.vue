<script setup>
import { supabase } from '../supabase.js'
import { ref } from 'vue'

const { session } = defineProps(['session'])
const loading = ref(false)

const handleLogout = async () => {
  try {
    loading.value = true
    const { error } = await supabase.auth.signOut()
    if (error) throw error
  } catch (error) {
    if (error instanceof Error) {
      alert(error.message)
    }
  } finally {
    loading.value = false
  }
}
</script>


<template>
  <div class="max-w-screen-xl px-4 py-16">
    <div class="max-w-lg">
      <h1 class="text-2xl font-bold">Profile</h1>
      <p class="mt-4 text-gray-500">You're logged in as <span class="text-blue-500">{{ session.user.email }}</span></p>
    </div>

    <form @submit.prevent="handleLogout" class="mb-0 mt-4 max-w-sm space-y-4">
        <button type="submit" class="inline-block rounded-lg bg-blue-500 px-5 py-3 text-sm font-medium text-white">
          {{ loading ? 'Loading' : 'Logout' }}
        </button>
    </form>
  </div>
</template>