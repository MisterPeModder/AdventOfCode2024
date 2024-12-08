const std = @import("std");
const aoc = @import("aoc.zig");

const Allocator = std.mem.Allocator;

const expect = std.testing.expect;

pub const std_options = .{
    .log_level = .info,
};

pub const AOC_YEAR: u32 = 2024;
pub const AOC_DAY: u32 = 1;
pub const AocData = struct { data: u32 };
pub const AocResult = u32;

pub fn aocSetup(allocator: Allocator, input: []const u8) anyerror!AocData {
    _ = allocator;
    _ = input;
    return .{ .data = 0 };
}

pub fn aocPart1(allocator: Allocator, data: AocData) anyerror!AocResult {
    _ = allocator;
    _ = data;
    return 1;
}

pub fn aocPart2(allocator: Allocator, data: AocData) anyerror!AocResult {
    _ = allocator;
    _ = data;
    return 1;
}

pub fn main() !void {
    aoc.run(.{});
}
