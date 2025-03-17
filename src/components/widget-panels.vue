<script setup>

import { toRefs } from 'vue'

const props = defineProps({
  width: {
    type: String,
    default: '100%'
  },
  height: {
    type: String,
    default: '100%'
  }
});

const { width, height } = toRefs(props);

</script>

<template>
  <div class="table" :style="`width: ${width}; height: ${height}`">
    <div class="table-row">
      <div class="table-cell">
        <div class="bar">
          <slot name="bar1" />
        </div>
        <div class="pane-f">
          <slot name="pane1" />
        </div>
      </div>
      <div class="table-cell">
        <div class="bar">
          <slot name="bar2" />
        </div>
        <div class="pane">
          <slot name="pane2" />
        </div>
      </div>
    </div>
  </div>
</template>

<style scoped>
  .table {
    display: table;
    border-collapse: collapse;
    /*width: v-bind('width');*/
    /*height: v-bind('height');*/
  }
  .table-row {
    display: table-row;
  }
  .table-cell {
    display: table-cell;
    vertical-align: top;
    border: 1px solid #77f;
    min-width: 150px;
  }
  .table-cell:first-child {
    width: 50%;
    resize: horizontal;
    overflow-x: auto;
  }
  .bar {
    position: sticky;
    z-index: 1;
    display: flex;
    justify-content: start;
    align-items: center;
    top: 0;
    background-color: #ddd;
    gap: 4px;
  }
  .bar:has(*) {
    border: 4px solid transparent;
  }
  .pane {
    position: relative;
    padding: 8px;
  }
  .pane-f {
    position: relative;
    display: flex;
    flex-direction: column;
    height: calc(100% - 30px);
    padding: 8px;
  }
</style>
