<script setup>
import GiftCard from './GiftCard.vue'
import { ref, onMounted, watch } from 'vue'
import { supabase } from '../supabase.js'

const props = defineProps(['session'])

const emit = defineEmits(['not-logged-in'])

const gifts = ref([])

async function getGifts() {
  const { data } = await supabase.from('my_gifts').select().order('title')
  gifts.value = data
}

async function handleClick(gift, index) {
  if (gift.taken_by_other || gift.multi) return

  if (!props.session) {
    emit('not-logged-in')
    return
  }

  try {
    const fn = gift.taken_by ? 'release_gift' : 'take_gift'
    const { error, data } = await supabase.rpc(fn, { gift_id: gift.id })

    if (error) throw error
    if (!data) throw 'no data returned from the server'

    gifts.value.splice(index, 1, data)

  } catch (error) {
    alert(error)
  }
}

watch(() => props.session, () => {
  getGifts()
});

onMounted(() => {
  getGifts()
})
</script>


<template>
  <div class="flex flex-col gap-y-4 mb-10">
    <GiftCard v-for="(gift, index) in gifts" :key="gift.id"
      :gift="gift"
      :index="index"
      @click.prevent="handleClick(gift, index)"
    />

  </div>
</template>