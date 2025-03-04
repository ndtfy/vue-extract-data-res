<script setup lang="ts">

import { ref, computed } from 'vue'

import WidgetPanels from '@/components/widget-panels.vue'

const input = ref('')

const output = computed(() => {
  if ( !input.value ) {
    prompt.value = 'No data'
    return ''
  }

  let res = input.value

  mode.value.forEach( item => {
    switch ( item ) {
      case "tab":
        res = res.replaceAll('\t', '\n');
        break;

      case "semicolon":
        res = res.replaceAll(';', '\n');
        break;

      case "comma":
        res = res.replaceAll(',', '\n');
        break;

      case "space":
        res = res.replaceAll(' ', '\n');
        break;

      case "whitespaces":
        res = res.replace(/\s+/g, '\n');
        break;

      case "symbols":
        if ( symbols.value )
          res = res.replaceAll(symbols.value, '\n');
        break;

      case "subsequence":
        if ( subsequence.value )
          res = res.replaceAll(subsequence.value, '\n');
        break;

      case "regexp":
        if ( regexp.value ) {
          const re = new RegExp(regexp.value, 'g');
          res = res.replace(re, '\n');
        }
        break;
    }
  })

  let resList = res.split('\n')
  mode.value.forEach( item => {
    switch ( item ) {
      case "empty":
        resList = resList.filter(s => s);
        break;
    }
  })

  // Order-sensitive parameters
  if ( mode.value.includes("trim") )
    resList = resList.map(s => s.trim())

  if ( mode.value.includes("duplicates") )
    resList = [...new Set(resList)]

  res = resList.join('\n')

  return res
})

const prompt = ref('')

const mode = ref([] as String[])

const modeList = ref([
  ['tab',         'Tab'],
  ['semicolon',   'Semicolon'],
  ['comma',       'Comma'],
  ['space',       'Space'],
  ['whitespaces', 'Whitespaces (always treat consecutive delimiters as one)'],
  ['symbols',     'Symbols'],
  ['subsequence', 'Sequence'],
  ['regexp',      'Regular expression'],
  ['-', ''],
  ['trim',        'Remove leading and trailing whitespace'],
//['consecutive', 'Treat consecutive delimiters as one'],
  ['empty',       'Remove empty lines'],
  ['duplicates',  'Remove duplicates'],
])

const symbols = ref('')
const subsequence = ref('')
const regexp = ref('')

function clear() {
  input.value = '';
  (window.document.querySelector('.input-box') as HTMLElement)?.focus();
}

function copy() {
  navigator.clipboard.writeText(output.value);
}

</script>

<template>
  <WidgetPanels>
    <template #pane1>
      <div class="pane">
        <textarea v-model="input" class="input-box" placeholder="Raw data" required></textarea>
        <span></span>
        <button class="clear-button" type="button" @click="clear"></button>
      </div>
    </template>
    <template #pane2>
      <div class="pane">
        <textarea v-model="output" :placeholder="prompt" readonly></textarea>
        <button type="button" @click="copy">Copy</button>
      </div>
    </template>
  </WidgetPanels>

  <b>Conversion options:</b>
  <ul>
    <template v-for="item in modeList">
    <li v-if="item[1]">
      <input type="checkbox" :id="item[0]" :value="item[0]" v-model="mode" />
      <label :for="item[0]">{{ item[1] }}</label>
    </li>
    <p v-else>
      <br />
    </p>
    </template>
  </ul>

  <div v-if="mode.includes('symbols')" class="pt-5">
    <input type="search" id="input_symbols" v-model="symbols" />
    <label for="input_symbols">List all separating characters (spaces are ignored)</label>
  </div>

  <div v-if="mode.includes('subsequence')" class="pt-5">
    <input type="search" id="input_subsequence" v-model="subsequence" />
    <label for="input_subsequence">Enter the sequence</label>
  </div>

  <div v-if="mode.includes('regexp')" class="pt-5">
    <input type="search" id="input_regexp" v-model="regexp" />
    <label for="input_regexp">Enter the regular expression</label>
  </div>

  <hr />

  <button type="button" @click="input=`    String1\t1\t2\t\t4\t
    String2;1;2;;4;
    String3,1,2,,4,
    String4 1 2  4
    String5\u16801\u200a2\u2028\u205f4\ufeff
    String6-1-2--4-
    String7__eol__1__eol__2__eol____eol__4__eol__
    String8__br1__1__br2__2__br3____br4__4__br5__
`">Insert test data</button>
  <div>
    <b>Conversion options: {{ mode }}</b>
  </div>

</template>

<style scoped>
  .pane {
    position: relative;
    height: 100%;
    display: flex;
    flex-direction: column;
  }
  textarea {
    flex-grow: 1;
    display: block;
    resize: vertical;
    padding: 10px;
    width: 100%;
    min-height: 200px;
    resize: none;
    border: 0px;
    border: 1px solid #ccc;
    outline: 0;
    border-radius: 15px;
  }
  textarea:focus {
    box-shadow: 0 0 15px 5px #b0e0ee;
    border: 1px solid #bebede;
  }

  ul {
    padding: 0px 20px;
    list-style-type: none;
  }
  label {
    padding: 0px 20px;
  }
  .pt-5 {
    padding: 20px 0px 0px 0px;
  }

  textarea1 + span:before {
    position: absolute;
    bottom: 10px;
    right: 10px;
  }
  textarea1:invalid {
    border: 1px solid yellow;
  }
  textarea1:invalid + span:before {
    content: "✖";
    color: red;
  }
  textarea1:valid + span:before {
    content: "✓";
    color: green;
  }

  .input-box:not(:valid) ~ .clear-button {
    display: none;
  }

  .clear-button {
    position: absolute;
    top: 0px;
    right: 0px;
    border: 1px solid transparent;
    background-color: transparent;
    display: inline-block;
    vertical-align: middle;
    outline: 0;
    cursor: pointer;
  }
  .clear-button:after {
    position: absolute;
    top: 0px;
    right: 0px;
    color: white;
    background-color: tomato;
    padding: 2px;
    display: block;
    width: 20px;
    height: 20px;
    border-radius: 2px;
    box-shadow: 0 0 2px red;
    content: "✖";
    text-align: center;
    font-weight: normal;
    font-size: 12px;
    cursor: pointer;
  }
</style>
