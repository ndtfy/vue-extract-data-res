<script setup>

import { ref } from 'vue'

import WidgetSwitch from '@/components/widget-switch.vue'


const isDark = ref();

// Toggles the 'dark' class based on if the media query matches
function toggleDarkMode(state) {
  isDark.value = state;
  document.documentElement.classList.toggle('dark', state);
//document.documentElement.dataset.theme = state ? 'dark' : '';
}

function toggle() {
  isDark.value = !isDark.value;
  document.documentElement.classList.toggle('dark');
//document.documentElement.dataset.theme = isDark.value ? 'dark' : '';
}


// MediaQueryList object
const useDark = window.matchMedia('(prefers-color-scheme: dark)');
toggleDarkMode(useDark.matches);


useDark.addListener(ev => toggleDarkMode(ev.matches));


defineExpose({
  toggleDarkMode,
  toggle
});

</script>

<template>
  <WidgetSwitch :checked="isDark" :onChange="toggle" />
</template>
