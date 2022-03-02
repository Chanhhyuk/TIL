import FirebaseStorage      // 파일 저장소


// AuthService에서 사용
struct ImageUploader {
    static func uploadImage(image: UIImage, completion: @escaping(String) -> Void) {
        guard let imageData = image.jpegData(compressionQuality: 0.75) else { return }  // jpeg 압축 품질을 결정 0 ~ 1사이
        let filename = NSUUID().uuidString          // NSUUID 생성 (16비트의 난수가 매번 다르게 생성)
        let ref = Storage.storage().reference(withPath: "/profile_images/\(filename)")
        
        ref.putData(imageData, metadata: nil) { metadata, error in  // firebaseStorage에 파일을 업로드
            if let error = error { return }
            ref.downloadURL { url, error in
                guard let imageUrl = url?.absoluteString else { return }
                completion(imageUrl)
            }
        }
    }
}
