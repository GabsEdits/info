#!/bin/bash

UPDATES_DIR="updates"
OUTPUT_FILE="${UPDATES_DIR}/_index.json"
COMBINED_DATA=()

echo -n "" > ${OUTPUT_FILE}

for FILE in $(ls ${UPDATES_DIR}/*.json | sort -r); do
  if [ $(basename ${FILE}) == "_index.json" ]; then
    continue
  fi
  FILE_CONTENT=$(cat ${FILE})
  FILE_NAME=$(basename ${FILE} .json)
  COMBINED_DATA+=("\"${FILE_NAME}\": ${FILE_CONTENT}")
done

echo "{" > ${OUTPUT_FILE}

for ((i = 0; i < ${#COMBINED_DATA[@]}; i++)); do
   if [ $i -ne 0 ] && [ $i -lt "$((${#COMBINED_DATA[@]} -1))" ]; then
    echo "${COMBINED_DATA[$i]}," >> ${OUTPUT_FILE}
  else
    echo "${COMBINED_DATA[$i]}" >> ${OUTPUT_FILE}
  fi
done

echo "}" >> ${OUTPUT_FILE}
