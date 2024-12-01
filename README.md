# Advent of code 2024

Advent of code, 2024 edition solutions in Zig.

## Pre-requisites

* Zig 0.13 or later (if no breaking changes)
* Nix package manager (optional): for automatic dev env setup

## Setup

To automatically download inputs from the website, follow the steps below.
If that is not desirable go to "Without Auto Downloading" section.

### With Auto Downloading

Create a `.aoc/config.json` file with the following content:

```json
{
  "token": "YOUR AOC SESSION COOKIE"
}
```

Where `YOUR_AOC_SESSION_COOKIE` is the value of the "session" cookie used by https://adventofcode.com after logging in.

### Without Auto Downloading

Place the content of the puzzle input in a `.aoc/input_YYYY_[D]D.txt`
Where `YYYY` the current year and `[D]D` the current day.

Examples:
* `.aoc/input_2024_1.txt`
* `.aoc/input_2024_23.txt`


## Running the Solutions

```bash
zig build day01
zig build day02
# ...
zig build dayXX
```

## Running Tests

```bash
zig run tests
```

