import gleam/io
import gleam/string

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

pub fn parse_lines(lines: List(String)) -> List(List(String)) {
  todo
}

pub fn print_line(parsed_line) {
  case parsed_line {
    [date, time, name, text] -> {
      io.println("Date: " <> date)
      io.println("Time: " <> time)
      io.println("Name: " <> name)
      io.println("Text: " <> text)
    }
    _ -> io.println("Failed to parse the string.")
  }
}

pub fn main() {
  let text: String =
    "6/26/25, 20:12 - Meni Sadigurschi: אפרופו נושא האתר אישי שעלה פה פעם"

  let parsed_line = parse_line(text)

  print_line(parsed_line)
}
