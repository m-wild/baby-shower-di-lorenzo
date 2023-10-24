<script setup>
import { ref, onMounted } from 'vue'
import { supabase } from './supabase.js'
import Gifts from './components/Gifts.vue'
import AuthLogin from './components/AuthLogin.vue'
import AuthProfile from './components/AuthProfile.vue'

const session = ref()

function promptLogin() {
  const login = document.getElementById('auth')
  if (login)
    login.scrollIntoView()
}

onMounted(() => {
  supabase.auth.getSession().then(({ data }) => {
    session.value = data.session
  })

  supabase.auth.onAuthStateChange((_, _session) => {
    session.value = _session
  })
})
</script>

<template>
  <div class="container mx-auto p-6">
    <div class="flex flex-row justify-end">
      <a v-if="session" href="#auth" class="text-blue-500 hover:underline font-semibold">Profile</a>
      <a v-else href="#auth" class="text-blue-500 hover:underline font-semibold">Login</a>
    </div>
    <div class="text-center mb-10 text-blue-950" style="font-family: 'Pacifico', cursive;">
      <div class="text-6xl">Baby Shower</div>
      <div class="text-3xl">di</div>
      <div class="text-7xl">Lorenzo Wildman</div>
    </div>
    <div class="flex justify-around mb-20">
      <img src="./assets/ship.jpg" alt="toy sailboat" class="w-52 h-52" >
    </div>
    <Gifts :session="session" @not-logged-in="promptLogin"/>
    <AuthProfile v-if="session" :session="session" id="auth"/>
    <AuthLogin v-else id="auth" />
  </div>
</template>
