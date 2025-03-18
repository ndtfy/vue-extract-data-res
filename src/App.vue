<script setup>

import NavbarTop from '@/components/navbar-top.vue'
import NavbarBottom from '@/components/navbar-bottom.vue'
import WidgetExtractData from '@/components/widget-extract-data.vue'

if ( import.meta.env.DEV )
  import('@/assets/debug.css');

</script>

<template>
  <div class="global">
    <NavbarTop />
    <main>
      <div class="widget">
        <h3 class="whitespace-nowrap">Convert raw data to list</h3>
        <WidgetExtractData />
      </div>
    </main>
    <NavbarBottom />
  </div>
</template>

<style scoped>
  .global {
    display: flex;
    flex-direction: column;
    overflow-x: hidden;
    height: 100vh;
  }
  main {
    position: relative;
    flex-grow: 1;
    padding: 8px;
    background-color: var(--color-background-mute);
  }
  .widget {
    padding: 8px;
    background-color: var(--color-background);
  }
</style>
