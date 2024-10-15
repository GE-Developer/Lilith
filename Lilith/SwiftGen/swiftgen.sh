#!/usr/bin/env sh

# Исправляем PATH без пробела
export PATH="$PATH:/opt/homebrew/bin"

# Массив для выходных файлов
OUTPUT_FILES=()

# Установка значения по умолчанию, если переменная не определена
if [ -z "$SCRIPT_OUTPUT_FILE_COUNT" ]; then
  SCRIPT_OUTPUT_FILE_COUNT=0
fi

# Счётчик для обработки выходных файлов
COUNTER=0

# Цикл по количеству выходных файлов
while [ $COUNTER -lt ${SCRIPT_OUTPUT_FILE_COUNT} ];
do
    tmp="SCRIPT_OUTPUT_FILE_$COUNTER"
    OUTPUT_FILES+=("${!tmp}") # Добавляем файлы в массив
    COUNTER=$((COUNTER+1))
done

# Установка прав на запись для выходных файлов
for file in "${OUTPUT_FILES[@]}"
do
    if [ -f "$file" ]; then
        chmod a=rw "$file"
    fi
done

# Запуск SwiftGen с указанным конфигурационным файлом
if which swiftgen > /dev/null; then
    swiftgen config run --config "${SRCROOT}/Lilith/SwiftGen/swiftgen.yml"
else
    echo "warning: SwiftGen не установлен, скачайте его с https://github.com/SwiftGen/SwiftGen"
    exit 1
fi

# Установка прав только на чтение для выходных файлов
for file in "${OUTPUT_FILES[@]}"
do
    chmod a=r "$file"
done
