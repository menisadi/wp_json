import gleam/io
import gleam/list
import gleam/option.{type Option, None}
import gleam/string
import simplifile.{read, write}

pub type Line {
  Line(date: String, time: String, name: String, text: String)
}

pub fn parse_line(line: String) -> List(String) {
  case string.split_once(line, on: ", ") {
    Ok(#(date, after_date)) -> {
      case string.split_once(after_date, on: " - ") {
        Ok(#(time, after_time)) -> {
          case string.split_once(after_time, on: ": ") {
            Ok(#(name, text)) -> [date, time, name, text]
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
  let file_path = "data/wp.txt"
  let output_path = "data/wp_parsed.txt"
  let content = read(from: file_path)
  case content {
    Ok(text) -> {
      let splitted_text = string.split(text, on: "\n")
      let parsed = parse_lines(splitted_text, [])
      let output = print_lines(parsed)
      let _ = output |> write(to: output_path)
      io.println("Parsed content written to " <> output_path)
    }
    Error(_) -> io.println("Error while reading input file")
  }
}
