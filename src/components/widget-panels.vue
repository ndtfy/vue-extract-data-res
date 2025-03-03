<script setup lang="ts">

import { toRefs } from 'vue'

const props = defineProps({
  width: {
    type: String,
    default: '100%'
  },
  height: {
    type: String,
    default: '20vh'
  }
})

const { width, height } = toRefs(props)

</script>

<template>
  <div class="paneset" :style="`width: ${width}; height: ${height}`">
    <div class="pane pane1">
      <slot name="pane1" />
    </div>
    <div class="pane pane2">
      <slot name="pane2" />
    </div>
  </div>
</template>

<style scoped>
  .paneset {
    display: table;
    /*width: v-bind('width');*/
    /*height: v-bind('height');*/
  }
  .pane {
    padding: 8px;
    display: table-cell;
    overflow: overlay;
    border: 1px solid #77f;
    min-width: 200px;
  }
  .pane1 {
    width: 50%;
    resize: both;
  }
</style>
