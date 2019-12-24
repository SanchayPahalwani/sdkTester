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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.initializeCrux()
    }
    
    func initializeCrux() {
        let configBuilder = CruxClientInitConfig.Builder()
        configBuilder.setWalletClientName(walletClientName: "cruxdev")
        configBuilder.setPrivateKey(privateKey: "cdf2d276caf0c9c34258ed6ebd0e60e0e8b3d9a7b8a9a717f2e19ed9b37f7c6f")
        let cc = CruxClient(configBuilder: configBuilder)
        

        cc.getCruxIDState(onResponse: getCruxIDStateSuccess(cruxState:), onErrorResponse: getCruxError(cruxError:))
        cc.isCruxIDAvailable(cruxIDSubdomain: "test123", onResponse: isCruxIDAvailableSuccess(cruxIDAvailable:), onErrorResponse: isCruxIDAvailableError(cruxError:))
        cc.getAddressMap(onResponse: getAddressMapSuccess(addressMap:), onErrorResponse: getAddressMapError(cruxError:))
        let addressMap = ["xrp": Address(addressHash: "rpfKAA2Ezqoq5wWo3XENdLYdZ8YGziz48h", secIdentifier: Optional("12345")), "trx": CruxPay.Address(addressHash: "TG3iFaVvUs34SGpWq8RG9gnagDLTe1jdyr", secIdentifier: nil)]
         
        cc.putAddressMap(newAddressMap: addressMap, onResponse: putAddressMapSuccess(putAddressMapResponse:), onErrorResponse: putAddressMapError(cruxError:))
        cc.resolveCurrencyAddressForCruxID(fullCruxID: "shree_dhar@zel.crux", walletCurrencySymbol: "btc", onResponse: resolveCurrencyAddressForCruxIDSuccess(address: ), onErrorResponse: resolveCurrencyAddressForCruxIDError(cruxError:))
//        cc.registerCruxID(cruxIDSubdomain: "alice", onResponse: registerCruxIDSuccess, onErrorResponse: registerCruxIDError(cruxError:))
    }
    
    func getCruxIDStateSuccess(cruxState: CruxIDState) -> () {
        print(cruxState.cruxID)
        print(cruxState.status)
        print("Success getCruxIDState!")
    }
    
    func getCruxError(cruxError: CruxClientError) -> () {
        print("Failed getCruxIDState!")
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
        print("Failed isCruxIDAvailable!")
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
        print("Failed getAddressMap!")
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
        print("Failed putAddressMap!")
        print(cruxError.errorCode)
        print(cruxError.message)
        print(cruxError.stack)
        print(cruxError.name)
    }
    
    func resolveCurrencyAddressForCruxIDSuccess(address: CruxPay.Address) -> () {
        print("Success resolveCurrencyAddressForCruxID!")
        print(address)
    }
    
    func resolveCurrencyAddressForCruxIDError(cruxError: CruxClientError) -> () {
        print("Failed resolveCurrencyAddressForCruxID!")
        print(cruxError.errorCode)
        print(cruxError.message)
        print(cruxError.stack)
        print(cruxError.name)
    }
    
    func registerCruxIDSuccess() -> () {
        print("Success registerCruxID!")
    }
    
    func registerCruxIDError(cruxError: CruxClientError) -> () {
        print("Failed registerCruxID!")
        print(cruxError.errorCode)
        print(cruxError.message)
        print(cruxError.stack)
        print(cruxError.name)
    }
}

