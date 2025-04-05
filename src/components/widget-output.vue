<script setup>

const { output, prompt } = defineProps({
  output: {
    required: true
  },
  prompt: {
    type: String,
    default: ''
  }
});

</script>

<template>
  <div>
    <i v-if="prompt">{{ prompt }}</i>
    <ol>
      <li v-for="val in output">{{ val }}</li>
    </ol>
  </div>
</template>

<style scoped>
  div {
    position: relative;
    flex-grow: 1;
    resize: vertical;
    overflow-y: auto;
    min-height: 200px;
    max-height: 60vh;
  }
  i {
    position: absolute;
    bottom: 4px;
    left: 4px;
    padding: 4px 16px;
    background-color: rgba(0, 0, 0, 0.1);
  }
  .dark i {
    background-color: rgba(0, 0, 0, 0.9);
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
    color: green;
  }
</style>
