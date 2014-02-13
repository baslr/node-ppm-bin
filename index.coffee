fs  = require 'fs'
PNG =  require('pngjs').PNG

module.exports.convert = (from, to, cb) ->
  bf = fs.readFileSync from
  
  i=0
  return cb(true) if bf[i] isnt 0x50 or bf[++i] isnt 0x36 # 'P6 Portable pixmap Binary
  
  i++ # jump over 0x0A
  
  tmp = ''
  while bf[++i] isnt 0x0A
    tmp += String.fromCharCode bf[i]
  
  [x, y] = tmp.split ' '
  x = Number x
  y = Number y
  
  tmp = ''
  while bf[++i] isnt 0x0A
    tmp += String.fromCharCode bf[i]
  
  return cb(true) if 255 isnt Number tmp
  
  bf = bf.slice i
  
  tmpBuff = new Buffer x * y * 4
  tmpBuff.fill 0xff
  
  i = 0
  while i < x * y
    bf.copy tmpBuff, i*4, i*3, i*3+3
    i++
  
  png = new PNG { width : x, height : y}
  
  tmpBuff.copy png.data
  stream = fs.createWriteStream to
  png.pack().pipe stream
  
  stream.on 'close', () ->
    cb null
