import UIKit

import SnapKit
import Then


class MainViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        setupBaseUI()
    }

    func setupBaseUI() {
        view.backgroundColor = .ucdBackground
        title = " UCD Apple Store"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.largeTitleDisplayMode = .always
    }
}
