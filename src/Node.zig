const std = @import("std");
const stdout = std.io.getStdOut().writer();
const debug = std.log.debug;
const hash_length = std.crypto.hash.sha3.Keccak_512.digest_length;

pub const Node  =struct {
    id: i32,
    parentId: i32,
    hash:  [hash_length]u8 = undefined,
    data:  ?[]const u8 = null, 

    pub fn print(self: *Node) anyerror!void{
        try stdout.print("\nId: {}\nParent:{}\nHash: {s}\nData: {s}\n",  .{self.id, self.parentId ,std.fmt.fmtSliceHexLower(self.hash[0..]), self.data});
    }
};

test "test Node functions" {
    var testId: i32 = 7;
    var parentId: i32 = -1;
    var data = "This is some test Data";
    var newHash: [hash_length]u8 = undefined;
    std.crypto.hash.sha3.Keccak_512.hash(data, &newHash, .{});

    var testNode = Node{ .id = testId, .parentId = parentId, .hash = newHash, .data = data};
    try std.testing.expectEqual(testId, testNode.id);
    try std.testing.expectEqual(parentId, testNode.parentId);
    try std.testing.expectEqual(newHash, testNode.hash);

    try testNode.print();
}
