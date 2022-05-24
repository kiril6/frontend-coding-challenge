<template>
  <div class="gallery">
    <h1 class="wow bounceIn">{{ title }}<span><img src="../assets/mars-logo.gif"/></span></h1>
    <div v-show="busy" class="gallery__loader">
      <span alt="Loading results" title="Loading more results, please wait..."></span>
    </div>
    <div class="gallery__holder wow fadeIn" :style="[busy ? {opacity: 0.3} : {opacity: 1}]" v-infinite-scroll="loadMore" infinite-scroll-disabled="busy" data-wow-delay="0.5s">
      <div v-for="(picture, index) in pictures" :key="index" @click="pictureOpen(picture.img_src)" class="gallery__holder__item" :style="{'background-image':'url(' + picture.img_src + ')'}">
        <span v-text="'#' + picture.id"></span>
      </div>
      <span> {{ errorMessage }}</span>
      <div v-show="resultsEnd" class="gallery__holder__results-complete"><span v-text="resultsEndText" class="wow flipInY" data-wow-delay="0.3s"></span></div>
    </div>
  </div>
</template>

<script>
import axios from "axios";
import WOW from 'wowjs';
const infiniteScroll = require('vue-infinite-scroll');

export default {
  name: "Gallery",
  directives: { infiniteScroll },
  data() {
    return {
      pictures: [],
      totalResults: null,
      page: 1,
      busy: false,
      resultsEnd: false,
      resultsEndText: 'reached end of results',
      errorMessage: ''
    }
	},
  props: {
    title: String,
    roverType: {
      type: String,
      default: '',
      required: true
    },
  },

  watch: { 
    roverType: function(newVal, oldVal) {
      if(oldVal !== newVal) {        
        this.pictures = [];
        this.page = 1;
        this.resultsEnd = false;
        this.loadMore();
      }
    }
  },
 
  methods: {
		loadMore() {
      // If no dropdown selection is done no request will be triggered.
      if(this.roverType === '') {
        return;
      }

      // If error message from before will be cleared
      this.errorMessage = '';
      // Starts the loader
      this.busy = true;

			const api_key = 'CtxPWweZfBxecIanMNKrxfSBpOsGS0yWtBOyk3rE';
      let api = `https://api.nasa.gov/mars-photos/api/v1/rovers/${this.roverType}/photos?sol=1000&page=${this.page}&api_key=${api_key}`;
			
			// Sends a get request to the API endpoint.
			axios.get(api).then(response => {
        this.totalResults = response.data.photos.length;
				this.pictures = this.pictures.concat(response.data.photos);
        // if request passes its appending next page number for the next call
        this.page++;
        this.busy = false;
        // If not received length of data from page
        if(this.totalResults < 1) {
          this.resultsEnd = true;
        }
			}).catch((err) => this.errorMessage = err, this.busy = false)
		},

    // Opens image on click in new tab
    pictureOpen(source) {
      window.open(source);
    }
	},
  mounted(){
    // Css animation library
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

    span:empty {
      display: none;
    }

    &__item {
      background-position: center;
      background-repeat: no-repeat;
      background-size: cover;
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
      span {
        visibility: hidden;
      }
      &:hover {
        outline: 1px solid $lightGray;
        box-shadow: 0px 10px 5px 5px rgba(86, 86, 86, 0.75);
        transform: skew(1deg);
        position: relative;
        cursor: pointer;

        span {
          position: absolute;
          bottom: 8px;
          right: 8px;
          border-radius: 5px;
          padding: 0 4px;
          font-weight: bold;
          font-size: 0.8em;
          background-color: rgba(#2c3e50, 0.7);
          color: $lightGray;
          visibility: visible;
        }
 
        &:after {
          position: absolute;
          top: 10px;
          left: 0;
          border-top-left-radius: 8px;
          border-bottom-right-radius: 8px;
          font-weight: bold;
          background-color: rgba($lightGray, 0.7);
          padding: 0 10px 0 10px;
          content: 'click on image to view'
        }
      }
      @keyframes spin {
        0% { transform: rotate(0deg); }
        100% { transform: rotate(360deg); }
      }
    }
    &__results-complete {
      font-weight: bold;
      height: 20px;
      width: 100%;
      display: flex;
      justify-content: center;
      align-self: self-end;
      background: $lightGray;
      border-bottom: 4px solid $coral;
    }
  }
}
</style>
