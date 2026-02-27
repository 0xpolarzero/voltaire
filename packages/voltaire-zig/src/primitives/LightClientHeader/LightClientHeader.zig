//! Light client header types
//!
//! Defines the header structures used by the light client protocol

/// Light client header containing beacon and execution payload information
pub const LightClientHeader = struct {
    /// Beacon block header
    beacon: BeaconBlockHeader,
    /// Execution payload header fields
    execution: ExecutionPayloadHeaderFields,
    /// Merkle proof branch for execution payload
    execution_branch: [4][32]u8,

    /// Create a new LightClientHeader
    pub fn from(
        beacon: BeaconBlockHeader,
        execution: ExecutionPayloadHeaderFields,
        execution_branch: [4][32]u8,
    ) LightClientHeader {
        return .{
            .beacon = beacon,
            .execution = execution,
            .execution_branch = execution_branch,
        };
    }

    /// Beacon block header as defined in consensus specs
    pub const BeaconBlockHeader = struct {
        /// Slot number
        slot: u64,
        /// Proposer validator index
        proposer_index: u64,
        /// Parent block root
        parent_root: [32]u8,
        /// State root
        state_root: [32]u8,
        /// Body root
        body_root: [32]u8,

        /// Create a new BeaconBlockHeader
        pub fn from(
            slot: u64,
            proposer_index: u64,
            parent_root: [32]u8,
            state_root: [32]u8,
            body_root: [32]u8,
        ) BeaconBlockHeader {
            return .{
                .slot = slot,
                .proposer_index = proposer_index,
                .parent_root = parent_root,
                .state_root = state_root,
                .body_root = body_root,
            };
        }
    };

    /// Execution payload header fields for light clients
    pub const ExecutionPayloadHeaderFields = struct {
        /// Parent block hash
        parent_hash: [32]u8,
        /// Fee recipient address
        fee_recipient: [20]u8,
        /// State root
        state_root: [32]u8,
        /// Receipts root
        receipts_root: [32]u8,
        /// Logs bloom filter
        logs_bloom: [256]u8,
        /// Prev randao
        prev_randao: [32]u8,
        /// Block number
        block_number: u64,
        /// Gas limit
        gas_limit: u64,
        /// Gas used
        gas_used: u64,
        /// Timestamp
        timestamp: u64,
        /// Base fee per gas
        base_fee_per_gas: u256,
        /// Block hash
        block_hash: [32]u8,
        /// Transactions root
        transactions_root: [32]u8,
        /// Withdrawals root
        withdrawals_root: [32]u8,
        /// Blob gas used
        blob_gas_used: u64,
        /// Excess blob gas
        excess_blob_gas: u64,

        /// Create new ExecutionPayloadHeaderFields
        pub fn from(
            parent_hash: [32]u8,
            fee_recipient: [20]u8,
            state_root: [32]u8,
            receipts_root: [32]u8,
            logs_bloom: [256]u8,
            prev_randao: [32]u8,
            block_number: u64,
            gas_limit: u64,
            gas_used: u64,
            timestamp: u64,
            base_fee_per_gas: u256,
            block_hash: [32]u8,
            transactions_root: [32]u8,
            withdrawals_root: [32]u8,
            blob_gas_used: u64,
            excess_blob_gas: u64,
        ) ExecutionPayloadHeaderFields {
            return .{
                .parent_hash = parent_hash,
                .fee_recipient = fee_recipient,
                .state_root = state_root,
                .receipts_root = receipts_root,
                .logs_bloom = logs_bloom,
                .prev_randao = prev_randao,
                .block_number = block_number,
                .gas_limit = gas_limit,
                .gas_used = gas_used,
                .timestamp = timestamp,
                .base_fee_per_gas = base_fee_per_gas,
                .block_hash = block_hash,
                .transactions_root = transactions_root,
                .withdrawals_root = withdrawals_root,
                .blob_gas_used = blob_gas_used,
                .excess_blob_gas = excess_blob_gas,
            };
        }
    };
};
