import UIKit

class ViewController: UIViewController {

    let activityIndicator = MNKSwiftActivityIndicator()
//    let activityIndicator = MNKObjcActivityIndicator()
//    let activityIndicator = UIActivityIndicatorView(style: .gray)

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white

        view.addSubview(activityIndicator)
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        runSimpleAnimation()
    }

    private func runSimpleAnimation() {
        activityIndicator.startAnimating()
    }
}

