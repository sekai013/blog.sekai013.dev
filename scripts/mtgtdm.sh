#!/bin/bash

## fetch card image
curl https://api.scryfall.com/cards/search?q=set%3Atdm | jq -r '.data[] | @sh "\(.image_uris.png) \(.name).png"' | xargs -r -L1 sh -c 'curl -s "$0" -o "content/posts/mtgtdm/img/$1"'

## card lists sorted by color to create prompt
curl 'https://api.scryfall.com/cards/search?q=set%3Atdm&order=color' | jq -r '.data[].name' > cardlist.txt