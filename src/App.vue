<template>
  <div id="app">
    <aside id="sidebar">
      <select @change="onChange($event)">
        <option selected disabled hidden>{{ roverSelectionTitle }}</option>
        <option v-for="(rover, index) in rovers" :key="index" :value="rover">
          {{ rover }}
        </option>
      </select>
    </aside>
    <Gallery title="The M -- rs Files" :roverType="selected" />
  </div>
</template>

<script>
import Gallery from "./components/Gallery.vue";

export default {
  name: "App",
  components: {
    Gallery,
  },
  data() {
    return {
      selected: "",
      roverSelectionTitle: "Choose a Rover:",
      rovers: ["curiosity", "opportunity", "spirit"],
    };
  },
  methods: {
    onChange(event) {
      this.selected = event.target.value;
    },
  },
};
</script>

<style lang="scss">
$coral: coral;
$fontColor: #2c3e50;

* {
  outline: 0;
}

html {
  overflow: hidden;
}

select {
  height: 30px;
  padding: 0 8px;
}

body {
  margin: 0;
  background: rgb(64, 92, 64);
}

::-webkit-scrollbar {
  width: 12px;
}

::-webkit-scrollbar-track {
  -webkit-box-shadow: inset 0 0 6px rgba(0, 0, 0, 0.3);
  -webkit-border-radius: 10px;
  border-radius: 10px;
}

::-webkit-scrollbar-thumb {
  -webkit-border-radius: 10px;
  border-radius: 10px;
  background: $coral;
  -webkit-box-shadow: inset 0 0 6px rgba(0, 0, 0, 0.5);
}

::-webkit-scrollbar-thumb:window-inactive {
  background: $coral;
}

#app {
  font-family: Avenir, Helvetica, Arial, sans-serif;
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
  text-align: center;
  color: $fontColor;
  display: flex;
  height: 100vh;
  user-select: none;
  margin: 0;
  @media screen and (min-width: 769px) {
    margin: 0 10%;
  }

  #sidebar {
    position: fixed;
    height: 100%;
    background: $coral;
    display: flex;
    padding-top: 150px;
    justify-content: center;
    -webkit-box-shadow: inset 0 0 6px rgba(0, 0, 0, 0.5);
    width: 150px;
    @media screen and (min-width: 769px) {
      width: 250px;
    }
  }
}
</style>
