//! Light client update types
//!
//! Defines the update structures used by the light client sync protocol

const LightClientHeader = @import("../LightClientHeader/LightClientHeader.zig").LightClientHeader;

/// Bootstrap information for light client initialization
pub const LightClientBootstrap = struct {
    /// Header at the trusted checkpoint
    header: LightClientHeader,
    /// Current sync committee pubkeys
    current_sync_committee_pubkeys: [512][48]u8,
    /// Current sync committee aggregate pubkey
    current_sync_committee_aggregate_pubkey: [48]u8,
    /// Merkle proof branch for current sync committee
    current_sync_committee_branch: [5][32]u8,

    /// Create a new LightClientBootstrap
    pub fn from(
        header: LightClientHeader,
        current_sync_committee_pubkeys: [512][48]u8,
        current_sync_committee_aggregate_pubkey: [48]u8,
        current_sync_committee_branch: [5][32]u8,
    ) LightClientBootstrap {
        return .{
            .header = header,
            .current_sync_committee_pubkeys = current_sync_committee_pubkeys,
            .current_sync_committee_aggregate_pubkey = current_sync_committee_aggregate_pubkey,
            .current_sync_committee_branch = current_sync_committee_branch,
        };
    }
};

/// Light client update containing sync committee and finality information
pub const LightClientUpdate = struct {
    /// Attested header
    attested_header: LightClientHeader,
    /// Next sync committee pubkeys (if available)
    next_sync_committee_pubkeys: [512][48]u8,
    /// Next sync committee aggregate pubkey
    next_sync_committee_aggregate_pubkey: [48]u8,
    /// Merkle proof branch for next sync committee
    next_sync_committee_branch: [5][32]u8,
    /// Finalized header (if available)
    finalized_header: ?LightClientHeader,
    /// Merkle proof branch for finality
    finality_branch: [6][32]u8,
    /// Sync committee bits
    sync_committee_bits: [64]u8,
    /// Sync committee signature
    sync_committee_signature: [96]u8,
    /// Signature slot
    signature_slot: u64,

    /// Create a new LightClientUpdate
    pub fn from(
        attested_header: LightClientHeader,
        next_sync_committee_pubkeys: [512][48]u8,
        next_sync_committee_aggregate_pubkey: [48]u8,
        next_sync_committee_branch: [5][32]u8,
        finalized_header: ?LightClientHeader,
        finality_branch: [6][32]u8,
        sync_committee_bits: [64]u8,
        sync_committee_signature: [96]u8,
        signature_slot: u64,
    ) LightClientUpdate {
        return .{
            .attested_header = attested_header,
            .next_sync_committee_pubkeys = next_sync_committee_pubkeys,
            .next_sync_committee_aggregate_pubkey = next_sync_committee_aggregate_pubkey,
            .next_sync_committee_branch = next_sync_committee_branch,
            .finalized_header = finalized_header,
            .finality_branch = finality_branch,
            .sync_committee_bits = sync_committee_bits,
            .sync_committee_signature = sync_committee_signature,
            .signature_slot = signature_slot,
        };
    }
};

/// Light client finality update
pub const LightClientFinalityUpdate = struct {
    /// Attested header
    attested_header: LightClientHeader,
    /// Finalized header
    finalized_header: LightClientHeader,
    /// Merkle proof branch for finality
    finality_branch: [6][32]u8,
    /// Sync committee bits
    sync_committee_bits: [64]u8,
    /// Sync committee signature
    sync_committee_signature: [96]u8,
    /// Signature slot
    signature_slot: u64,

    /// Create a new LightClientFinalityUpdate
    pub fn from(
        attested_header: LightClientHeader,
        finalized_header: LightClientHeader,
        finality_branch: [6][32]u8,
        sync_committee_bits: [64]u8,
        sync_committee_signature: [96]u8,
        signature_slot: u64,
    ) LightClientFinalityUpdate {
        return .{
            .attested_header = attested_header,
            .finalized_header = finalized_header,
            .finality_branch = finality_branch,
            .sync_committee_bits = sync_committee_bits,
            .sync_committee_signature = sync_committee_signature,
            .signature_slot = signature_slot,
        };
    }
};

/// Light client optimistic update
pub const LightClientOptimisticUpdate = struct {
    /// Attested header
    attested_header: LightClientHeader,
    /// Sync committee bits
    sync_committee_bits: [64]u8,
    /// Sync committee signature
    sync_committee_signature: [96]u8,
    /// Signature slot
    signature_slot: u64,

    /// Create a new LightClientOptimisticUpdate
    pub fn from(
        attested_header: LightClientHeader,
        sync_committee_bits: [64]u8,
        sync_committee_signature: [96]u8,
        signature_slot: u64,
    ) LightClientOptimisticUpdate {
        return .{
            .attested_header = attested_header,
            .sync_committee_bits = sync_committee_bits,
            .sync_committee_signature = sync_committee_signature,
            .signature_slot = signature_slot,
        };
    }
};

/// Generic update that can represent any type of light client update
pub const GenericUpdate = struct {
    /// Attested header
    attested_header: LightClientHeader,
    /// Sync committee bits
    sync_committee_bits: [64]u8,
    /// Sync committee signature
    sync_committee_signature: [96]u8,
    /// Signature slot
    signature_slot: u64,
    /// Next sync committee pubkeys (optional)
    next_sync_committee_pubkeys: ?[512][48]u8,
    /// Next sync committee aggregate pubkey (optional)
    next_sync_committee_aggregate_pubkey: ?[48]u8,
    /// Merkle proof branch for next sync committee (optional)
    next_sync_committee_branch: ?[]const [32]u8,
    /// Finalized header (optional)
    finalized_header: ?LightClientHeader,
    /// Merkle proof branch for finality (optional)
    finality_branch: ?[]const [32]u8,

    /// Create a new GenericUpdate
    pub fn from(
        attested_header: LightClientHeader,
        sync_committee_bits: [64]u8,
        sync_committee_signature: [96]u8,
        signature_slot: u64,
        next_sync_committee_pubkeys: ?[512][48]u8,
        next_sync_committee_aggregate_pubkey: ?[48]u8,
        next_sync_committee_branch: ?[]const [32]u8,
        finalized_header: ?LightClientHeader,
        finality_branch: ?[]const [32]u8,
    ) GenericUpdate {
        return .{
            .attested_header = attested_header,
            .sync_committee_bits = sync_committee_bits,
            .sync_committee_signature = sync_committee_signature,
            .signature_slot = signature_slot,
            .next_sync_committee_pubkeys = next_sync_committee_pubkeys,
            .next_sync_committee_aggregate_pubkey = next_sync_committee_aggregate_pubkey,
            .next_sync_committee_branch = next_sync_committee_branch,
            .finalized_header = finalized_header,
            .finality_branch = finality_branch,
        };
    }
};

/// Light client store maintaining the sync state
pub const LightClientStore = struct {
    /// Finalized header
    finalized_header: LightClientHeader,
    /// Current sync committee pubkeys
    current_sync_committee_pubkeys: [512][48]u8,
    /// Current sync committee aggregate pubkey
    current_sync_committee_aggregate_pubkey: [48]u8,
    /// Next sync committee pubkeys (optional, populated during sync committee period transition)
    next_sync_committee_pubkeys: ?[512][48]u8,
    /// Next sync committee aggregate pubkey (optional)
    next_sync_committee_aggregate_pubkey: ?[48]u8,
    /// Optimistic header
    optimistic_header: LightClientHeader,
    /// Previous max active participants
    previous_max_active_participants: u64,
    /// Current max active participants
    current_max_active_participants: u64,

    /// Create a new LightClientStore with all fields
    pub fn from(
        finalized_header: LightClientHeader,
        current_sync_committee_pubkeys: [512][48]u8,
        current_sync_committee_aggregate_pubkey: [48]u8,
        next_sync_committee_pubkeys: ?[512][48]u8,
        next_sync_committee_aggregate_pubkey: ?[48]u8,
        optimistic_header: LightClientHeader,
        previous_max_active_participants: u64,
        current_max_active_participants: u64,
    ) LightClientStore {
        return .{
            .finalized_header = finalized_header,
            .current_sync_committee_pubkeys = current_sync_committee_pubkeys,
            .current_sync_committee_aggregate_pubkey = current_sync_committee_aggregate_pubkey,
            .next_sync_committee_pubkeys = next_sync_committee_pubkeys,
            .next_sync_committee_aggregate_pubkey = next_sync_committee_aggregate_pubkey,
            .optimistic_header = optimistic_header,
            .previous_max_active_participants = previous_max_active_participants,
            .current_max_active_participants = current_max_active_participants,
        };
    }
};
