import os, strutils

var file: File
if not file.open("events.json", fmRead):
  quit "file not found"

let size = file.getFileSize()
echo ("file size $1" % [$size])

var buffer: seq[uint8] = @[]
buffer.setLen(size)

let bytesRead = file.readBytes(buffer, 0, size)

echo ("bytes read $1" % [$bytesRead])

var counter = 0
var pos = 0
var prevPos = 0
var maxDiff = 0
var match: int64 = 0
let marker: int64 = 0xA444617461
let mask: int64 = 0xFFFFFFFFFF

for item in buffer:
  match = (match shl 8) or int64(item);
  if (match and mask) == marker:
    counter += 1
    let diff = pos - prevPos
    echo ("match at $1, diff $2" % [$pos, $diff])

    if diff > maxDiff: maxDiff = diff

    prevPos = pos
  pos += 1

echo ("matches $1" % [$counter])
echo ("max diff $1" % [$maxDiff])

file.close()
