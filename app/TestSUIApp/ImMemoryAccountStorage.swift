//
//  ImMemoryAccountStorage.swift
//  TestSUIApp
//
//  Created by Влад Мади on 12.08.2022.
//

import Foundation
import SolanaSwift
import OrcaSwapSwift

class InMemoryAccountStorage: SolanaAccountStorage {
    
    static let shared = InMemoryAccountStorage()
    private init() { }
    
    private var _account: Account?
    func save(_ account: Account) throws {
        _account = account
    }
    
    var account: Account? {
        _account
    }
    
    func restoreAccount(phrase: String) async {
        let words = phrase.components(separatedBy: " ")
        let account = try! await Account(phrase: words, network: .mainnetBeta, derivablePath: .default)
        print("PUBLIC KEY: \(account.publicKey)")
        print("SECRET KEY: \(account.secretKey.base64EncodedString())")
        try! InMemoryAccountStorage.shared.save(account)
    }
}

class BlockchainClient {
//    var apiClient: SolanaAPIClient
    
    static let shared = BlockchainClient()
    private init() { }
    
//    func prepareTransaction(instructions: [TransactionInstruction], signers: [Account], feePayer: PublicKey, feeCalculator: FeeCalculator?) async throws -> PreparedTransaction {
//        
//    }
}

//class Orca {
//    static let shared = Orca()
//    private init() { }
//
//    static let orcaSwap = OrcaSwap(apiClient: APIClient(configsProvider: NetworkConfigsProvider(network: "mainnet")),
//                                   solanaClient: ApiClient(),
//                                   blockchainClient: BlockchainClient.shared,
//                                   accountStorage: InMemoryAccountStorage.shared)
//
//}

struct EndPoint {
    static let endpoint = APIEndPoint(
        address: "https://api.mainnet-beta.solana.com",
        network: .mainnetBeta
    )
}




class ApiClient  {
    var endpoint: APIEndPoint = APIEndPoint(address: EndPoint.endpoint.address, network: EndPoint.endpoint.network)
    
//    func getAccountInfo<T>(account: String) async throws -> BufferInfo<T>? where T : BufferLayout {
//        <#code#>
//    }
//
//    func getBalance(account: String, commitment: Commitment?) async throws -> UInt64 {
//        <#code#>
//    }
//
//    func getBlockCommitment(block: UInt64) async throws -> BlockCommitment {
//        <#code#>
//    }
//
//    func getBlockTime(block: UInt64) async throws -> Date {
//        <#code#>
//    }
//
//    func getClusterNodes() async throws -> [ClusterNodes] {
//        <#code#>
//    }
//
//    func getBlockHeight() async throws -> UInt64 {
//        <#code#>
//    }
//
//    func getConfirmedBlocksWithLimit(startSlot: UInt64, limit: UInt64) async throws -> [UInt64] {
//        <#code#>
//    }
//
//    func getConfirmedBlock(slot: UInt64, encoding: String) async throws -> ConfirmedBlock {
//        <#code#>
//    }
//
//    func getConfirmedSignaturesForAddress(account: String, startSlot: UInt64, endSlot: UInt64) async throws -> [String] {
//        <#code#>
//    }
//
//    func getEpochInfo(commitment: Commitment?) async throws -> EpochInfo {
//        <#code#>
//    }
//
//    func getFees(commitment: Commitment?) async throws -> Fee {
//        <#code#>
//    }
//
//    func getSignatureStatuses(signatures: [String], configs: RequestConfiguration?) async throws -> [SignatureStatus?] {
//        <#code#>
//    }
//
//    func getSignatureStatus(signature: String, configs: RequestConfiguration?) async throws -> SignatureStatus {
//        <#code#>
//    }
//
//    func getTokenAccountBalance(pubkey: String, commitment: Commitment?) async throws -> TokenAccountBalance {
//        <#code#>
//    }
//
//    func getTokenAccountsByDelegate(pubkey: String, mint: String?, programId: String?, configs: RequestConfiguration?) async throws -> [TokenAccount<AccountInfo>] {
//        <#code#>
//    }
//
//    func getTokenAccountsByOwner(pubkey: String, params: OwnerInfoParams?, configs: RequestConfiguration?) async throws -> [TokenAccount<AccountInfo>] {
//        <#code#>
//    }
//
//    func getTokenLargestAccounts(pubkey: String, commitment: Commitment?) async throws -> [TokenAmount] {
//        <#code#>
//    }
//
//    func getTokenSupply(pubkey: String, commitment: Commitment?) async throws -> TokenAmount {
//        <#code#>
//    }
//
//    func getVersion() async throws -> Version {
//        <#code#>
//    }
//
//    func getVoteAccounts(commitment: Commitment?) async throws -> VoteAccounts {
//        <#code#>
//    }
//
//    func minimumLedgerSlot() async throws -> UInt64 {
//        <#code#>
//    }
//
//    func requestAirdrop(account: String, lamports: UInt64, commitment: Commitment?) async throws -> String {
//        <#code#>
//    }
//
//    func sendTransaction(transaction: String, configs: RequestConfiguration) async throws -> TransactionID {
//        <#code#>
//    }
//
//    func simulateTransaction(transaction: String, configs: RequestConfiguration) async throws -> SimulationResult {
//        <#code#>
//    }
//
//    func setLogFilter(filter: String) async throws -> String? {
//        <#code#>
//    }
//
//    func validatorExit() async throws -> Bool {
//        <#code#>
//    }
//
//    func getMultipleAccounts<T>(pubkeys: [String]) async throws -> [BufferInfo<T>] where T : BufferLayout {
//        <#code#>
//    }
//
//    func getSignaturesForAddress(address: String, configs: RequestConfiguration?) async throws -> [SignatureInfo] {
//        <#code#>
//    }
//
//    func getTransaction(signature: String, commitment: Commitment?) async throws -> TransactionInfo? {
//        <#code#>
//    }
//
//    func batchRequest(with requests: [JSONRPCRequestEncoder.RequestType]) async throws -> [AnyResponse<JSONRPCRequestEncoder.RequestType.Entity>] {
//        <#code#>
//    }
//
//    func batchRequest<Entity>(method: String, params: [[Encodable]]) async throws -> [Entity?] where Entity : Decodable {
//        <#code#>
//    }
    
    static let apiClient = JSONRPCAPIClient(endpoint: EndPoint.endpoint)
}

class RPCClient {

    func getBalance() async throws -> Double {
        guard let account = InMemoryAccountStorage.shared.account?.publicKey.base58EncodedString else { throw SolanaError.unauthorized }
      
        let balance = try await ApiClient.apiClient.getBalance(account: account, commitment: "recent")
        print(balance)
        let interfaceBalance = Double(balance) / 1000000000
        return interfaceBalance
    }
    
    
    func getUSDC() async throws -> Double {
        guard let account = InMemoryAccountStorage.shared.account?.publicKey else {
            throw SolanaError.unauthorized }
        let wallets = try await ApiClient.apiClient.getTokenWallets(account: account.base58EncodedString)
        
        for wallet in wallets {
            if wallet.token.address == Adresses.usdc.rawValue {
                return wallet.amount ?? 0.0
            }
        }
        return 0.0
    }
    
}



enum Adresses: String {
    case usdc = "EPjFWdd5AufqSSqeM2qN1xzybapC8G4wEGGkZwyTDt1v"
}

enum Pairs: String {
    case solUsdc = "4GpUivZ2jvZqQ3vJRsoq5PwnYv6gdV9fJ9BzHT2JcRr7"
}
