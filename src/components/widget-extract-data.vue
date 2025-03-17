<script setup>

import { ref, computed } from 'vue'

import WidgetPanels from '@/components/widget-panels.vue'
import WidgetOutput from '@/components/widget-output.vue'

const env = ref(import.meta.env);

const input = ref('');

const output = computed(() => {
  if ( !input.value ) {
    prompt.value = 'No data';
    return [];
  }

  let res = input.value;

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

  let resList = res.split('\n');

  // Order-sensitive parameters
  if ( mode.value.includes("quotes") )
    resList = resList.map(x => x.replaceAll("'", ''));

  if ( mode.value.includes("dquotes") )
    resList = resList.map(x => x.replaceAll('"', ''));

  if ( mode.value.includes("trim") )
    resList = resList.map(s => s.trim());

  if ( mode.value.includes("empty") )
    resList = resList.filter(s => s);

  if ( mode.value.includes("duplicates") )
    resList = [...new Set(resList)];

  if ( mode.value.includes("sort") )
    resList = resList.sort();

  return resList;
});

const prompt = ref('');

const mode = ref(['empty', 'duplicates', 'trim']);

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
  ['quotes',      'Remove single quotes'],
  ['dquotes',     'Remove double quotes'],
  ['trim',        'Remove leading and trailing whitespace'],
  ['empty',       'Remove empty lines'],
  ['duplicates',  'Remove duplicates'],
  ['-', ''],
  ['sort',        'Sort'],
]);

const symbols = ref('');
const subsequence = ref('');
const regexp = ref('');

function clear() {
  input.value = '';
  document.querySelector('.input-box').focus();
}

function copy() {
  navigator.clipboard.writeText( output.value.join('\n') );
}

const nowrap = ref(true);

function toggleWrap() {
  nowrap.value = !nowrap.value;
}

function insertTestData() {
  if ( import.meta.env.DEV ) {
    input.value = `    String1\t1\t2\t\t4\t
    String2;1;\u00222\u0022;;\u00224\u0022;
    String3,1,\u00272\u0027,,\u00274\u0027,
    String4 1 2  4
    String5\u16801\u200a2\u2028\u205f4\ufeff
    String6-1-2--4-
    String7__eol__1__eol__2__eol____eol__4__eol__
    String8__br1__1__br2__2__br3____br4__4__br5__
`
  }
}

</script>

<template>
  <WidgetPanels>
    <template #bar1>
      <button type="button" @click="toggleWrap">{{ `Mode: ${nowrap ? 'nowrap' : 'wrap'}` }}</button>
    </template>
    <template #pane1>
      <textarea v-model="input" class="input-box" :class="{'whitespace-nowrap': nowrap}" placeholder="Raw data" required></textarea>
      <span></span>
      <button class="clear-button" type="button" @click="clear"></button>
    </template>
    <template #bar2>
      <button type="button" @click="copy" :disabled="!output.length">Copy</button>
    </template>
    <template #pane2>
      <WidgetOutput :output="output" :prompt="prompt" />
    </template>
  </WidgetPanels>

  <div class="whitespace-nowrap">
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

    <div v-if="mode.includes('symbols')" class="pt-3">
      <input type="search" id="input_symbols" v-model="symbols" />
      <label for="input_symbols">List all separating characters (spaces are ignored)</label>
    </div>

    <div v-if="mode.includes('subsequence')" class="pt-3">
      <input type="search" id="input_subsequence" v-model="subsequence" />
      <label for="input_subsequence">Enter the sequence</label>
    </div>

    <div v-if="mode.includes('regexp')" class="pt-3">
      <input type="search" id="input_regexp" v-model="regexp" />
      <label for="input_regexp">Enter the regular expression</label>
    </div>
  </div>

  <div v-if="env.DEV" class="whitespace-nowrap" style="padding: 16px; background-color: var(--debug-background-color)">
    <b><i @click="console.log(env)">*** Dev ***</i></b>
    <div>
      <button type="button" @click="insertTestData">Insert test data</button>
    </div>
    <b>Conversion options: {{ mode }}</b>
  </div>
</template>

<style scoped>
  textarea {
    flex-grow: 1;
    display: block;
    resize: none;
    padding: 10px;
    width: 100%;
    border: 1px solid #ccc;
    outline: 0;
    border-radius: 10px;
    color: var(--color-text);
    background-color: var(--color-background);
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
    padding: 0px 12px;
  }

  textarea1 + span::before {
    position: absolute;
    bottom: 10px;
    right: 10px;
  }
  textarea1:invalid {
    border: 1px solid yellow;
  }
  textarea1:invalid + span::before {
    content: "✖";
    color: red;
  }
  textarea1:valid + span::before {
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
  .clear-button::after {
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
