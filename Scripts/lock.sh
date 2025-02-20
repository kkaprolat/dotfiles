#!/bin/bash
set -x

if [[ $(hostname) == 'Magnesium' ]]
then
    p='/home/kay/Wallpapers'
elif [[ $(hostname) == 'Technetium' ]]
then
    #p='/run/media/kay/D0-P1/Bibliotheken/Bilder/Wallpaper/dump'
    p='/home/kay/Pictures/Wallpapers'
fi

images=()

while IFS= read -r output; do
    img="$(find "$p" -type f | sort -R | head -n 1)"
    magick "$img" -filter Gaussian -blur 0x8 "$img"_blurred
    images+=("$img"_blurred)
    echo "$output"
    echo "${images[@]}"
done <<< "$(swww query | sed 's/:.*$//g')"

if [[ ${#images[@]} == 1 ]]
then
    swaylock -ftFkl -c 000000 --font "Cantarell" --inside-color 00000000 \
        -s fill \
            -i "eDP-1:${images[0]}" \
            -i "DP-1:${images[0]}" \
            -i "DP-2:${images[0]}"

elif [[ ${#images[@]} == 0 ]]
then
    swaylock -ftFkl -c 000000 --font "Cantarell" --inside-color 00000000
else
    swaylock -ftFkl -c 000000 --font "Cantarell" --inside-color 00000000 -s fill \
        -i "eDP-1:${images[0]}"\
        -i "DP-1:${images[1]}"\
        -i "DP-2:${images[0]}"
fi

for image in "${images[@]}"; do
    rm "$image"
done
