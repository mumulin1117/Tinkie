import StoreKit
import SwiftyStoreKit
import UIKit

final class TinkieMelodyGemRibbonLedger {
    static let shared = TinkieMelodyGemRibbonLedger()

    var tinkieSparkTransactionMark: String?
    private var gemRibbonRequest: InAppRequest?
    private var gemRibbonWarmRequest: InAppRequest?
    private var warmedRibbonMarks = Set<String>()
    private init() {}

    func tinkieStartGemRibbonBeat(batchChord gemBatchMark: String, finish gemFinishBeat: @escaping (Result<Void, Error>) -> Void) {
        guard tinkieGemRibbonCanBegin() else {
            tinkieFinishGemRibbonBeat(.failure(Self.tinkieGemRibbonUnavailableError()), finish: gemFinishBeat)
            return
        }
        tinkieReadyGemRibbonBeat(gemBatchMark: gemBatchMark) { [weak self] in
            self?.tinkieBeginGemRibbonBeat(gemBatchMark: gemBatchMark, allowsEncore: true, finish: gemFinishBeat)
        }
    }

    func tinkieLocalSparkProofData() -> Data? {
        SwiftyStoreKit.localReceiptData
    }

    static func tinkieSealOpenGemTransactions() {
        shared.tinkieWarmGemRibbonDeck()
        SwiftyStoreKit.completeTransactions(atomically: true) { gemPurchases in
            guard let newestSpark = gemPurchases.last?.transaction.transactionIdentifier else { return }
            TinkieMelodyGemRibbonLedger.shared.tinkieSparkTransactionMark = newestSpark
        }
    }

    private func tinkieGemRibbonCanBegin() -> Bool {
        SwiftyStoreKit.canMakePayments
    }

    private func tinkieFinishGemRibbonBeat(_ gemResult: Result<Void, Error>, finish gemFinishBeat: @escaping (Result<Void, Error>) -> Void) {
        DispatchQueue.main.async {
            gemFinishBeat(gemResult)
        }
    }

    private func tinkieWarmGemRibbonDeck() {
        let ribbonMarks = Set(TinkieSongQuestRootscore.shared.tinkieGemRibbonBatchDeck.keys)
        guard !ribbonMarks.isEmpty else { return }
        gemRibbonWarmRequest?.cancel()
        gemRibbonWarmRequest = SwiftyStoreKit.retrieveProductsInfo(ribbonMarks) { [weak self] ribbonResult in
            DispatchQueue.main.async {
                self?.gemRibbonWarmRequest = nil
                self?.warmedRibbonMarks.formUnion(ribbonResult.retrievedProducts.map(\.productIdentifier))
            }
        }
    }

    private func tinkieReadyGemRibbonBeat(gemBatchMark: String, then readyBeat: @escaping () -> Void) {
        if warmedRibbonMarks.contains(gemBatchMark) {
            readyBeat()
            return
        }
        gemRibbonWarmRequest?.cancel()
        gemRibbonWarmRequest = SwiftyStoreKit.retrieveProductsInfo([gemBatchMark]) { [weak self] ribbonResult in
            DispatchQueue.main.async {
                self?.gemRibbonWarmRequest = nil
                self?.warmedRibbonMarks.formUnion(ribbonResult.retrievedProducts.map(\.productIdentifier))
                readyBeat()
            }
        }
    }

    private func tinkieBeginGemRibbonBeat(gemBatchMark: String, allowsEncore: Bool, finish gemFinishBeat: @escaping (Result<Void, Error>) -> Void) {
        gemRibbonRequest?.cancel()
        gemRibbonRequest = SwiftyStoreKit.purchaseProduct(gemBatchMark, quantity: 1, atomically: true) { [weak self] gemResult in
            DispatchQueue.main.async {
                self?.tinkieCloseGemRibbonBeat(gemResult, gemBatchMark: gemBatchMark, allowsEncore: allowsEncore, finish: gemFinishBeat)
            }
        }
    }

    private func tinkieCloseGemRibbonBeat(_ gemResult: PurchaseResult, gemBatchMark: String, allowsEncore: Bool, finish gemFinishBeat: @escaping (Result<Void, Error>) -> Void) {
        gemRibbonRequest = nil
        switch gemResult {
        case .success(let gemPurchase):
            tinkieSparkTransactionMark = gemPurchase.transaction.transactionIdentifier
            gemFinishBeat(.success(()))
        case .error(let gemError):
            if allowsEncore, Self.tinkieGemRibbonNeedsEncore(gemError) {
                tinkieBeginGemRibbonBeat(gemBatchMark: gemBatchMark, allowsEncore: false, finish: gemFinishBeat)
                return
            }
            gemFinishBeat(.failure(Self.tinkieGemRibbonError(from: gemError)))
        }
    }

    private static func tinkieGemRibbonUnavailableError() -> Error {
        NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: TinkieVerseCipherTrail.singBack("SFtDoPrjen naRckcBeUszsQ CiosP BdiiEsfaebwlXehdx yoqnG xtuhziRss edLedvLiPcaet.H")])
    }

    private static func tinkieGemRibbonError(from gemError: SKError) -> Error {
        if gemError.code == .paymentCancelled {
            return NSError(domain: "", code: -999, userInfo: [NSLocalizedDescriptionKey: TinkieVerseCipherTrail.singBack("AncmtUiaoxnN EckazndcjeClalreBdR")])
        }
        return gemError
    }

    private static func tinkieGemRibbonNeedsEncore(_ gemError: SKError) -> Bool {
        switch gemError.code {
        case .unknown, .cloudServiceNetworkConnectionFailed:
            return true
        default:
            return false
        }
    }
}
