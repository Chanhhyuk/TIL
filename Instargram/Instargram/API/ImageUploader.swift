// 왜 firebase에 업로드할때 이미지업로드를 따로 만들어서 할까?
import FirebaseStorage      // 파일 저장소

// AuthService에서 사용
struct ImageUploader {
    // #escaping(String)을 한 이유는 이미지를 업로드할 때 해당 이미지의 URL을 다운로드 할거기 떄문?
    // 이 함수를 호출할 때 연결된 이미지 URL을 다시 가져와야 한다
    // 이미지를 firebase에 전송하고 에러 없이 완료되면 완료 핸들러를 실행하고 다운로드를 다시 제공한다?
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
