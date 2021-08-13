import { EventEmitter } from 'events'
import { KeepLiveWS } from 'bilibili-live-ws'
import request from 'superagent'

infoUrl = 'http://api.bilibili.com/x/space/acc/info?mid='
emitter = new EventEmitter()

export default (id) ->
  live = new KeepLiveWS id
  live.on 'DANMU_MSG', ({ info }) ->
    if info?[1].trim() != '抽签' then return
    user = (await request '/api/proxy?url=' + encodeURIComponent infoUrl + info[2][0]).body
    return if user.code != 0
    avatarUrl = user.data.face
    avatar = await request('/api/proxy?url=' + encodeURIComponent avatarUrl).responseType 'blob'
    emitter.emit 'lot', info[2][1], avatar.body
  return emitter