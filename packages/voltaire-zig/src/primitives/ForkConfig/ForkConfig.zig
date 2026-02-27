//! Fork configuration for Ethereum networks
//!
//! Defines fork versions for different Ethereum networks (mainnet, sepolia, holesky)

/// Configuration for fork versions at different epochs
pub const ForkConfig = struct {
    /// Genesis fork version
    genesis_fork_version: [4]u8,
    /// Altair fork version
    altair_fork_version: [4]u8,
    /// Bellatrix fork version  
    bellatrix_fork_version: [4]u8,
    /// Capella fork version
    capella_fork_version: [4]u8,
    /// Deneb fork version
    deneb_fork_version: [4]u8,
    /// Electra fork version
    electra_fork_version: [4]u8,

    /// Returns the fork version for a given epoch
    pub fn forkVersionForEpoch(self: ForkConfig, epoch: u64) [4]u8 {
        // Simplified - in reality these would check activation epochs
        // For now, return the latest fork version
        _ = epoch;
        return self.deneb_fork_version;
    }

    /// Mainnet configuration
    pub fn mainnet() ForkConfig {
        return .{
            .genesis_fork_version = .{ 0x00, 0x00, 0x00, 0x00 },
            .altair_fork_version = .{ 0x01, 0x00, 0x00, 0x00 },
            .bellatrix_fork_version = .{ 0x02, 0x00, 0x00, 0x00 },
            .capella_fork_version = .{ 0x03, 0x00, 0x00, 0x00 },
            .deneb_fork_version = .{ 0x04, 0x00, 0x00, 0x00 },
            .electra_fork_version = .{ 0x05, 0x00, 0x00, 0x00 },
        };
    }

    /// Sepolia configuration
    pub fn sepolia() ForkConfig {
        return .{
            .genesis_fork_version = .{ 0x90, 0x00, 0x00, 0x69 },
            .altair_fork_version = .{ 0x90, 0x00, 0x00, 0x70 },
            .bellatrix_fork_version = .{ 0x90, 0x00, 0x00, 0x71 },
            .capella_fork_version = .{ 0x90, 0x00, 0x00, 0x72 },
            .deneb_fork_version = .{ 0x90, 0x00, 0x00, 0x73 },
            .electra_fork_version = .{ 0x90, 0x00, 0x00, 0x74 },
        };
    }

    /// Holesky configuration
    pub fn holesky() ForkConfig {
        return .{
            .genesis_fork_version = .{ 0x01, 0x01, 0x70, 0x00 },
            .altair_fork_version = .{ 0x02, 0x01, 0x70, 0x00 },
            .bellatrix_fork_version = .{ 0x03, 0x01, 0x70, 0x00 },
            .capella_fork_version = .{ 0x04, 0x01, 0x70, 0x00 },
            .deneb_fork_version = .{ 0x05, 0x01, 0x70, 0x00 },
            .electra_fork_version = .{ 0x06, 0x01, 0x70, 0x00 },
        };
    }
};
