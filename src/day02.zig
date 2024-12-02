const std = @import("std");
const aoc = @import("aoc.zig");

const Allocator = std.mem.Allocator;

const expect = std.testing.expect;

pub const AOC_YEAR: u32 = 2024;
pub const AOC_DAY: u32 = 2;
pub const AocData = [][]u32;

pub fn aocSetup(allocator: Allocator, input: []const u8) anyerror!AocData {
    var iter = std.mem.splitScalar(u8, input, '\n');
    var report_idx: usize = 0;
    var next_line: ?[]const u8 = iter.first();

    const reports = try allocator.alloc([]u32, countLines(input));
    errdefer allocator.free(reports);

    while (next_line) |line| : (next_line = iter.next()) {
        if (line.len == 0) {
            continue;
        }
        var levels = std.mem.splitAny(u8, line, &std.ascii.whitespace);
        var next_level: ?[]const u8 = levels.first();
        var level_idx: usize = 0;
        var report = std.ArrayListUnmanaged(u32){};
        errdefer report.deinit(allocator);

        while (next_level) |level| : (next_level = levels.next()) {
            if (level.len == 0) {
                continue;
            }
            const level_ptr: *u32 = try report.addOne(allocator);

            level_ptr.* = try std.fmt.parseUnsigned(u32, level, 10);
            level_idx += 1;
        }
        reports[report_idx] = report.items;
        report_idx += 1;
    }

    return reports;
}

pub fn aocPart1(allocator: Allocator, reports: AocData) anyerror!u32 {
    _ = allocator;
    var valid_reports: u32 = 0;
    outer: for (reports) |report| {
        var increasing = true;
        for (1..report.len) |i| {
            const curr = report[i];
            const prev = report[i - 1];
            const diff = @abs(@max(curr, prev) - @min(curr, prev));

            if (diff < 1 or diff > 3) {
                continue :outer;
            }
            if (i == 1) {
                increasing = curr > prev;
            } else if ((increasing and curr <= prev) or (!increasing and curr >= prev)) {
                continue :outer;
            }
        }
        valid_reports += 1;
    }
    return valid_reports;
}

pub fn aocPart2(allocator: Allocator, data: AocData) anyerror!u32 {
    _ = allocator;
    _ = data;
    return 1;
}

pub fn main() !void {
    aoc.run(.{});
}

fn countLines(input: []const u8) usize {
    var iter = std.mem.splitScalar(u8, input, '\n');
    var next_line: ?[]const u8 = iter.first();
    var count: usize = 0;

    while (next_line) |line| : (next_line = iter.next()) {
        if (line.len == 0) {
            continue;
        }
        count += 1;
    }
    return count;
}

test "aoc 2024, day 02 example" {
    const example =
        \\7 6 4 2 1
        \\1 2 7 8 9
        \\9 7 6 2 1
        \\1 3 2 4 5
        \\8 6 4 4 1
        \\1 3 6 7 9
    ;

    var arena = std.heap.ArenaAllocator.init(std.testing.allocator);
    defer arena.deinit();
    const allocator = arena.allocator();

    const data: AocData = try aocSetup(allocator, example);
    try expect(2 == try aocPart1(allocator, data));
}
