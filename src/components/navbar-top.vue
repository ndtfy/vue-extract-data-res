<script setup>

import { ref } from 'vue'

import WidgetSwitchTheme from '@/components/widget-switch-theme.vue'

const switchTheme = ref();

</script>

<template>
  <header>
    <ul>
      <li><a href=".">Home</a></li>
      <!--li class="dropdown">
        <a href="javascript:void(0)" class="dropbtn">Theme</a>
        <div class="dropdown-content">
          <a href="#" @click.prevent="switchTheme.toggleDarkMode(false)">Light</a>
          <a href="#" @click.prevent="switchTheme.toggleDarkMode(true)">Dark</a>
          <a href="#" @click.prevent="switchTheme.toggle()">Toggle</a>
        </div>
      </li-->
    </ul>
    <WidgetSwitchTheme ref="switchTheme" />
  </header>
</template>

<style>
  :root {
    --navbar-top-color: #ffffff;
    --navbar-top-background-color: #2f8f8f;
    --navbar-top-background-color-hover: #9f7fef;
    --navbar-top-dropdown-color: #000000;
    --navbar-top-dropdown-background-color: #bfbfef;
    --navbar-top-dropdown-background-color-hover: #dfdfff;
  }
  :root.dark {
    --navbar-top-color: #ffffff;
    --navbar-top-background-color: #2f8f8f;
    --navbar-top-background-color-hover: #9f7fef;
    --navbar-top-dropdown-color: #000000;
    --navbar-top-dropdown-background-color: #bfbfef;
    --navbar-top-dropdown-background-color-hover: #dfdfff;
  }
</style>

<style scoped>
  header {
    position: sticky;
    top: 0;
    display: flex;
    justify-content: start;
    align-items: center;
    padding: 0px 16px;
    z-index: 100;
    background-color: var(--navbar-top-background-color);
  }
  ul {
    flex-grow: 1;
    list-style-type: none;
    margin: 0;
    padding: 0;
    overflow: hidden;
  }
  li {
    float: left;
  }
  li a,
  .dropbtn {
    display: inline-block;
    color: var(--navbar-top-color);
    text-align: center;
    padding: 12px 16px;
    text-decoration: none;
  }
  li a:hover,
  .dropdown:hover .dropbtn {
    background-color: var(--navbar-top-background-color-hover);
  }
  .dropdown {
    display: inline-block;
  }
  .dropdown-content {
    display: none;
    position: absolute;
    background-color: var(--navbar-top-dropdown-background-color);
    min-width: 160px;
    box-shadow: 0px 8px 16px 0px rgba(0, 0, 0, 0.2);
  }
  .dropdown:hover .dropdown-content {
    display: block;
  }
  .dropdown-content a {
    display: block;
    color: var(--navbar-top-dropdown-color);
    text-align: left;
    padding: 12px 16px;
    text-decoration: none;
  }
  .dropdown-content a:hover {
    background-color: var(--navbar-top-dropdown-background-color-hover);
  }
</style>
