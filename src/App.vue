<template>
  <div id="app">
    <aside id="sidebar">
      
    </aside>
    <Gallery title="The M -- rs Files" />
  </div>
</template>

<script>
import Gallery from "./components/Gallery.vue";

export default {
  name: "App",
  components: {
    Gallery,
  },
};
</script>

<style lang="scss">
$coral: coral;
$fontColor: #2c3e50;

html {
  overflow: hidden;
}

body {
  margin: 0;
  background: rgb(64, 92, 64);
}

::-webkit-scrollbar {
    width: 12px;
}
 
::-webkit-scrollbar-track {
    -webkit-box-shadow: inset 0 0 6px rgba(0,0,0,0.3); 
    -webkit-border-radius: 10px;
    border-radius: 10px;
}
 
::-webkit-scrollbar-thumb {
    -webkit-border-radius: 10px;
    border-radius: 10px;
    background: $coral; 
    -webkit-box-shadow: inset 0 0 6px rgba(0,0,0,0.5); 
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
    -webkit-box-shadow: inset 0 0 6px rgba(0,0,0,0.5); 
    width: 150px;
    @media screen and (min-width: 769px) {
      width: 250px;
    }
  }
}
</style>
