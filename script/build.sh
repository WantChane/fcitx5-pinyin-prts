#!/usr/bin/env bash

set -euo pipefail

shopt -s nullglob

echo "开始处理..."

echo "清理input和output目录中的旧文件..."

find input/ -maxdepth 1 -type f -not -name 'fixfile.json' -delete
find output/ -maxdepth 1 -type f -not -name '.gitkeep' -delete

for py_file in script/prts_*.py; do
    echo "正在处理: ${py_file}"
    python "${py_file}"
done

cp -v output/prts_* input/

for py_file in prts_*.py; do
    echo "正在处理: ${py_file}"
    mw2fcitx -c "${py_file}"
done

echo "所有文件处理完成！"