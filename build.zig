const std = @import("std");

pub fn build(b: *std.Build) void {
    const target = b.standardTargetOptions(.{});
    const optimize = b.standardOptimizeOption(.{});

    const test_step = b.step("test", "Run unit tests");

    const ab = AocBuild{
        .b = b,
        .target = target,
        .optimize = optimize,
        .test_step = test_step,
    };
}

const AocBuild = struct {
    b: *std.Build,
    target: std.Build.ResolvedTarget,
    optimize: std.builtin.OptimizeMode,
    test_step: *std.Build.Step,
};

fn addSolution(ab: AocBuild, comptime name: []const u8) void {
    const exe = ab.b.addExecutable(.{
        .name = "AdventOfCode2024 - " ++ name,
        .root_source_file = ab.b.path("src/" ++ name ++ ".zig"),
        .target = ab.target,
        .optimize = ab.optimize,
    });

    const run_cmd = ab.b.addRunArtifact(exe);
    run_cmd.step.dependOn(ab.b.getInstallStep());

    if (ab.b.args) |args| {
        run_cmd.addArgs(args);
    }

    const run_step = ab.b.step(name, "Run solution: " ++ name);
    run_step.dependOn(&run_cmd.step);

    const exe_unit_tests = ab.b.addTest(.{
        .root_source_file = ab.b.path("src/" ++ name ++ ".zig"),
        .target = ab.target,
        .optimize = ab.optimize,
    });

    const run_exe_unit_tests = ab.b.addRunArtifact(exe_unit_tests);
    ab.test_step.dependOn(&run_exe_unit_tests.step);
}
