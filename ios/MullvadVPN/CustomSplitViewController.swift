//
//  CustomSplitViewController.swift
//  MullvadVPN
//
//  Created by pronebird on 07/04/2021.
//  Copyright © 2021 Mullvad VPN AB. All rights reserved.
//

import UIKit

class CustomSplitViewController: UISplitViewController, RootContainment {
    var preferredHeaderBarPresentation: HeaderBarPresentation {
        for case let viewController as RootContainment in viewControllers {
            return viewController.preferredHeaderBarPresentation
        }
        return .default
    }

    var prefersHeaderBarHidden: Bool {
        for case let viewController as RootContainment in viewControllers {
            return viewController.prefersHeaderBarHidden
        }
        return false
    }

    var dividerColor: UIColor? {
        didSet {
            if isViewLoaded {
                self.updateDividerColor()
            }
        }
    }

    override var childForStatusBarStyle: UIViewController? {
        if #available(iOS 13, *) {
            return super.childForStatusBarStyle
        } else {
            return viewControllers.last
        }
    }

    override var childForStatusBarHidden: UIViewController? {
        if #available(iOS 13, *) {
            return super.childForStatusBarHidden
        } else {
            return viewControllers.last
        }
    }

    override var shouldAutomaticallyForwardAppearanceMethods: Bool {
        // iOS 12: force split view controller to forward appearance events.
        return true
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

        updateDividerColor()
    }

    private var dividerView: UIView? {
        let subviews = view.subviews.flatMap { view -> [UIView] in
            return [view] + view.subviews
        }

        return subviews.first { view -> Bool in
            return view.description.hasPrefix("<UIPanelBorderView")
        }
    }

    private func updateDividerColor() {
        guard let dividerColor = dividerColor else { return }

        dividerView?.backgroundColor = dividerColor
    }

    override func overrideTraitCollection(forChild childViewController: UIViewController)
        -> UITraitCollection?
    {
        guard let traitCollection = super.overrideTraitCollection(forChild: childViewController)
        else { return nil }

        // Pass the split controller's horizontal size class to the primary controller when split
        // view is expanded.
        if !isCollapsed, childViewController == viewControllers.last {
            let sizeOverrideTraitCollection = UITraitCollection(
                horizontalSizeClass: self
                    .traitCollection.horizontalSizeClass
            )

            return UITraitCollection(traitsFrom: [traitCollection, sizeOverrideTraitCollection])
        } else {
            return traitCollection
        }
    }
}
