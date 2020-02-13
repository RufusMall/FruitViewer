//
//  CanvasPreviewHelpers.swift
//  FruitViewer
//
//  Created by Rufus on 13/02/2020.
//  Copyright © 2020 Rufus. All rights reserved.
//

import Foundation
import SwiftUI

public struct ViewContainerView: UIViewRepresentable {
    public typealias UIViewType = UIView
    let viewController: UIView
    
    init(viewController: UIView) {
        self.viewController = viewController
    }
    
    public func makeUIView(context: UIViewRepresentableContext<ViewContainerView>) -> UIView {
        return viewController
    }
    
    public func updateUIView(_ uiView: UIView, context: UIViewRepresentableContext<ViewContainerView>) {
    }
}

public class ViewPreviewProvider<T: UIView> {
    static var previews: some View {
        return ViewContainerView(viewController: makeView())
    }

    class func makeView() -> UIView {
        
        let view = T(frame: .zero)
        if let collectionView = view as? UICollectionViewCell {
            return collectionView.contentView
        }
        return view
    }
}

public struct ViewControllerContainerView : UIViewControllerRepresentable {
    public typealias UIViewControllerType = UIViewController
    let viewController: UIViewController
    
    init(viewController: UIViewController) {
        self.viewController = viewController
    }
    
    public func makeUIViewController(context: UIViewControllerRepresentableContext<ViewControllerContainerView>) -> UIViewControllerType {
        return viewController
    }
    
    public func updateUIViewController(_ uiViewController: UIViewControllerType, context: UIViewControllerRepresentableContext<ViewControllerContainerView>) {
    }
}

open class ViewControllerPreviewProvider<T: UIViewController> {
   public static var previews: some View {
        return ViewControllerContainerView(viewController: makeController()).edgesIgnoringSafeArea(.all)
    }
    
    open class func makeController() -> UIViewController {
        return T()
    }
}
