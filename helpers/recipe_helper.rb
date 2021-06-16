def line_break(ingredients)
  string = ingredients
  string.gsub! "\r\n", "<br><br>"
end

def string_to_0(string)
  string == "" ? 0 : string
end

def checkbox_conversion(params)
  result = false
  if params == "on"
    result = true
  end
  result
end