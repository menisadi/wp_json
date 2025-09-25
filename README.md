# wp_json

[![Package Version](https://img.shields.io/hexpm/v/wp_json)](https://hex.pm/packages/wp_json)
[![Hex Docs](https://img.shields.io/badge/hex-docs-ffaff3)](https://hexdocs.pm/wp_json/)

A small Gleam library for parsing WhatsApp chat exports into structured data.

## Usage
```sh
gleam add wp_json@1
```

```gleam
import gleam/io
import wp_json

pub fn main() {
  let text =
    "6/26/25, 20:12 - Me: Hello world
6/26/25, 20:13 - You: Another message"

  let lines = string.split(text, on: "\n")
  let parsed = wp_json.parse_lines(lines, [])
  io.println(wp_json.print_lines(parsed))
}```

Further documentation can be found at <https://hexdocs.pm/wp_json>.

## Development

```sh
gleam run   # Run the project
gleam test  # Run the tests
```
