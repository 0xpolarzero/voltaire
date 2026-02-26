const std = @import("std");
const primitives = @import("primitives");

comptime {
    _ = primitives;
}

pub const Fork = struct {
    epoch: u64,
    fork_version: [4]u8,
};

pub const ForkConfig = struct {
    genesis: Fork,
    altair: Fork,
    bellatrix: Fork,
    capella: Fork,
    deneb: Fork,
    electra: Fork,

    pub fn mainnet() ForkConfig {
        return .{
            .genesis = .{ .epoch = 0, .fork_version = .{ 0x00, 0x00, 0x00, 0x00 } },
            .altair = .{ .epoch = 74240, .fork_version = .{ 0x01, 0x00, 0x00, 0x00 } },
            .bellatrix = .{ .epoch = 144896, .fork_version = .{ 0x02, 0x00, 0x00, 0x00 } },
            .capella = .{ .epoch = 194048, .fork_version = .{ 0x03, 0x00, 0x00, 0x00 } },
            .deneb = .{ .epoch = 269568, .fork_version = .{ 0x04, 0x00, 0x00, 0x00 } },
            .electra = .{ .epoch = 364032, .fork_version = .{ 0x05, 0x00, 0x00, 0x00 } },
        };
    }

    pub fn sepolia() ForkConfig {
        return .{
            .genesis = .{ .epoch = 0, .fork_version = .{ 0x90, 0x00, 0x00, 0x69 } },
            .altair = .{ .epoch = 50, .fork_version = .{ 0x90, 0x00, 0x00, 0x70 } },
            .bellatrix = .{ .epoch = 100, .fork_version = .{ 0x90, 0x00, 0x00, 0x71 } },
            .capella = .{ .epoch = 56832, .fork_version = .{ 0x90, 0x00, 0x00, 0x72 } },
            .deneb = .{ .epoch = 132608, .fork_version = .{ 0x90, 0x00, 0x00, 0x73 } },
            .electra = .{ .epoch = 222464, .fork_version = .{ 0x90, 0x00, 0x00, 0x74 } },
        };
    }

    pub fn holesky() ForkConfig {
        return .{
            .genesis = .{ .epoch = 0, .fork_version = .{ 0x01, 0x01, 0x70, 0x00 } },
            .altair = .{ .epoch = 0, .fork_version = .{ 0x02, 0x01, 0x70, 0x00 } },
            .bellatrix = .{ .epoch = 0, .fork_version = .{ 0x03, 0x01, 0x70, 0x00 } },
            .capella = .{ .epoch = 256, .fork_version = .{ 0x04, 0x01, 0x70, 0x00 } },
            .deneb = .{ .epoch = 29696, .fork_version = .{ 0x05, 0x01, 0x70, 0x00 } },
            .electra = .{ .epoch = 115968, .fork_version = .{ 0x06, 0x01, 0x70, 0x00 } },
        };
    }

    pub fn forkVersionForEpoch(self: ForkConfig, epoch: u64) [4]u8 {
        if (epoch >= self.electra.epoch) {
            return self.electra.fork_version;
        }
        if (epoch >= self.deneb.epoch) {
            return self.deneb.fork_version;
        }
        if (epoch >= self.capella.epoch) {
            return self.capella.fork_version;
        }
        if (epoch >= self.bellatrix.epoch) {
            return self.bellatrix.fork_version;
        }
        if (epoch >= self.altair.epoch) {
            return self.altair.fork_version;
        }
        return self.genesis.fork_version;
    }
};

test "ForkConfig: mainnet values are correct" {
    const config = ForkConfig.mainnet();

    try std.testing.expectEqual(@as(u64, 0), config.genesis.epoch);
    try std.testing.expectEqual(@as([4]u8, .{ 0x00, 0x00, 0x00, 0x00 }), config.genesis.fork_version);
    try std.testing.expectEqual(@as(u64, 74240), config.altair.epoch);
    try std.testing.expectEqual(@as([4]u8, .{ 0x01, 0x00, 0x00, 0x00 }), config.altair.fork_version);
    try std.testing.expectEqual(@as(u64, 144896), config.bellatrix.epoch);
    try std.testing.expectEqual(@as([4]u8, .{ 0x02, 0x00, 0x00, 0x00 }), config.bellatrix.fork_version);
    try std.testing.expectEqual(@as(u64, 194048), config.capella.epoch);
    try std.testing.expectEqual(@as([4]u8, .{ 0x03, 0x00, 0x00, 0x00 }), config.capella.fork_version);
    try std.testing.expectEqual(@as(u64, 269568), config.deneb.epoch);
    try std.testing.expectEqual(@as([4]u8, .{ 0x04, 0x00, 0x00, 0x00 }), config.deneb.fork_version);
    try std.testing.expectEqual(@as(u64, 364032), config.electra.epoch);
    try std.testing.expectEqual(@as([4]u8, .{ 0x05, 0x00, 0x00, 0x00 }), config.electra.fork_version);
}

test "ForkConfig: forkVersionForEpoch handles boundaries and ranges" {
    const config = ForkConfig.mainnet();

    try std.testing.expectEqual(@as([4]u8, .{ 0x00, 0x00, 0x00, 0x00 }), config.forkVersionForEpoch(0));
    try std.testing.expectEqual(@as([4]u8, .{ 0x00, 0x00, 0x00, 0x00 }), config.forkVersionForEpoch(74239));
    try std.testing.expectEqual(@as([4]u8, .{ 0x01, 0x00, 0x00, 0x00 }), config.forkVersionForEpoch(74240));
    try std.testing.expectEqual(@as([4]u8, .{ 0x01, 0x00, 0x00, 0x00 }), config.forkVersionForEpoch(144895));
    try std.testing.expectEqual(@as([4]u8, .{ 0x02, 0x00, 0x00, 0x00 }), config.forkVersionForEpoch(144896));
    try std.testing.expectEqual(@as([4]u8, .{ 0x03, 0x00, 0x00, 0x00 }), config.forkVersionForEpoch(200000));
    try std.testing.expectEqual(@as([4]u8, .{ 0x04, 0x00, 0x00, 0x00 }), config.forkVersionForEpoch(300000));
    try std.testing.expectEqual(@as([4]u8, .{ 0x05, 0x00, 0x00, 0x00 }), config.forkVersionForEpoch(364032));
    try std.testing.expectEqual(@as([4]u8, .{ 0x05, 0x00, 0x00, 0x00 }), config.forkVersionForEpoch(500000));
}
