<template>
  <div class="gallery">
    <h1 class="wow bounceIn">{{ title }}<span><img src="../assets/mars-logo.gif"/></span></h1>
    <div v-show="busy" class="gallery__loader">
      <span alt="Loading results" title="Loading more results, please wait..."></span>
    </div>
    <div class="gallery__holder wow fadeIn" :style="[busy ? {opacity: 0.3} : {opacity: 1}]" v-infinite-scroll="loadMore" infinite-scroll-disabled="busy" infinite-scroll-distance="limit" data-wow-delay="0.5s">
      <div v-for="picture in 100" :key="picture.id" class="gallery__holder__item">

      </div>

      <div v-show="resultsComplete" class="gallery__holder__results-complete"><span v-text="resutlsCompleteText" class="wow flipInY" data-wow-delay="0.3s"></span></div>
    </div>
  </div>
</template>

<script>
import axios from "axios";
import WOW from 'wowjs';
const infiniteScroll = require('vue-infinite-scroll');
const api = 'https://localhost:3000';

export default {
  name: "Gallery",
  directives: { infiniteScroll },
  data() {
    return {
      pictures: [],
      totalResults: null,
      limit: 10,
      busy: false,
      resultsComplete: false,
      resutlsCompleteText: 'no more results'
    }
	},
  props: {
    title: String,
  },
 
  methods: {
		loadMore() {

      if(this.pictures.length == this.totalResults) {
        this.busy = false;
        this.resultsComplete = true;
        return
      }
			
			// Sets the application state to "busy".
			this.busy = true;
			
			// Sends a get request to the API endpoint.
			axios.get(api).then(response => {
        this.totalResults = response.data.length;
				const append = response.data.slice(
					this.pictures.length,
					this.pictures.length + this.limit
				);

				this.pictures = this.pictures.concat(append);
				this.busy = false;
			})
		}
	},
  created() {
    this.loadMore();
  },
  mounted(){
    let wow = new WOW.WOW({
      boxClass: 'wow',
      animateClass: 'animated',
      offset: 0,
      mobile: true,
      live: true
    });
    wow.init();
  }
};
</script>

<style scoped lang="scss">
$lightGray: lightgray;
$coral: coral;

.gallery {
  width: 100%;
  background: gray;
  padding: 20px 0 0 30px;
  margin: 0 0 0 150px;
  @media screen and (min-width: 769px) {
    margin: 0 30px 0 240px;
  }

  h1 {
    color: $lightGray;
    text-shadow: 2px 2px rgba(#000000, 0.5);
    border-bottom: 2px solid rgba(114, 114, 114, 0.4);
    padding-bottom: 30px;
    margin: 0 24px 5px 0px;
    letter-spacing: 0.1rem;
    transition: color 0.3s linear;
    display: flex;
    align-items: flex-start;
    justify-content: center;
    position: relative;
    min-width: 332px;
    font-size: 2rem;
    @media screen and (min-width: 769px) {
      font-size: 2.5rem;
    }
    span {
      position: absolute;
      margin-left: -28px;
      img {
        height:35px;
        width: auto;
        @media screen and (min-width: 769px) {
          height:40px;
        }
      }
    }
    &:hover {
      color: $coral;
    }
  }

  &__loader {
    display: flex;
    justify-content: center;
    border-bottom: 2px solid rgba(114, 114, 114, 0.4);
    margin-right: 24px;
    span {
      border: 6px solid $lightGray;
      border-top: 6px solid $coral;
      border-radius: 50%;
      width: 20px;
      height: 20px;
      margin: 10px 0;
      animation: spin 2s linear infinite;
    }
  }

  &__holder {
    display: flex;
    flex-wrap: wrap;
    overflow-y: auto;
    height: calc(100vh - 120px);
    padding: 16px 0 0 10px;
    min-width: 342px;

    &__item {
      height: 80px;
      width: 100%;
      max-width: 140px;
      @media screen and (min-width: 769px) {
        height: 200px;
        max-width: 300px;
      }
      border: 1px solid $lightGray;
      display: flex;
      align-items: center;
      justify-content: center;
      margin: 0 20px 20px 0;
      border-radius: 25px;
      transition: all .3s linear;
      &:hover {
        outline: 1px solid $lightGray;
        box-shadow: 0px 10px 5px 5px rgba(86, 86, 86, 0.75);
        transform: skew(1deg);
      }
      @keyframes spin {
        0% { transform: rotate(0deg); }
        100% { transform: rotate(360deg); }
      }
    }
    &__results-complete {
      font-weight: bold;
      width: 100%;
      display: flex;
      justify-content: center;
      background: $lightGray;
      border-bottom: 4px solid $coral;
    }
  }
}
</style>
