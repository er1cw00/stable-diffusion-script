#!/bin/bash

if [ $# != 3 ]; then
    echo "image_rename.sh INPUT OUTPUT PREFIX"
    echo "your command: image_rename.sh $@"
    exit 1
fi

INPUT=$(realpath $1)
OUTPUT=$(realpath $2)
PREFIX=$3
MAX_RESOLUTION=1024

if  [ ! -d "$INPUT" ]; then
    echo "$INPUT is not a directory."
    exit 1
fi

echo "encode all images in ${INPUT} to ${OUTPUT}/xxxx.jpg >>"

FILES=`ls ${INPUT}`
mkdir -p "${OUTPUT}"

INDEX=1
RESIZE_CMD="${MAX_RESOLUTION}x${MAX_RESOLUTION}>"
echo "${RESIZE_CMD}"

for FILE in $FILES; 
do 
    NAME="${FILE%.*}"
    EXT=${FILE##*.}
    NEW_FILE="${PREFIX}_${INDEX}.jpg"
    INDEX=$((INDEX+1))
    echo "transfor ${FILE} -> ${NEW_FILE}"
    #ffmpeg -i "${INPUT}/${FILE}" -f image2 -y -vf scale=${MAX_RESOLUTION}:-1 "${OUTPUT}/${NEW_FILE}" 1>/dev/null 2>/dev/null
    #sips -Z ${MAX_RESOLUTION} "${OUTPUT}/${NEW_FILE}" 1>/dev/null 
    magick "${INPUT}/${FILE}" -resize ${RESIZE_CMD} "${OUTPUT}/${NEW_FILE}"
done

