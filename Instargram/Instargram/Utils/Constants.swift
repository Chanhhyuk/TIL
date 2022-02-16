import Firebase

// 컬렉션에 액세스하려고 할 때마다 Firestore.firestore().collection("users")를 입력해야 하는데 이것을 편리하게 함
// 이것도 있어도 되고 없어도 됨
let COLLECTION_USERS = Firestore.firestore().collection("users")
