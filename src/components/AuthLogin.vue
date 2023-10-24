<script setup>
import { ref } from 'vue'
import { supabase } from '../supabase.js'

const loading = ref(false)
const email = ref('')

const handleLogin = async () => {
  try {
    loading.value = true
    const { error } = await supabase.auth.signInWithOtp({
      email: email.value,
      options: {
        emailRedirectTo: import.meta.env.VITE_AUTH_REDIRECT_URL
      }
    })
    if (error) throw error
    alert('Check your email for the login link!')
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
      <h1 class="text-2xl font-bold">Login</h1>

      <p class="mt-4 text-gray-500">You need to login to reserve gifts.</p>
      <p class="text-gray-500">Enter your email and we'll send you a magic link.</p>
    </div>

    <form @submit.prevent="handleLogin" class="mb-0 mt-8 max-w-sm space-y-4">
      <div>
        <label for="email" class="sr-only">Email</label>

        <div class="relative">
          <input type="email" class="w-full rounded-lg border-gray-200 p-4 pe-12 text-sm shadow-sm" placeholder="Enter email" v-model="email"/>

          <span class="absolute inset-y-0 end-0 grid place-content-center px-4">
            <svg xmlns="http://www.w3.org/2000/svg" class="h-4 w-4 text-gray-400" fill="none" viewBox="0 0 24 24"
              stroke="currentColor">
              <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                d="M16 12a4 4 0 10-8 0 4 4 0 008 0zm0 0v1.5a2.5 2.5 0 005 0V12a9 9 0 10-9 9m4.5-1.206a8.959 8.959 0 01-4.5 1.207" />
            </svg>
          </span>
        </div>
      </div>

      <div class="flex flex-row justify-end">
        <button type="submit" class="inline-block rounded-lg bg-blue-500 px-5 py-3 text-sm font-medium text-white">
          {{ loading ? 'Loading' : 'Send Magic Link' }}
        </button>
      </div>
    </form>
  </div>
</template>

