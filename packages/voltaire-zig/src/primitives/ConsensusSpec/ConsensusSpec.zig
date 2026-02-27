//! Ethereum Consensus Spec constants
//!
//! These constants are defined in the Ethereum consensus specs:
//! https://github.com/ethereum/consensus-specs

/// Number of slots in an epoch
pub const SLOTS_PER_EPOCH: u64 = 32;

/// Number of seconds per slot
pub const SECONDS_PER_SLOT: u64 = 12;

/// Size of the sync committee
pub const SYNC_COMMITTEE_SIZE: u64 = 512;
