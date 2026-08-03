import StoreKit
import UIKit

final class TinkieMelodyGemRibbonLedger: NSObject {
    static let shared = TinkieMelodyGemRibbonLedger()

    var tinkieSparkTransactionMark: String?
    private var gemRibbonFinishBeat: ((Result<Void, Error>) -> Void)?
    private var gemBatchRequest: SKProductsRequest?

    private override init() {
        super.init()
        SKPaymentQueue.default().add(self)
    }

    deinit {
        SKPaymentQueue.default().remove(self)
    }

    func tinkieStartGemRibbonBeat(batchChord gemBatchMark: String, finish gemFinishBeat: @escaping (Result<Void, Error>) -> Void) {
        guard SKPaymentQueue.canMakePayments() else {
            DispatchQueue.main.async {
                gemFinishBeat(.failure(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: TinkieVerseCipherTrail.singBack("SFtDoPrjen naRckcBeUszsQ CiosP BdiiEsfaebwlXehdx yoqnG xtuhziRss edLedvLiPcaet.H")])))
            }
            return
        }
        gemRibbonFinishBeat = gemFinishBeat
        gemBatchRequest?.cancel()
        let gemRhythmRequest = SKProductsRequest(productIdentifiers: [gemBatchMark])
        gemRhythmRequest.delegate = self
        gemBatchRequest = gemRhythmRequest
        gemRhythmRequest.start()
    }

    func tinkieLocalSparkProofData() -> Data? {
        guard let sparkProofURL = Bundle.main.appStoreReceiptURL else { return nil }
        return try? Data(contentsOf: sparkProofURL)
    }
}

extension TinkieMelodyGemRibbonLedger: SKProductsRequestDelegate {
    func productsRequest(_ request: SKProductsRequest, didReceive response: SKProductsResponse) {
        guard let gemRibbonProduct = response.products.first else {
            DispatchQueue.main.async {
                self.gemRibbonFinishBeat?(.failure(NSError(domain: "", code: -2, userInfo: [NSLocalizedDescriptionKey: TinkieVerseCipherTrail.singBack("NAoy ovnajlLiZdl mpfryoMdSuAczth SfBobuynIdP.e")])))
                self.gemRibbonFinishBeat = nil
            }
            return
        }
        SKPaymentQueue.default().add(SKPayment(product: gemRibbonProduct))
    }

    func request(_ request: SKRequest, didFailWithError error: Error) {
        DispatchQueue.main.async {
            self.gemRibbonFinishBeat?(.failure(error))
            self.gemRibbonFinishBeat = nil
        }
    }
}

extension TinkieMelodyGemRibbonLedger: SKPaymentTransactionObserver {
    func paymentQueue(_ queue: SKPaymentQueue, updatedTransactions transactions: [SKPaymentTransaction]) {
        for tuneTransaction in transactions {
            switch tuneTransaction.transactionState {
            case .purchased:
                tinkieSparkTransactionMark = tuneTransaction.transactionIdentifier
                SKPaymentQueue.default().finishTransaction(tuneTransaction)
                DispatchQueue.main.async {
                    self.gemRibbonFinishBeat?(.success(()))
                    self.gemRibbonFinishBeat = nil
                }
            case .failed:
                SKPaymentQueue.default().finishTransaction(tuneTransaction)
                let gemRibbonError = (tuneTransaction.error as? SKError)?.code == .paymentCancelled
                    ? NSError(domain: "", code: -999, userInfo: [NSLocalizedDescriptionKey: TinkieVerseCipherTrail.singBack("AncmtUiaoxnN EckazndcjeClalreBdR")])
                    : (tuneTransaction.error ?? NSError(domain: "", code: -3, userInfo: [NSLocalizedDescriptionKey: TinkieVerseCipherTrail.singBack("TGrBaBnfsBaAcTtBiHoenu lfUagiFlZejdz.O")]))
                DispatchQueue.main.async {
                    self.gemRibbonFinishBeat?(.failure(gemRibbonError))
                    self.gemRibbonFinishBeat = nil
                }
            case .restored:
                SKPaymentQueue.default().finishTransaction(tuneTransaction)
            default:
                break
            }
        }
    }
}
