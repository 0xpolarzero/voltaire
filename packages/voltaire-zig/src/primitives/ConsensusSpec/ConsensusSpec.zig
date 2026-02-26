const std = @import("std");
const primitives = @import("primitives");

comptime {
    _ = primitives;
}

pub const SLOTS_PER_EPOCH: u64 = 32;
pub const EPOCHS_PER_SYNC_COMMITTEE_PERIOD: u64 = 256;
pub const SLOTS_PER_SYNC_COMMITTEE_PERIOD: u64 = SLOTS_PER_EPOCH * EPOCHS_PER_SYNC_COMMITTEE_PERIOD;
pub const SYNC_COMMITTEE_SIZE: usize = 512;
pub const SECONDS_PER_SLOT: u64 = 12;
pub const SAFETY_THRESHOLD: u64 = 512 / 2;
pub const FINALITY_BRANCH_DEPTH: usize = 6;
pub const NEXT_SYNC_COMMITTEE_BRANCH_DEPTH: usize = 5;
pub const CURRENT_SYNC_COMMITTEE_BRANCH_DEPTH: usize = 5;
pub const EXECUTION_BRANCH_DEPTH: usize = 4;

pub const EXECUTION_PAYLOAD_INDEX: u64 = 25;
pub const FINALIZED_ROOT_INDEX: u64 = 105;
pub const NEXT_SYNC_COMMITTEE_INDEX: u64 = 55;
pub const CURRENT_SYNC_COMMITTEE_INDEX: u64 = 54;

test "ConsensusSpec: constants are correct" {
    try std.testing.expectEqual(@as(u64, 32), SLOTS_PER_EPOCH);
    try std.testing.expectEqual(@as(u64, 256), EPOCHS_PER_SYNC_COMMITTEE_PERIOD);
    try std.testing.expectEqual(@as(u64, 8192), SLOTS_PER_SYNC_COMMITTEE_PERIOD);
    try std.testing.expectEqual(@as(usize, 512), SYNC_COMMITTEE_SIZE);
    try std.testing.expectEqual(@as(u64, 12), SECONDS_PER_SLOT);
    try std.testing.expectEqual(@as(u64, 256), SAFETY_THRESHOLD);
    try std.testing.expectEqual(@as(usize, 6), FINALITY_BRANCH_DEPTH);
    try std.testing.expectEqual(@as(usize, 5), NEXT_SYNC_COMMITTEE_BRANCH_DEPTH);
    try std.testing.expectEqual(@as(usize, 5), CURRENT_SYNC_COMMITTEE_BRANCH_DEPTH);
    try std.testing.expectEqual(@as(usize, 4), EXECUTION_BRANCH_DEPTH);
    try std.testing.expectEqual(@as(u64, 25), EXECUTION_PAYLOAD_INDEX);
    try std.testing.expectEqual(@as(u64, 105), FINALIZED_ROOT_INDEX);
    try std.testing.expectEqual(@as(u64, 55), NEXT_SYNC_COMMITTEE_INDEX);
    try std.testing.expectEqual(@as(u64, 54), CURRENT_SYNC_COMMITTEE_INDEX);
}
