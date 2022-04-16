const std = @import("std");
const Node = @import("Node.zig").Node;
const debug = std.log.debug;
const stdout = std.io.getStdOut().writer();
const allocator = std.heap.page_allocator;
const digest_length = std.crypto.hash.sha3.Keccak_512.digest_length;

pub const DataBlock = struct {
    data:  ?[]const u8 = null,
};

pub const MerkleTree = struct {
    
    nodes: std.ArrayList(Node),

    pub fn init(data: std.ArrayList(DataBlock)) MerkleTree{
        return MerkleTree{ .nodes = buildTree(data)};
    }

    pub fn print(self: *MerkleTree) void{
        std.log.info("Hello MerkleTree items:{}", .{self.data.items.len});
    }

    fn buildTree(dataIn: std.ArrayList(DataBlock)) std.ArrayList(Node) {
        var nodes = std.ArrayList(Node).init(allocator);
        defer nodes.deinit();  
        //run iteration1
        // var item_index: ?usize = null;
        for (dataIn.items) | dataBlock, index | {
            // if (std.mem.eql(u8, person.name, "Bob")) {
            //     item_index = index;
            // }
            std.debug.print("Printing index so it compiles  {}\n", .{index});
            std.debug.print("Printing data so it compiles  {}\n", .{dataBlock.data});
            //TODO: build nodes
        }
        //run interation2
        return nodes;
    }

    fn getHash(data: []const u8) [digest_length]u8 {
        var out: [digest_length]u8 = undefined;
        std.crypto.hash.sha3.Keccak_512.hash(data, &out, .{});

        return out;
    } 
};

test "test MerkleTree getHash" {
    var data: []const u8 =  "MerkleTreeHash2";
    var hash: [digest_length]u8 = undefined;
    hash = MerkleTree.getHash(data);

    try stdout.print("\nHash: {s}\n", .{std.fmt.fmtSliceHexLower(&hash)});
    try std.testing.expect(hash.len > 0);
}