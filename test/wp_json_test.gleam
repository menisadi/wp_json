import gleam/string
import gleeunit
import wp_json

pub fn main() -> Nil {
  gleeunit.main()
}

pub fn parse_line_test() {
  let input = "6/26/25, 20:12 - Meni Sadigurschi: Hello world"
  let expected = ["6/26/25", "20:12", "Meni Sadigurschi", "Hello world"]
  assert wp_json.parse_line(input) == expected
}

pub fn parse_line_ok_test() {
  let input = "6/26/25, 20:12 - Meni Sadigurschi: Hello world"
  let expected = ["6/26/25", "20:12", "Meni Sadigurschi", "Hello world"]
  assert wp_json.parse_line(input) == expected
}

pub fn parse_lines_multiple_test() {
  let text =
    "6/26/25, 20:12 - Meni Sadigurschi: First message
6/26/25, 20:13 - Meni Sadigurschi: Second message"

  let splitted = string.split(text, on: "\n")
  let expected = [
    ["6/26/25", "20:12", "Meni Sadigurschi", "First message"],
    ["6/26/25", "20:13", "Meni Sadigurschi", "Second message"],
  ]
  assert wp_json.parse_lines(splitted, []) == expected
}

pub fn parse_line_fail_test() {
  let bad_input = "this line has no commas or colons"
  let expected = []
  // should return empty list on failure
  assert wp_json.parse_line(bad_input) == expected
}
