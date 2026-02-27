---
"voltaire-effect": minor
---

**BREAKING**: `makeContractRegistry` now returns `{ Service, layer }` instead of a `Layer`.

The generic `ContractRegistryService` class, `ContractRegistryBase` type, and `InferContractRegistry` type helper have been removed.

### Migration

Before:
```typescript
import { ContractRegistryService, makeContractRegistry } from 'voltaire-effect'

const Contracts = makeContractRegistry({ USDC: { abi, address: '0x...' } })

const program = Effect.gen(function* () {
  const contracts = yield* ContractRegistryService
  // contracts.USDC was ContractInstance (untyped) — required manual cast
}).pipe(Effect.provide(Contracts))
```

After:
```typescript
import { makeContractRegistry } from 'voltaire-effect'

const Contracts = makeContractRegistry({ USDC: { abi, address: '0x...' } })

const program = Effect.gen(function* () {
  const contracts = yield* Contracts.Service
  // contracts.USDC is ContractInstance<typeof abi> — fully typed, no cast needed
}).pipe(Effect.provide(Contracts.layer))
```

This fixes a bug where ABI type information was erased through the generic `ContractRegistryService` tag, requiring users to manually cast contract instances to get type-safe `read`/`write`/`simulate` methods.
