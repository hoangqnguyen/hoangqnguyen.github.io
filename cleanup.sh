#!/bin/bash

input_file="$1"
output_file="tmp.md"

in_code_block=false
found_python=false
found_sof=false
found_eof=false

while IFS= read -r line; do
  # If we find the first ```python, mark that we've found it and skip it
  if [[ "$line" == '```python' && "$found_python" == false ]]; then
    found_python=true
    in_code_block=true
    continue
  fi

  # If we find the first ```, exit the block and skip it
  if [[ "$line" == '```' && "$in_code_block" == true ]]; then
    in_code_block=false
    continue
  fi

  # Skip the first SOF and EOF
  if [[ "$line" == '"""SOF' && "$found_sof" == false ]]; then
    found_sof=true
    continue
  fi

  if [[ "$line" == 'EOF""";' && "$found_eof" == false ]]; then
    found_eof=true
    continue
  fi

  # Print the line if we're not in the first python block and it's not SOF/EOF
  echo "$line" >> "$output_file"
done < "$input_file"

# Replace the original file with the cleaned-up version
mv "$output_file" "$input_file"
