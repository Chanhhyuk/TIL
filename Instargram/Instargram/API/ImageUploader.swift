import FirebaseStorage
// 그냥 Image로 올리면 지원하는 형식이 아니라고 에러가 나서 한번 여기서 프로필 이미지를 지원하는 형식으로 바꿔준다

// 이미지 업로드와 관련된곳 (회원가입, 프로필 이미지 변경, 게시글 올릴때 이미지)
// 업로드도 제공하고 다운로드도 동시에 제공
struct ImageUploader {
    // #escaping(String)을 한 이유는 이미지를 업로드할 때 해당 이미지의 URL을 다운로드 할거기 때문
    static func uploadImage(image: UIImage, completion: @escaping(String) -> Void) {
        guard let imageData = image.jpegData(compressionQuality: 0.75) else { return }  // jpeg 압축 품질을 결정 0 ~ 1사이
        let filename = NSUUID().uuidString          // NSUUID 생성 (16비트의 난수가 매번 다르게 생성)
        let ref = Storage.storage().reference(withPath: "/profile_images/\(filename)")      // 저장소의 저장할 폴더이름 profile_images
        
        ref.putData(imageData, metadata: nil) { metadata, error in  // firebaseStorage에 이미지를 업로드
            if let error = error { return }             // error가 나타날 경우 종료
            // 여기까지가 업로드
            
            // 업로드에서 에러가 발생하지 않았다면 다운로드를 하기 때문에 업로드에서 에러가 없다면 다운로드는 굳이 에러를 확인할 필요가 없다
            ref.downloadURL { url, error in             // 업로드한 이미지 url을 가져오기
                
                guard let imageUrl = url?.absoluteString else { return }
                completion(imageUrl)        // 완료핸들러를 실행
            }
        }
        
        
    }
}
