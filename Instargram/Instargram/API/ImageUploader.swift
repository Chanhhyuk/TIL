import FirebaseStorage
// 그냥 Image로 올리면 지원하는 형식이 아니라고 에러가 나서 한번 여기서 프로필 이미지를 지원하는 형식으로 바꿔준다

// AuthService에서 사용
struct ImageUploader {
    // #escaping(String)을 한 이유는 이미지를 업로드할 때 해당 이미지의 URL을 다운로드 할거기 떄문?
    static func uploadImage(image: UIImage, completion: @escaping(String) -> Void) {
        guard let imageData = image.jpegData(compressionQuality: 0.75) else { return }  // jpeg 압축 품질을 결정 0 ~ 1사이
        let filename = NSUUID().uuidString          // NSUUID 생성 (16비트의 난수가 매번 다르게 생성)
        let ref = Storage.storage().reference(withPath: "/profile_images/\(filename)")      // 저장소의 이 경로를 참조해라
        
        ref.putData(imageData, metadata: nil) { metadata, error in  // firebaseStorage에 이미지를 업로드
            if let error = error { return }             // error가 나타날 경우 종료
            ref.downloadURL { url, error in             // 업로드한 이미지 url을 가져오기
                
                guard let imageUrl = url?.absoluteString else { return }
                // 따라서 업로드 프로세스가 완료될때까지 파일을 반환하지 않는다
                completion(imageUrl)
            }
        }
        
        
    }
}
