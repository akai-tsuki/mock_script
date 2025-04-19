#!/bin/bash

# 何番目の引数から無視するか（1始まり）
IGNORE_FROM=6

processed_args=()
index=1

for arg in "$@"; do
  if (( index >= IGNORE_FROM )); then
    break
  fi

  if [[ "$arg" == -* ]]; then
    processed_args+=("${arg#-}")  # "-"を取り除く
  else
    processed_args+=("$arg")
  fi

  ((index++))
done

# _ で連結してファイル名に変換
filename=$(IFS=_; echo "${processed_args[*]}")
filepath="data/${filename}.txt"

# 出力 or エラー
if [[ -f "$filepath" ]]; then
  cat "$filepath"
else
  echo "Error: File not found for command '$*'" >&2
  echo "Expected file: $filepath" >&2
  exit 1
fi
