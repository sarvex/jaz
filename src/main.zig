const std = @import("std");
const primitives = @import("interpreter/primitives.zig");
const Interpreter = @import("interpreter/Interpreter.zig");
const ClassResolver = @import("interpreter/ClassResolver.zig");

pub fn main() anyerror!void {
    const allocator = std.heap.page_allocator;

    var classpath = [_]std.fs.Dir{try std.fs.cwd().openDir("test/src", .{ .access_sub_paths = true, .iterate = true })};
    var class_resolver = try ClassResolver.init(allocator, &classpath);

    var interpreter = Interpreter.init(allocator, class_resolver);
    std.log.info("{d}", .{
        (try interpreter.call("jaztest.Test.add", .{ @as(primitives.int, 12), @as(primitives.int, 13) })).int,
    });
}

test {
    std.testing.refAllDecls(@This());
}
