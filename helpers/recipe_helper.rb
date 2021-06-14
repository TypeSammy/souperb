def line_break(ingredients)
  string = ingredients
  string.gsub! "\r\n", "<br><br>"
end