<template>
  <v-app class="fill-height">
    <v-main class="fill-height">
      <v-carousel
        :show-arrows="true"
        :continuous="false"
        :cycle="cycle"
        interval="2000"
        height="100%"
        hide-delimiters
      >
        <v-carousel-item v-for="(item, i) in items" :key="i">
          <div class="fill-height">
            <div class="top">
              <div
                class="top-center"
                :style="{ width: (item.width || 0) + 'px' }"
              >
                <div class="avatar">
                  <v-avatar size="70">
                    <v-img :src="item.avatar"></v-img>
                  </v-avatar>
                </div>
                <div class="name">{{ item.name }}</div>
              </div>
            </div>
            <div class="rest">
              <img
                :src="item.src"
                @load="$event.target.item = item; mesure($event.target)"
                ref="imgs"
              />
            </div>
          </div>
        </v-carousel-item>
      </v-carousel>
    </v-main>
  </v-app>
</template>

<script lang="coffee">
import sample from 'lodash.sample'
import img from './assets/img/*.jpg'
import { getImgSizeInfo } from './utils'
import bilibili from './bilibili'

cards = [
  [1, 3]
  [2, 9]
  [3, 17]
  [4, 17]
  [5, 17]
  [6, 17]
  [7, 17]
].reduce ((acc, [num, probability]) ->
  for i in [1..probability]
    acc.push num
  return acc
), []
emitter = bilibili 12694411
export default
  name: 'app'
  data: ->
    items: []
    cycle: true
  methods: {
    mesure: (target) -> @$set(target.item, 'width', getImgSizeInfo(target).width)
    pushLot: (i, avatar, name) ->
      @items.push { src: img[i], avatar, name }
      @cycle = false
      await @$nextTick()
      @cycle = true
  }
  mounted: ->
    window.addEventListener 'resize', => @$refs.imgs?.forEach (target) => @mesure(target)
    emitter.on 'lot', (name, avatar) =>
      @pushLot sample(cards), URL.createObjectURL(avatar), name
</script>

<style scoped>
img {
  object-fit: contain;
  height: 100%;
  width: 100%;
}
.top {
  height: 130px;
  width: 100%;
}
.top-center {
  height: 100%;
  margin: 0 auto;
  background-color: #f5f2d3;
  display: flex;
  justify-content: center;
  align-items: center;
  overflow: hidden;
}
.rest {
  height: calc(100% - 130px);
}

.avatar {
  margin-left: 20px;
  margin-right: 10px;  
}

.name {
  margin-left: 10px;
  margin-right: 20px;
  word-break: break-all;
  width: calc(100% - 70px - 100px);
  text-align: center;
  font-family: www;
  font-weight: bold;
  font-size: 35px;
  line-height: 35px;
}
</style>

<style>
html,
body {
  width: 100%;
  height: 100%;
  overflow: hidden;
}

@font-face {
  font-family: www;
  src: url("./assets/font/font.ttf");
}
</style>