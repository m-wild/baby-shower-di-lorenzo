<script>
export default {
  props: ['gift']
}
</script>


<template>
  <div class="group relative block overflow-hidden rounded-lg border border-gray-200 bg-gray-50 bg-opacity-10 p-6"
    :class="{ 'pb-16': gift.taken_by != null || gift.multi, 'cursor-pointer': !gift.multi && !gift.taken_by_other, 'bg-opacity-100': gift.taken_by_other }">

    <span v-if="gift.taken_by_me" class="absolute inset-x-0 bottom-0 h-10 bg-blue-200 flex flex-auto">
      <div class="my-auto px-6 text-sm text-blue-800">You're giving this gift</div>
    </span>
    <span v-else-if="gift.taken_by_other" class="absolute inset-x-0 bottom-0 h-10 bg-slate-200 flex flex-auto">
      <div class="my-auto px-6 text-sm text-slate-800">Someone else is giving this gift</div>
    </span>
    <span v-else-if="gift.multi" class="absolute inset-x-0 bottom-0 h-10 bg-yellow-50 flex flex-auto">
      <div class="my-auto px-6 text-sm text-yellow-700">Anyone can gift these</div>
    </span>

    <div class="flex flex-row justify-between">
      <div>
        <h3 class="text-lg font-bold">
          {{ gift.title }}
        </h3>

        <p v-if="gift.descr" class="mt-2 text-sm text-gray-500">
          {{ gift.descr }}
        </p>

      </div>
      <div v-if="!gift.multi && !gift.taken_by_other" class="my-auto">
        <svg xmlns="http://www.w3.org/2000/svg" class="w-10 h-10 lg:group-hover:text-blue-200"
        :class="[ gift.taken_by_me ? 'text-blue-200' : 'text-gray-100' ]" viewBox="0 0 20 20" fill="currentColor">
          <path fill-rule="evenodd"
            d="M10 18a8 8 0 100-16 8 8 0 000 16zm3.707-9.293a1 1 0 00-1.414-1.414L9 10.586 7.707 9.293a1 1 0 00-1.414 1.414l2 2a1 1 0 001.414 0l4-4z"
            clip-rule="evenodd" />
        </svg>
      </div>
    </div>
  </div>
</template>