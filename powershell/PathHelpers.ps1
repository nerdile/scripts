Function Normalize-Path($root, $leaf) {
  return $leaf.FullName.Substring($root.FullName.Length + 1)
}

Function Strip-Suffix ($suffix, $fn) {
  if ($fn.ToLower().EndsWith($suffix.ToLower())) {
    return $fn.SubString(0, $fn.Length - $suffix.Length);
  } else {
    throw "Does not end with $suffix : $fn";
  }
}
