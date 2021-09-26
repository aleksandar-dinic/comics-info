//
//  GoogleBannerViewController.swift
//  ComicsInfo
//
//  Created by Aleksandar Dinic on 30/08/2021.
//

import SwiftUI
import GoogleMobileAds
import UIKit

final class GoogleBannerViewController: UIViewControllerRepresentable  {
    
    private lazy var viewController = HelpViewController()
    private let adSize: GADAdSize
    private let adUnitID: String
    private let request: GADRequest
    
    init(
        didReceiveAd: @escaping () -> Void,
        adSize: GADAdSize = kGADAdSizeBanner,
        adUnitID: String = Environment.adUnitID,
        request: GADRequest = GADRequest()
    ) {
        self.adSize = adSize
        self.adUnitID = adUnitID
        self.request = request
        viewController.didReceiveAd = didReceiveAd
    }

    func makeUIViewController(context: Context) -> UIViewController {
        let view = GADBannerView(adSize: adSize)

        view.adUnitID = adUnitID
        view.rootViewController = viewController
        viewController.view.addSubview(view)
        viewController.view.frame = CGRect(origin: .zero, size: adSize.size)
        view.delegate = viewController
        view.load(request)

        return viewController
    }

    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {
    }
    
    private final class HelpViewController: UIViewController, GADBannerViewDelegate {
        
        var didReceiveAd: (() -> Void)!
        
        func bannerViewDidReceiveAd(_ bannerView: GADBannerView) {
            didReceiveAd()
        }

    }
    
}
