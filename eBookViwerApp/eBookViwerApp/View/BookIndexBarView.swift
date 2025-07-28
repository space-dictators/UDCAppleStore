//
//  BookIndexBarView.swift
//  eBookViwerApp
//
//  Created by Yoon on 6/19/25.
//

import SnapKit
import UIKit

final class BookIndexBarView: UIView {
    let stackView = UIStackView()

    // 버튼 저장용 배열
    private var buttons: [BookIndexButton] = []

    // 각 버튼을 눌렀을 때 사용할 클로저
    var didSelectVolume: ((Int) -> Void)?

    // 최초 설정
    override init(frame: CGRect) {
        super.init(frame: frame)

        // 버튼을 담을 수평 스택 뷰 생성
        stackView.axis = .horizontal
        stackView.spacing = 10
        stackView.distribution = .equalCentering
        stackView.alignment = .center

        // 스택 뷰 추가
        addSubview(stackView)

        // 오토 레이아웃
        stackView.snp.makeConstraints {
            $0.top.bottom.equalToSuperview()
            // greaterThan/lessThan 결정이 안된 값
            // 안에서도 결정이 안된값을 줘서 오토 레이아웃이 모호하게 됐다.
            $0.leading.equalToSuperview().offset(20)
            $0.trailing.equalToSuperview().offset(-20)
            $0.centerX.equalToSuperview() // 여기?
        }
    }

    // 시리즈 권수와 현재 선택 시리즈 번호를 받아서 최초 버튼 생성
    func setup(volumeCount: Int, initialVolume: Int) {
        // 시리즈 숫자만큼 버튼 생성
        for index in 1 ... volumeCount {
            let button = BookIndexButton()
            // 각권 번호 입력
            button.configure(with: index)

            // 최초 선택된 버튼에 isSelected = true / 그외 false 할당
            button.isSelected = (index == initialVolume)

            // 버튼 크기 레이아웃
            button.snp.makeConstraints {
                $0.width.height.equalTo(32)
            }

            // 버튼 액션 설정 (클로저 통해 ViewController로 선택한 시리즈 번호 전달)
            button.addAction(UIAction { [weak self] _ in
                self?.didSelectVolume?(index)
            }, for: .touchUpInside)

            // 관리용 배열에 버튼 추가
            buttons.append(button)

            // 스택뷰에 버튼 추가
            stackView.addArrangedSubview(button)
        }
    }

    // 번호를 눌렀을 때 각 버튼의 isSelected 값 변경
    func updateSelectedIndex(to selectedIndex: Int) {
        for button in buttons {
            button.isSelected = (button.index == selectedIndex)
        }
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}
