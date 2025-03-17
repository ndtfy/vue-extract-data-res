<script setup>

import { ref } from 'vue'

const status = ref('\u200a'); // &hairsp;

</script>

<template>
  <footer>
    <i class="truncate mr-auto">{{ status }}</i>
    <div></div>
  </footer>
</template>

<style scoped>
  footer {
    position: sticky;
    bottom: 0;
    display: flex;
    justify-content: start;
    align-items: center;
    padding: 4px 16px;
    z-index: 100;
    background-color: var(--navbar-bottom-background-color);
  }
</style>
