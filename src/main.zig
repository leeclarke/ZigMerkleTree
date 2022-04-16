const std = @import("std");
//const keccak = @import("std.crypto.hash.sha3").Keccak_512;
const Node = @import("Node.zig").Node;
const MerkleTree = @import("MerkleTree.zig").MerkleTree;
const DataBlock = @import("MerkleTree.zig").DataBlock;

const debug = std.log.debug;

pub fn main() anyerror!void {
    std.log.info("All your codebase are belong to us.", .{});

    var out: [std.crypto.hash.sha3.Keccak_512.digest_length]u8 = undefined;
    std.crypto.hash.sha3.Keccak_512.hash("HashMeToo!",&out, .{});

    std.log.info("Hash: {s}", .{std.fmt.fmtSliceHexLower(&out)}); //TODO: Add formatter to the to the print fn in Node

    std.log.info("Done", .{});

    const allocator = std.heap.page_allocator;
    
    var data = std.ArrayList(DataBlock).init(allocator);
    defer data.deinit();

    try data.append(.{ .data = "Hello World"});
    try data.append(.{ .data = "Demand Whirled Peas"});
    try data.append(.{ .data = "Zig Rocks"});
    try data.append(.{ .data = "Ziguanas make great pets"});
    try data.append(.{ .data = "It's showtime!"});


    var mt = MerkleTree.init(data); //TODO: How to specify an array of strings?

    mt.print();
}

test "basic test" {
    try std.testing.expectEqual(10, 3 + 7);
}
