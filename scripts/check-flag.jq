def extract_flags:
  if type == "array" then .
  elif (.flags | type) == "array" then .flags
  elif (.flags | type) == "object" then (.flags | to_entries | map(.value + {name: (.value.feature.name // .value.name // .key)}))
  else []
  end;

[extract_flags[] | select((.feature.name // .name) == $fname) | .enabled] | .[0] // false