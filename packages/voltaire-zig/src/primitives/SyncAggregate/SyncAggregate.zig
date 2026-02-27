//! Sync Aggregate type for light client

/// Sync aggregate containing sync committee bits and signature
pub const SyncAggregate = struct {
    /// Bitfield representing which sync committee members participated (64 bytes = 512 bits)
    sync_committee_bits: [64]u8,
    /// BLS12-381 signature from the sync committee (96 bytes)
    sync_committee_signature: [96]u8,
};
