//! Sync Committee type for light client

const std = @import("std");
const Ssz = @import("../Ssz/root.zig");

/// Sync committee as defined in the consensus specs
pub const SyncCommittee = struct {
    /// Public keys of the sync committee members (512 keys, 48 bytes each for BLS12-381)
    pubkeys: [512][48]u8,
    /// Aggregate public key for the committee
    aggregate_pubkey: [48]u8,

    /// Compute the hash tree root of the sync committee
    pub fn hashTreeRoot(self: SyncCommittee, allocator: std.mem.Allocator) ![32]u8 {
        // Serialize pubkeys into a single buffer
        var pubkey_bytes: [512 * 48]u8 = undefined;
        for (self.pubkeys, 0..) |pk, i| {
            @memcpy(pubkey_bytes[i * 48 .. (i + 1) * 48], &pk);
        }

        // Hash pubkeys
        const pubkeys_root = try Ssz.merkle.hashTreeRoot(allocator, &pubkey_bytes);

        // Hash aggregate pubkey (treat as 48 bytes)
        var agg_pk_padded: [64]u8 = undefined;
        @memcpy(agg_pk_padded[0..48], &self.aggregate_pubkey);
        @memset(agg_pk_padded[48..], 0);
        const aggregate_root = try Ssz.merkle.hashTreeRoot(allocator, &agg_pk_padded);

        // Return hash of the two roots
        return Ssz.merkle.hashPair(pubkeys_root, aggregate_root);
    }
};
