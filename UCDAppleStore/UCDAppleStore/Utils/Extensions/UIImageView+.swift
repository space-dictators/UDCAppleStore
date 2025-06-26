
import Kingfisher
import UIKit


extension UIImageView {
    /// url에서 이미지를 가져옵니다
    ///
    /// 사용법
    /// ```swift
    /// imageView.loadImage(from: url)
    ///```
    func loadImage(from url: URL, placeholder: UIImage? = nil) {
        kf.setImage(
            with: url,
            placeholder: placeholder,
            options: [
                .transition(.fade(0.3)),    //페이드 인 애니메이션
                .cacheOriginalImage,    // 원본 크기 이미지를 캐시에 저장
                .scaleFactor(UIScreen.main.scale)    // 기기의 스케일 팩터 사용
            ]
        )
    }
}
