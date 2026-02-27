/**
 * @fileoverview makeContractRegistry for pre-configured, type-safe contract instances.
 *
 * @module ContractRegistry
 * @since 0.5.0
 *
 * @description
 * Provides a factory for defining and accessing a collection of typed contract
 * instances. Define your contracts once with their ABIs and addresses, then
 * access them as a named map throughout your application.
 *
 * @example
 * ```typescript
 * import { Effect } from 'effect'
 * import { makeContractRegistry, Provider, HttpTransport } from 'voltaire-effect'
 *
 * const erc20Abi = [...] as const
 *
 * const Contracts = makeContractRegistry({
 *   USDC: {
 *     abi: erc20Abi,
 *     address: '0xA0b86991c6218b36c1d19D4a2e9Eb0cE3606eB48'
 *   },
 *   WETH: {
 *     abi: erc20Abi,
 *     address: '0xC02aaA39b223FE8D0A0e5C4F27eAD9083C756Cc2'
 *   }
 * } as const)
 *
 * const program = Effect.gen(function* () {
 *   const contracts = yield* Contracts.Service
 *   const usdcBalance = yield* contracts.USDC.read.balanceOf(userAddress)
 *   const wethBalance = yield* contracts.WETH.read.balanceOf(userAddress)
 *   return { usdcBalance, wethBalance }
 * }).pipe(
 *   Effect.provide(Contracts.layer),
 *   Effect.provide(Provider),
 *   Effect.provide(HttpTransport('https://...'))
 * )
 * ```
 */

import type { BrandedAddress } from "@tevm/voltaire";
import * as Context from "effect/Context";
import * as Effect from "effect/Effect";
import * as Layer from "effect/Layer";
import { ProviderService } from "../Provider/index.js";
import { Contract } from "./Contract.js";
import type { Abi, ContractInstance } from "./ContractTypes.js";

type AddressType = BrandedAddress.AddressType;

/**
 * Configuration for a single contract.
 *
 * @since 0.5.0
 */
export interface ContractDef<TAbi extends Abi = Abi> {
	/** The contract ABI */
	readonly abi: TAbi;
	/** The contract address (optional - can be set later via at()) */
	readonly address?: AddressType | `0x${string}`;
}

/**
 * Configuration map for multiple contracts.
 *
 * @since 0.5.0
 */
export type ContractRegistryConfig = {
	readonly [name: string]: ContractDef;
};

/**
 * Factory for creating contract instances when address is not pre-configured.
 *
 * @since 0.5.0
 */
export interface ContractFactory<TAbi extends Abi> {
	/** The contract ABI */
	readonly abi: TAbi;
	/** Create a contract instance at the given address */
	readonly at: (
		address: AddressType | `0x${string}`,
	) => Effect.Effect<ContractInstance<TAbi>, never, ProviderService>;
}

/**
 * Maps contract config to contract instances.
 *
 * @since 0.5.0
 */
export type ContractRegistryShape<TConfig extends ContractRegistryConfig> = {
	readonly [K in keyof TConfig]: TConfig[K]["address"] extends
		| AddressType
		| `0x${string}`
		? ContractInstance<TConfig[K]["abi"]>
		: ContractFactory<TConfig[K]["abi"]>;
};

/**
 * Return type of makeContractRegistry.
 *
 * @since 1.1.0
 */
export interface ContractRegistry<TConfig extends ContractRegistryConfig> {
	/** Typed service tag — use `yield* Contracts.Service` to access the registry */
	readonly Service: Context.Tag<
		ContractRegistryShape<TConfig>,
		ContractRegistryShape<TConfig>
	>;
	/** Layer providing the typed contract registry */
	readonly layer: Layer.Layer<
		ContractRegistryShape<TConfig>,
		never,
		ProviderService
	>;
}

/**
 * Creates a typed contract registry with a Service tag and Layer.
 *
 * @param config - Map of contract names to their configurations (abi + optional address)
 * @returns Object with `Service` (typed tag) and `layer` (providing the service)
 *
 * @since 0.5.0
 *
 * @example With addresses (fully typed instances)
 * ```typescript
 * const Contracts = makeContractRegistry({
 *   USDC: {
 *     abi: erc20Abi,
 *     address: '0xA0b86991c6218b36c1d19D4a2e9Eb0cE3606eB48'
 *   }
 * })
 *
 * const program = Effect.gen(function* () {
 *   const { USDC } = yield* Contracts.Service
 *   return yield* USDC.read.balanceOf(userAddress)
 * })
 * ```
 *
 * @example Without addresses (factory pattern)
 * ```typescript
 * const Contracts = makeContractRegistry({
 *   ERC20: { abi: erc20Abi }  // no address
 * })
 *
 * const program = Effect.gen(function* () {
 *   const { ERC20 } = yield* Contracts.Service
 *   const token = yield* ERC20.at('0x...')
 *   return yield* token.read.balanceOf(userAddress)
 * })
 * ```
 */
export const makeContractRegistry = <
	const TConfig extends ContractRegistryConfig,
>(
	config: TConfig,
): ContractRegistry<TConfig> => {
	type Registry = ContractRegistryShape<TConfig>;

	const Service = Context.GenericTag<Registry>("ContractRegistryService");

	const layer = Layer.effect(
		Service,
		Effect.gen(function* () {
			const registry: Record<string, unknown> = {};

			for (const [name, contractDef] of Object.entries(config)) {
				if (contractDef.address !== undefined) {
					const instance = yield* Contract(
						contractDef.address,
						contractDef.abi,
					);
					registry[name] = instance;
				} else {
					const factory: ContractFactory<Abi> = {
						abi: contractDef.abi,
						at: (address) => Contract(address, contractDef.abi),
					};
					registry[name] = factory;
				}
			}

			return registry as Registry;
		}),
	);

	return { Service, layer };
};
