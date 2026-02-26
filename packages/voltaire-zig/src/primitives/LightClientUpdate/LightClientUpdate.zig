const std = @import("std");
const primitives = @import("primitives");

pub const LightClientBootstrap = struct {
    header: primitives.LightClientHeader.LightClientHeader,
    current_sync_committee_pubkeys: [512][48]u8,
    current_sync_committee_aggregate_pubkey: [48]u8,
    current_sync_committee_branch: [5][32]u8,

    pub fn from(
        header: primitives.LightClientHeader.LightClientHeader,
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

    pub fn equals(self: LightClientBootstrap, other: LightClientBootstrap) bool {
        return self.header.equals(other.header) and
            std.mem.eql(
                u8,
                std.mem.asBytes(&self.current_sync_committee_pubkeys),
                std.mem.asBytes(&other.current_sync_committee_pubkeys),
            ) and
            std.mem.eql(
                u8,
                self.current_sync_committee_aggregate_pubkey[0..],
                other.current_sync_committee_aggregate_pubkey[0..],
            ) and
            std.mem.eql(
                u8,
                std.mem.asBytes(&self.current_sync_committee_branch),
                std.mem.asBytes(&other.current_sync_committee_branch),
            );
    }
};

pub const LightClientUpdate = struct {
    attested_header: primitives.LightClientHeader.LightClientHeader,
    next_sync_committee_pubkeys: [512][48]u8,
    next_sync_committee_aggregate_pubkey: [48]u8,
    next_sync_committee_branch: [5][32]u8,
    finalized_header: primitives.LightClientHeader.LightClientHeader,
    finality_branch: [6][32]u8,
    sync_committee_bits: [64]u8,
    sync_committee_signature: [96]u8,
    signature_slot: u64,

    pub fn from(
        attested_header: primitives.LightClientHeader.LightClientHeader,
        next_sync_committee_pubkeys: [512][48]u8,
        next_sync_committee_aggregate_pubkey: [48]u8,
        next_sync_committee_branch: [5][32]u8,
        finalized_header: primitives.LightClientHeader.LightClientHeader,
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

    pub fn equals(self: LightClientUpdate, other: LightClientUpdate) bool {
        return self.attested_header.equals(other.attested_header) and
            std.mem.eql(
                u8,
                std.mem.asBytes(&self.next_sync_committee_pubkeys),
                std.mem.asBytes(&other.next_sync_committee_pubkeys),
            ) and
            std.mem.eql(
                u8,
                self.next_sync_committee_aggregate_pubkey[0..],
                other.next_sync_committee_aggregate_pubkey[0..],
            ) and
            std.mem.eql(
                u8,
                std.mem.asBytes(&self.next_sync_committee_branch),
                std.mem.asBytes(&other.next_sync_committee_branch),
            ) and
            self.finalized_header.equals(other.finalized_header) and
            std.mem.eql(u8, std.mem.asBytes(&self.finality_branch), std.mem.asBytes(&other.finality_branch)) and
            std.mem.eql(u8, self.sync_committee_bits[0..], other.sync_committee_bits[0..]) and
            std.mem.eql(u8, self.sync_committee_signature[0..], other.sync_committee_signature[0..]) and
            self.signature_slot == other.signature_slot;
    }
};

pub const LightClientFinalityUpdate = struct {
    attested_header: primitives.LightClientHeader.LightClientHeader,
    finalized_header: primitives.LightClientHeader.LightClientHeader,
    finality_branch: [6][32]u8,
    sync_committee_bits: [64]u8,
    sync_committee_signature: [96]u8,
    signature_slot: u64,

    pub fn from(
        attested_header: primitives.LightClientHeader.LightClientHeader,
        finalized_header: primitives.LightClientHeader.LightClientHeader,
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

    pub fn equals(self: LightClientFinalityUpdate, other: LightClientFinalityUpdate) bool {
        return self.attested_header.equals(other.attested_header) and
            self.finalized_header.equals(other.finalized_header) and
            std.mem.eql(u8, std.mem.asBytes(&self.finality_branch), std.mem.asBytes(&other.finality_branch)) and
            std.mem.eql(u8, self.sync_committee_bits[0..], other.sync_committee_bits[0..]) and
            std.mem.eql(u8, self.sync_committee_signature[0..], other.sync_committee_signature[0..]) and
            self.signature_slot == other.signature_slot;
    }
};

pub const LightClientOptimisticUpdate = struct {
    attested_header: primitives.LightClientHeader.LightClientHeader,
    sync_committee_bits: [64]u8,
    sync_committee_signature: [96]u8,
    signature_slot: u64,

    pub fn from(
        attested_header: primitives.LightClientHeader.LightClientHeader,
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

    pub fn equals(self: LightClientOptimisticUpdate, other: LightClientOptimisticUpdate) bool {
        return self.attested_header.equals(other.attested_header) and
            std.mem.eql(u8, self.sync_committee_bits[0..], other.sync_committee_bits[0..]) and
            std.mem.eql(u8, self.sync_committee_signature[0..], other.sync_committee_signature[0..]) and
            self.signature_slot == other.signature_slot;
    }
};

pub const GenericUpdate = struct {
    attested_header: primitives.LightClientHeader.LightClientHeader,
    sync_committee_bits: [64]u8,
    sync_committee_signature: [96]u8,
    signature_slot: u64,
    next_sync_committee_pubkeys: ?[512][48]u8,
    next_sync_committee_aggregate_pubkey: ?[48]u8,
    next_sync_committee_branch: ?[][32]u8,
    finalized_header: ?primitives.LightClientHeader.LightClientHeader,
    finality_branch: ?[][32]u8,

    pub fn from(
        attested_header: primitives.LightClientHeader.LightClientHeader,
        sync_committee_bits: [64]u8,
        sync_committee_signature: [96]u8,
        signature_slot: u64,
        next_sync_committee_pubkeys: ?[512][48]u8,
        next_sync_committee_aggregate_pubkey: ?[48]u8,
        next_sync_committee_branch: ?[][32]u8,
        finalized_header: ?primitives.LightClientHeader.LightClientHeader,
        finality_branch: ?[][32]u8,
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

    pub fn equals(self: GenericUpdate, other: GenericUpdate) bool {
        return self.attested_header.equals(other.attested_header) and
            std.mem.eql(u8, self.sync_committee_bits[0..], other.sync_committee_bits[0..]) and
            std.mem.eql(u8, self.sync_committee_signature[0..], other.sync_committee_signature[0..]) and
            self.signature_slot == other.signature_slot and
            optionalFixedValueEquals([512][48]u8, self.next_sync_committee_pubkeys, other.next_sync_committee_pubkeys) and
            optionalFixedValueEquals([48]u8, self.next_sync_committee_aggregate_pubkey, other.next_sync_committee_aggregate_pubkey) and
            optionalBranchEquals(self.next_sync_committee_branch, other.next_sync_committee_branch) and
            optionalHeaderEquals(self.finalized_header, other.finalized_header) and
            optionalBranchEquals(self.finality_branch, other.finality_branch);
    }
};

pub const LightClientStore = struct {
    finalized_header: primitives.LightClientHeader.LightClientHeader,
    current_sync_committee_pubkeys: [512][48]u8,
    current_sync_committee_aggregate_pubkey: [48]u8,
    next_sync_committee_pubkeys: ?[512][48]u8,
    next_sync_committee_aggregate_pubkey: ?[48]u8,
    optimistic_header: primitives.LightClientHeader.LightClientHeader,
    previous_max_active_participants: u64,
    current_max_active_participants: u64,

    pub fn from(
        finalized_header: primitives.LightClientHeader.LightClientHeader,
        current_sync_committee_pubkeys: [512][48]u8,
        current_sync_committee_aggregate_pubkey: [48]u8,
        next_sync_committee_pubkeys: ?[512][48]u8,
        next_sync_committee_aggregate_pubkey: ?[48]u8,
        optimistic_header: primitives.LightClientHeader.LightClientHeader,
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

    pub fn equals(self: LightClientStore, other: LightClientStore) bool {
        return self.finalized_header.equals(other.finalized_header) and
            std.mem.eql(
                u8,
                std.mem.asBytes(&self.current_sync_committee_pubkeys),
                std.mem.asBytes(&other.current_sync_committee_pubkeys),
            ) and
            std.mem.eql(
                u8,
                self.current_sync_committee_aggregate_pubkey[0..],
                other.current_sync_committee_aggregate_pubkey[0..],
            ) and
            optionalFixedValueEquals([512][48]u8, self.next_sync_committee_pubkeys, other.next_sync_committee_pubkeys) and
            optionalFixedValueEquals([48]u8, self.next_sync_committee_aggregate_pubkey, other.next_sync_committee_aggregate_pubkey) and
            self.optimistic_header.equals(other.optimistic_header) and
            self.previous_max_active_participants == other.previous_max_active_participants and
            self.current_max_active_participants == other.current_max_active_participants;
    }
};

fn optionalFixedValueEquals(comptime T: type, left: ?T, right: ?T) bool {
    if (left) |left_value| {
        if (right) |right_value| {
            return std.mem.eql(u8, std.mem.asBytes(&left_value), std.mem.asBytes(&right_value));
        }
        return false;
    }
    return right == null;
}

fn branchEquals(left: [][32]u8, right: [][32]u8) bool {
    if (left.len != right.len) {
        return false;
    }

    return std.mem.eql(u8, std.mem.sliceAsBytes(left), std.mem.sliceAsBytes(right));
}

fn optionalBranchEquals(left: ?[][32]u8, right: ?[][32]u8) bool {
    if (left) |left_branch| {
        if (right) |right_branch| {
            return branchEquals(left_branch, right_branch);
        }
        return false;
    }
    return right == null;
}

fn optionalHeaderEquals(
    left: ?primitives.LightClientHeader.LightClientHeader,
    right: ?primitives.LightClientHeader.LightClientHeader,
) bool {
    if (left) |left_header| {
        if (right) |right_header| {
            return left_header.equals(right_header);
        }
        return false;
    }
    return right == null;
}

fn fixtureLightClientHeader(slot: u64, marker: u8) primitives.LightClientHeader.LightClientHeader {
    return primitives.LightClientHeader.LightClientHeader.from(
        primitives.LightClientHeader.LightClientHeader.BeaconBlockHeader.from(
            slot,
            slot + 1,
            [_]u8{marker} ** 32,
            [_]u8{marker +% 1} ** 32,
            [_]u8{marker +% 2} ** 32,
        ),
        primitives.LightClientHeader.LightClientHeader.ExecutionPayloadHeaderFields.from(
            [_]u8{marker +% 3} ** 32,
            [_]u8{marker +% 4} ** 20,
            [_]u8{marker +% 5} ** 32,
            [_]u8{marker +% 6} ** 32,
            [_]u8{marker +% 7} ** 256,
            [_]u8{marker +% 8} ** 32,
            slot + 10,
            30_000_000,
            15_000_000,
            1_700_000_000 + slot,
            @as(u256, marker) + 1,
            [_]u8{marker +% 9} ** 32,
            [_]u8{marker +% 10} ** 32,
            [_]u8{marker +% 11} ** 32,
            slot + 12,
            slot + 13,
        ),
        [_][32]u8{[_]u8{marker +% 12} ** 32} ** 4,
    );
}

fn fixtureSyncCommitteePubkeys(marker: u8) [512][48]u8 {
    return [_][48]u8{[_]u8{marker} ** 48} ** 512;
}

fn fixtureAggregatePubkey(marker: u8) [48]u8 {
    return [_]u8{marker} ** 48;
}

fn fixtureSyncCommitteeBits(marker: u8) [64]u8 {
    return [_]u8{marker} ** 64;
}

fn fixtureSyncCommitteeSignature(marker: u8) [96]u8 {
    return [_]u8{marker} ** 96;
}

test "LightClientBootstrap: from creates bootstrap and exposes fields" {
    const bootstrap = LightClientBootstrap.from(
        fixtureLightClientHeader(1, 1),
        fixtureSyncCommitteePubkeys(2),
        fixtureAggregatePubkey(3),
        [_][32]u8{[_]u8{4} ** 32} ** 5,
    );

    try std.testing.expectEqual(@as(u64, 1), bootstrap.header.beacon.slot);
    try std.testing.expectEqual(@as(u8, 2), bootstrap.current_sync_committee_pubkeys[0][0]);
    try std.testing.expectEqual(@as(u8, 3), bootstrap.current_sync_committee_aggregate_pubkey[0]);
    try std.testing.expectEqual(@as(u8, 4), bootstrap.current_sync_committee_branch[0][0]);
}

test "LightClientBootstrap: equals matches identical values" {
    const bootstrap_one = LightClientBootstrap.from(
        fixtureLightClientHeader(1, 1),
        fixtureSyncCommitteePubkeys(2),
        fixtureAggregatePubkey(3),
        [_][32]u8{[_]u8{4} ** 32} ** 5,
    );
    const bootstrap_two = LightClientBootstrap.from(
        fixtureLightClientHeader(1, 1),
        fixtureSyncCommitteePubkeys(2),
        fixtureAggregatePubkey(3),
        [_][32]u8{[_]u8{4} ** 32} ** 5,
    );

    try std.testing.expect(bootstrap_one.equals(bootstrap_two));
}

test "LightClientUpdate: from creates update and equals matches identical values" {
    const update_one = LightClientUpdate.from(
        fixtureLightClientHeader(2, 5),
        fixtureSyncCommitteePubkeys(6),
        fixtureAggregatePubkey(7),
        [_][32]u8{[_]u8{8} ** 32} ** 5,
        fixtureLightClientHeader(3, 9),
        [_][32]u8{[_]u8{10} ** 32} ** 6,
        fixtureSyncCommitteeBits(11),
        fixtureSyncCommitteeSignature(12),
        99,
    );
    const update_two = LightClientUpdate.from(
        fixtureLightClientHeader(2, 5),
        fixtureSyncCommitteePubkeys(6),
        fixtureAggregatePubkey(7),
        [_][32]u8{[_]u8{8} ** 32} ** 5,
        fixtureLightClientHeader(3, 9),
        [_][32]u8{[_]u8{10} ** 32} ** 6,
        fixtureSyncCommitteeBits(11),
        fixtureSyncCommitteeSignature(12),
        99,
    );

    try std.testing.expectEqual(@as(u64, 99), update_one.signature_slot);
    try std.testing.expect(update_one.equals(update_two));
}

test "LightClientFinalityUpdate: equals detects differences" {
    const update_one = LightClientFinalityUpdate.from(
        fixtureLightClientHeader(4, 13),
        fixtureLightClientHeader(5, 14),
        [_][32]u8{[_]u8{15} ** 32} ** 6,
        fixtureSyncCommitteeBits(16),
        fixtureSyncCommitteeSignature(17),
        111,
    );
    const update_two = LightClientFinalityUpdate.from(
        fixtureLightClientHeader(4, 13),
        fixtureLightClientHeader(5, 14),
        [_][32]u8{[_]u8{15} ** 32} ** 6,
        fixtureSyncCommitteeBits(16),
        fixtureSyncCommitteeSignature(17),
        112,
    );

    try std.testing.expect(!update_one.equals(update_two));
}

test "LightClientOptimisticUpdate: from creates optimistic update" {
    const update = LightClientOptimisticUpdate.from(
        fixtureLightClientHeader(6, 18),
        fixtureSyncCommitteeBits(19),
        fixtureSyncCommitteeSignature(20),
        130,
    );

    try std.testing.expectEqual(@as(u64, 130), update.signature_slot);
    try std.testing.expectEqual(@as(u8, 19), update.sync_committee_bits[0]);
}

test "LightClientOptimisticUpdate: equals detects differences" {
    const update_one = LightClientOptimisticUpdate.from(
        fixtureLightClientHeader(6, 18),
        fixtureSyncCommitteeBits(19),
        fixtureSyncCommitteeSignature(20),
        130,
    );
    const update_two = LightClientOptimisticUpdate.from(
        fixtureLightClientHeader(6, 18),
        fixtureSyncCommitteeBits(19),
        fixtureSyncCommitteeSignature(20),
        131,
    );

    try std.testing.expect(!update_one.equals(update_two));
}

test "GenericUpdate: equals compares optional branches by content" {
    var next_branch_one = [_][32]u8{[_]u8{21} ** 32} ** 5;
    var next_branch_two = [_][32]u8{[_]u8{21} ** 32} ** 5;
    var finality_branch_one = [_][32]u8{[_]u8{22} ** 32} ** 6;
    var finality_branch_two = [_][32]u8{[_]u8{22} ** 32} ** 6;

    const update_one = GenericUpdate.from(
        fixtureLightClientHeader(7, 23),
        fixtureSyncCommitteeBits(24),
        fixtureSyncCommitteeSignature(25),
        140,
        fixtureSyncCommitteePubkeys(26),
        fixtureAggregatePubkey(27),
        next_branch_one[0..],
        fixtureLightClientHeader(8, 28),
        finality_branch_one[0..],
    );
    const update_two = GenericUpdate.from(
        fixtureLightClientHeader(7, 23),
        fixtureSyncCommitteeBits(24),
        fixtureSyncCommitteeSignature(25),
        140,
        fixtureSyncCommitteePubkeys(26),
        fixtureAggregatePubkey(27),
        next_branch_two[0..],
        fixtureLightClientHeader(8, 28),
        finality_branch_two[0..],
    );

    try std.testing.expect(update_one.equals(update_two));
}

test "LightClientStore: from creates store and equals matches identical values" {
    const store_one = LightClientStore.from(
        fixtureLightClientHeader(9, 29),
        fixtureSyncCommitteePubkeys(30),
        fixtureAggregatePubkey(31),
        fixtureSyncCommitteePubkeys(32),
        fixtureAggregatePubkey(33),
        fixtureLightClientHeader(10, 34),
        200,
        300,
    );
    const store_two = LightClientStore.from(
        fixtureLightClientHeader(9, 29),
        fixtureSyncCommitteePubkeys(30),
        fixtureAggregatePubkey(31),
        fixtureSyncCommitteePubkeys(32),
        fixtureAggregatePubkey(33),
        fixtureLightClientHeader(10, 34),
        200,
        300,
    );

    try std.testing.expectEqual(@as(u64, 200), store_one.previous_max_active_participants);
    try std.testing.expect(store_one.equals(store_two));
}
