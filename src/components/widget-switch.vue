<script setup>

// https://codepen.io/saurabh_sharma/pen/borWxP

import { toRefs } from 'vue'

const props = defineProps({
  checked: {
    type: Boolean,
    default: false
  },
  onChange: {
    type: Function,
    default() {
      return;
    }
  }
});

const { checked, onChange } = toRefs(props);

</script>

<template>
  <input type="checkbox" :checked @change="onChange" />
</template>

<style scoped>
  input {
    position: relative;
    appearance: none;
    -moz-appearance: none;
    -webkit-appearance: none;
    width: 60px;
    height: 30px;
    background: #ddd;
    border-radius: 30px;
    transition: background 0.09s ease-in-out;
    color: #fff;
    outline: none;
  }
  input:checked {
    background: #3af;
  }
  input::after {
    position: absolute;
    content: '';
    width: 30px;
    height: 30px;
    background: #fff;
    border-radius: 50%;
    transform: scale(0.8);
    left: 0;
    top: 0;
    transition: left 0.09s ease-in-out;
    box-shadow: 1px 1px #ccc;
  }
  input:checked::after{
    left: 30px;
  }
</style>
