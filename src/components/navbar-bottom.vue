<script setup>

import { ref } from 'vue'

const status = ref('\u200a'); // &hairsp;

</script>

<template>
  <footer class="navbar-bottom">
    <i class="truncate mr-auto">{{ status }}</i>
    <div></div>
  </footer>
</template>

<style>
  :root {
    --navbar-bottom-background-color: #ecf3fe;
  }
  :root.dark {
    --navbar-bottom-background-color: #3c3c3c;
  }
</style>

<style scoped>
  footer {
    position: sticky;
    bottom: 0;
    display: flex;
    justify-content: start;
    align-items: center;
    padding: 4px 16px;
    z-index: 100;
  }
</style>
