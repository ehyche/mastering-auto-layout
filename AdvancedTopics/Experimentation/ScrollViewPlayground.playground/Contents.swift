//: Playground - noun: a place where people can play

import UIKit
import PlaygroundSupport

class ScrollViewDelegate: NSObject, UIScrollViewDelegate {

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        print("scrollView.bounds = \(scrollView.bounds)")
    }
}

let containerView = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 512.0, height: 512.0))
containerView.backgroundColor = UIColor.lightGray

let scrollView = UIScrollView(frame: CGRect(x: 20.0, y: 20.0, width: 472.0, height: 472.0))
let scrollViewDelegate = ScrollViewDelegate()
scrollView.delegate = scrollViewDelegate

let image = UIImage(named: "tim-xlarge.jpg")
let imageView = UIImageView(image: image)
scrollView.addSubview(imageView)
scrollView.contentSize = image?.size ?? CGSize(width: 472.0, height: 472.0)

containerView.addSubview(scrollView)


PlaygroundPage.current.liveView = containerView
PlaygroundPage.current.needsIndefiniteExecution = true

