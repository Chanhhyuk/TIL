import FirebaseStorage
// 이미지를 업로드 할 때마다 이 코드들 실행
// 사용자 프로필 이미지임을 확인할 수 있또록 이미지를 저장소에 업로드 해야 한다

// 업로드 할 때 해당 이미지의 URL을 다운로드
struct ImageUploader {
    // 이미지 URL을 가져온다 String 형식으로
    // completion: @escaping는 이미지를 Firebase에 전송한다
    // 그리고 해당 프로세스가 완료되면 이 완료 핸들러를 실행하고 다운로드를 다시 제공한다.
    static func uploadImage(image: UIImage, completion: @escaping(String) -> Void) {
        // 이미지에 대한 업로드 데이터
        // JPEG 데이터 확장자. JPEG 데이터를 생성하고 제공한다.
        guard let imageData = image.jpegData(compressionQuality: 0.75) else { return }
        let filename = NSUUID().uuidString
        let ref = Storage.storage().reference(withPath: "/profile_images/\(filename)")
        ref.putData(imageData, metadata: nil) { metadata, error in
            if let error = error {
                return
            }
            // 여기까지가 업로드 프로세스
            // 전체 업로드 프로세스가 완료될 때까지 파일을 반환하지 않는다
            // 따라서 다음 단계로 넘어가기 전에 완료되었음을 보장할 수 있다
            
            // 문자열 반환값과 같으면 계속해서 완료?
            // 이미지에 대한 다운로드 URL이며 완료되면 완료 핸들러를 실행
            ref.downloadURL { url, error in
                guard let imageUrl = url?.absoluteString else { return }
                completion(imageUrl)
                // 전
            }
        }
    }
}
