import gleam/io
import gleam/list
import gleam/string

pub type Line {
  Line(date: String, time: String, name: String, text: String)
}

pub fn parse_line(line: String) -> List(String) {
  case string.split(line, on: ", ") {
    [date, after_date] -> {
      case string.split(after_date, on: " - ") {
        [time, after_time] -> {
          case string.split(after_time, on: ": ") {
            [name, text] -> [date, time, name, text]
            _ -> []
          }
        }
        _ -> []
      }
    }
    _ -> []
  }
}

pub fn parse_lines(
  lines: List(String),
  results: List(List(String)),
) -> List(List(String)) {
  case lines {
    [first, ..rest] -> parse_lines(rest, [parse_line(first), ..results])
    [] -> list.reverse(results)
  }
}

pub fn print_line(parsed_line: List(String)) -> String {
  case parsed_line {
    [date, time, name, text] -> {
      let date_str = "date:" <> date
      let time_str = "time:" <> time
      let name_str = "name:" <> name
      let text_str = "text:" <> text
      string.join([date_str, time_str, name_str, text_str], with: ",")
    }
    _ -> "Failed to parse the string."
  }
}

pub fn print_lines(parsed_lines: List(List(String))) -> String {
  case parsed_lines {
    [first, ..rest] -> print_line(first) <> "\n" <> print_lines(rest)
    [] -> "Empty"
  }
}

pub fn main() {
  let text: String =
    "6/26/25, 20:12 - Meni Sadigurschi: אפרופו נושא האתר אישי שעלה פה פעם
6/26/25, 20:13 - Meni Sadigurschi: החלטתי לנסות להעלות פוסטים (לא משהו דרמטי) לאתר שלי <This message was edited>"

  let splitted_text = string.split(text, on: "\n")
  let parsed = parse_lines(splitted_text, [])
  io.println(print_lines(parsed))
}
