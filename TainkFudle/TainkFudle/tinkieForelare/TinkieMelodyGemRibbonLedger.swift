import StoreKit
import SwiftyStoreKit
import UIKit

final class TinkieMelodyGemRibbonLedger {
    static let shared = TinkieMelodyGemRibbonLedger()

    var tinkieSparkTransactionMark: String?
    private var gemRibbonRequest: InAppRequest?
    private init() {}

    func tinkieStartGemRibbonBeat(batchChord gemBatchMark: String, finish gemFinishBeat: @escaping (Result<Void, Error>) -> Void) {
        guard tinkieGemRibbonCanBegin() else {
            tinkieFinishGemRibbonBeat(.failure(Self.tinkieGemRibbonUnavailableError()), finish: gemFinishBeat)
            return
        }
        tinkieBeginGemRibbonBeat(gemBatchMark: gemBatchMark, finish: gemFinishBeat)
    }

    func tinkieLocalSparkProofData() -> Data? {
        SwiftyStoreKit.localReceiptData
    }

    static func tinkieSealOpenGemTransactions() {
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

    private func tinkieBeginGemRibbonBeat(gemBatchMark: String, finish gemFinishBeat: @escaping (Result<Void, Error>) -> Void) {
        gemRibbonRequest?.cancel()
        gemRibbonRequest = SwiftyStoreKit.purchaseProduct(gemBatchMark, quantity: 1, atomically: true) { [weak self] gemResult in
            DispatchQueue.main.async {
                self?.tinkieCloseGemRibbonBeat(gemResult, finish: gemFinishBeat)
            }
        }
    }

    private func tinkieCloseGemRibbonBeat(_ gemResult: PurchaseResult, finish gemFinishBeat: @escaping (Result<Void, Error>) -> Void) {
        gemRibbonRequest = nil
        switch gemResult {
        case .success(let gemPurchase):
            tinkieSparkTransactionMark = gemPurchase.transaction.transactionIdentifier
            gemFinishBeat(.success(()))
        case .error(let gemError):
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
}
