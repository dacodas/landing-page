# TODO: Let's hammer this script out

```bash
#!/bin/bash

IMAGE=waterfall

convert $IMAGE.jpg -resize 40x40 $IMAGE-small.jpg
SMALL_JPG_BASE64_ENCODED=$(cat $IMAGE-small.jpg | base64 -w0)

cat <<EOF > "${IMAGE}-small.svg"
<svg xmlns="http://www.w3.org/2000/svg"
     xmlns:xlink="http://www.w3.org/1999/xlink"
     width="$WIDTH" height="$HEIGHT"
     viewBox="0 0 $WIDTH $HEIGHT">
  <filter id="blur" filterUnits="userSpaceOnUse" color-interpolation-filters="sRGB">
    <feGaussianBlur stdDeviation="20 20" edgeMode="duplicate" />
    <feComponentTransfer>
      <feFuncA type="discrete" tableValues="1 1" />
    </feComponentTransfer>
  </filter>
  <image filter="url(#blur)"
         xlink:href="data:image/jpeg;base64,$SMALL_JPG_BASE64_ENCODED"
         x="0" y="0"
         height="100%" width="100%"/>
</svg>
EOF

SVG_URI_ENCODED=$(<$IMAGE-small.svg python3 -c "import sys;import urllib.parse; print(urllib.parse.quote(sys.stdin.read()))")

cat <<EOF
    background-image: url(data:image/svg+xml;charset=utf-8,$SVG_URI_ENCODED);
EOF
```
