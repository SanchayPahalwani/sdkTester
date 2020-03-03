//
//  ViewController.swift
//  sdkTester
//
//  Created by Sanchay on 14/11/19.
//  Copyright © 2019 Learning. All rights reserved.
//

import UIKit
import CruxPay

class ViewController: UIViewController {
    
    var success: Bool = true
    var failures: [String] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.initializeCrux()
    }
    
    func initializeCrux() {
        let configBuilder = CruxClientInitConfig.Builder()
        configBuilder.setWalletClientName(walletClientName: "cruxdev")
        configBuilder.setPrivateKey(privateKey: "cdf2d276caf0c9c34258ed6ebd0e60e0e8b3d9a7b8a9a717f2e19ed9b37f7c6f")
        var cc: CruxClient
        do {
            cc = try CruxClient(configBuilder: configBuilder)
        } catch {
            print("unsafe env detected")
            return;
        }
        
        
        cc.getCruxIDState(onResponse: getCruxIDStateSuccess(cruxState:), onErrorResponse: getCruxError(cruxError:))
        cc.isCruxIDAvailable(cruxIDSubdomain: "test123", onResponse: isCruxIDAvailableSuccess(cruxIDAvailable:), onErrorResponse: isCruxIDAvailableError(cruxError:))
        cc.putEnabledAssetGroups(symbolAssetGroups: ["ERC20_eth"], onResponse: putEnabledAssetGroupsSuccess(assetGroups:), onErrorResponse: putAddressMapError(cruxError:))
        cc.getEnabledAssetGroups(onResponse: getEnabledAssetGroupsSuccess(assetGroups:), onErrorResponse: getEnabledAssetGroupsError(cruxError:))
        cc.getAddressMap(onResponse: getAddressMapSuccess(addressMap:), onErrorResponse: getAddressMapError(cruxError:))
        let addressMap = ["xrp": Address(addressHash: "rpfKAA2Ezqoq5wWo3XENdLYdZ8YGziz48h", secIdentifier: Optional("12345")), "trx": CruxPay.Address(addressHash: "TG3iFaVvUs34SGpWq8RG9gnagDLTe1jdyr", secIdentifier: nil)]

        cc.putAddressMap(newAddressMap: addressMap, onResponse: putAddressMapSuccess(putAddressMapResponse:), onErrorResponse: putAddressMapError(cruxError:))
        cc.resolveCurrencyAddressForCruxID(fullCruxID: "shree_dhar@zel.crux", walletCurrencySymbol: "btc", onResponse: resolveCurrencyAddressForCruxIDSuccess(address: ), onErrorResponse: resolveCurrencyAddressForCruxIDError(cruxError:))
        cc.registerCruxID(cruxIDSubdomain: "alice", onResponse: registerCruxIDSuccess, onErrorResponse: registerCruxIDError(cruxError:))
        let privateAddressMap = ["btc": Address(addressHash: "bc1q34aq5drpuwy3wgl9lhup9892qp6svr8ldzyy7c", secIdentifier: nil)]
        let sampleCruxIDs: [String] = ["mascot6699@cruxdev.crux", "nonexistent@cruxdev.crux"]
        cc.putPrivateAddressMap(fullCruxIDs: sampleCruxIDs, newAddressMap: privateAddressMap, onResponse: putPrivateAddressMapSuccess(putAddressMapResponse:), onErrorResponse: putAddressMapError(cruxError:))
        cc.resolveCurrencyAddressForCruxID(fullCruxID: "mascot6699@cruxdev.crux", walletCurrencySymbol: "btc", onResponse: resolveCurrencyAddressForCruxIDSuccess(address: ), onErrorResponse: resolveCurrencyAddressForCruxIDError(cruxError:))
    }
    
    func getCruxIDStateSuccess(cruxState: CruxIDState) -> () {
        print(cruxState.cruxID)
        print(cruxState.status)
        print("Success getCruxIDState!")
    }
    
    func getCruxError(cruxError: CruxClientError) -> () {
        let failureString = "Failed getCruxIDState!"
        self.success = false
        self.failures.append(failureString)
        print(failureString)
        print(cruxError.errorCode)
        print(cruxError.message)
        print(cruxError.stack)
        print(cruxError.name)
    }
    
    func isCruxIDAvailableSuccess(cruxIDAvailable: Bool) -> () {
        print("cruxIDAvailable")
        print(cruxIDAvailable)
    }
    
    func isCruxIDAvailableError(cruxError: CruxClientError) -> () {
        let failureString = "Failed isCruxIDAvailable!"
        self.success = false
        self.failures.append(failureString)
        print(failureString)
        print(cruxError.errorCode)
        print(cruxError.message)
        print(cruxError.stack)
        print(cruxError.name)
    }
    
    func getAddressMapSuccess(addressMap: [String: CruxPay.Address]) -> () {
        print(addressMap)
        print("Success getAddressMap!")
    }
    
    func getAddressMapError(cruxError: CruxClientError) -> () {
        let failureString = "Failed getAddressMap!"
        self.success = false
        self.failures.append(failureString)
        print(failureString)
        print(cruxError.errorCode)
        print(cruxError.message)
        print(cruxError.stack)
        print(cruxError.name)
    }
    
    func putAddressMapSuccess(putAddressMapResponse: [String: [String: CruxPay.Address]]) -> () {
        print(putAddressMapResponse)
        print("Success putAddressMap!")
    }
    
    func putAddressMapError(cruxError: CruxClientError) -> () {
        let failureString = "Failed putAddressMap!"
        self.success = false
        self.failures.append(failureString)
        print(failureString)
        print(cruxError.errorCode)
        print(cruxError.message)
        print(cruxError.stack)
        print(cruxError.name)
    }
    
    func putPrivateAddressMapSuccess(putAddressMapResponse: [String: [CruxPay.GenericError]]) -> () {
        print(putAddressMapResponse)
        print("Success putPrivateAddressMap!")
        printSuccessOrFailure()
    }
    
    func putPrivateAddressMapError(cruxError: CruxClientError) -> () {
        let failureString = "Failed putPrivateAddressMap!"
        self.success = false
        self.failures.append(failureString)
        print(failureString)
        print(cruxError.errorCode)
        print(cruxError.message)
        print(cruxError.stack)
        print(cruxError.name)
        printSuccessOrFailure()
    }
    
    func resolveCurrencyAddressForCruxIDSuccess(address: CruxPay.Address) -> () {
        print("Success resolveCurrencyAddressForCruxID!")
        print(address)
    }
    
    func resolveCurrencyAddressForCruxIDError(cruxError: CruxClientError) -> () {
        let failureString = "Failed resolveCurrencyAddressForCruxID!"
        self.success = false
        self.failures.append(failureString)
        print(failureString)
        print(cruxError.errorCode)
        print(cruxError.message)
        print(cruxError.stack)
        print(cruxError.name)
    }
    
    func registerCruxIDSuccess() -> () {
        print("Success registerCruxID!")
    }
    
    func registerCruxIDError(cruxError: CruxClientError) -> () {
        let failureString = "Failed registerCruxID!"
        print(failureString)
        print(cruxError.errorCode)
        print(cruxError.message)
        print(cruxError.stack)
        print(cruxError.name)
    }
    
    func getEnabledAssetGroupsSuccess(assetGroups: [String]) -> () {
        print(assetGroups)
        print("Success getEnabledAssetGroups!")
    }
    
    func getEnabledAssetGroupsError(cruxError: CruxClientError) -> () {
        let failureString = "Failed getEnabledAssetGroups!"
        self.success = false
        self.failures.append(failureString)
        print(failureString)
        print(cruxError.errorCode)
        print(cruxError.message)
        print(cruxError.stack)
        print(cruxError.name)
    }
    
    func putEnabledAssetGroupsSuccess(assetGroups: [String]) -> () {
        print(assetGroups)
        print("Success putEnabledAssetGroups!")
    }
    
    func putEnabledAssetGroupsError(cruxError: CruxClientError) -> () {
        let failureString = "Failed putEnabledAssetGroups!"
        self.success = false
        self.failures.append(failureString)
        print(failureString)
        print(cruxError.errorCode)
        print(cruxError.message)
        print(cruxError.stack)
        print(cruxError.name)
    }
    
    func printSuccessOrFailure() -> () {
        if (self.success == false) {
            print("========FAILED========!!")
            print(self.failures)
        } else {
            print("========SUCCESS========!!")
        }
    }
}

