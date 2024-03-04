# Pandoc Markdown Documents

Easily create Word (docx) and PDF (pdf) documents from Markdown via [Pandocs](https://pandoc.org/installing.html) without the hassle of wrestling with fonts, styles etc. Because you know, this is not the 90s anymore.

See [Examples](#examples) below.

There's already recommended VSCode plugins you can use to expedite things.

## Setup

You'll need a few items for you to use this repository effectively:

* [Pandoc](https://pandoc.org/installing.html)
  You can install this with a package manager:

  Windows: 
    * `choco install pandoc`
    * `winget install --source winget --exact --id JohnMacFarlane.Pandoc`

  Macos: 
    * `brew install pandoc`
  
  Linux: See [installation instructions](https://pandoc.org/installing.html#linux)

## Converting

The usage for `build.sh` and `build.ps1` is quite simple:

```bash
./build.sh README.md [output-filename] [template-filename]
```

For example:

* `build.sh README.md` - Simple conversion that creates `readme-draft.docx`.
* `build.sh README.md readme-release.docx template/default.docx` - All options on the table.

## Examples

This repository is ideal when your layout is simple and doesn't require tables or for technical documentation (Eg. with architecture diagrams with [Excalidraw](https://excalidraw.com/)) for example like this:

![Language Server Architecture](diagrams/language-server-2023.excalidraw.png)

Especially nice when you have source code that you want to syntax highlight, like this bit of Rust:

```rust
use std::{
    io::{prelude::*, BufReader},
    net::{TcpListener, TcpStream},
};

fn main() {
    let listener = TcpListener::bind("127.0.0.1:7878").unwrap();

    for stream in listener.incoming() {
        let stream = stream.unwrap();

        handle_connection(stream);
    }
}

fn handle_connection(mut stream: TcpStream) {
    let buf_reader = BufReader::new(&mut stream);
    let http_request: Vec<_> = buf_reader
        .lines()
        .map(|result| result.unwrap())
        .take_while(|line| !line.is_empty())
        .collect();

    println!("Request: {:#?}", http_request);
}
```

Or when you gotta Go, you just have to:

```go
//go:build ignore
package main

import (
    "fmt"
    "log"
    "net/http"
)

func handler(w http.ResponseWriter, r *http.Request) {
    fmt.Fprintf(w, "Hi there, I love %s!", r.URL.Path[1:])
}

func main() {
    http.HandleFunc("/", handler)
    log.Fatal(http.ListenAndServe(":8080", nil))
}
```

Then you have

Tables from [pandoc examples](https://pandoc.org/chunkedhtml-demo/8.9-tables.html)

+---------------------+-----------------------+
| Location            | Temperature 1961-1990 |
|                     | in degree Celsius     |
|                     +-------+-------+-------+
|                     | min   | mean  | max   |
+=====================+=======+=======+=======+
| Antarctica          | -89.2 | N/A   | 19.8  |
+---------------------+-------+-------+-------+
| Earth               | -89.2 | 14    | 56.7  |
+---------------------+-------+-------+-------+

### Sub Headings

> quoteworthy quotes for quoting the quotable quotes.