<script setup>

import { toRefs } from 'vue'

const props = defineProps({
  output: {
    required: true
  },
  prompt: {
    type: String,
    default: ''
  }
});

const { output, prompt } = toRefs(props);

</script>

<template>
  <i v-if="!output.length">{{ prompt }}</i>
  <div>
    <ol>
      <li v-for="val in output">{{ val }}</li>
    </ol>
  </div>
</template>

<style scoped>
  div {
    flex-grow: 1;
    resize: vertical;
    overflow-y: auto;
    min-height: 200px;
    max-height: 60vh;
  }
  ol {
    box-sizing: border-box;
    font-size: small;
    font-family: monospace;
    letter-spacing: normal;
    word-spacing: normal;
    line-height: normal;
    overflow-wrap: break-word;
    white-space-collapse: preserve;
    text-wrap-mode: nowrap;
  }
  li {
    max-width: 150px;
  }
  ol li::marker {
    color: blue;
  }
  .dark ol li::marker {
    color: #9e9eff;
  }
</style>
