name: inverse
layout: true
class: center, middle, inverse
---
# <span style="font-size: 30%">【Swift編】ニフクラ mobile レベルアップセミナー</span><br>__クーポン配信アプリ<br>を作ろう！__</span>

@ニフティ株式会社

.footnote[
20160804作成(20160913更新)
]
---
layout: false
## 事前準備
ニフクラ mobileのアカウント登録がお済みでない方は、<br>
[ホームページ](https://mbaas.nifcloud.com/about.htm)右上にある「無料登録」ボタンをクリックして、<br>
アカウント登録を実施してください

![mBaaS検索](readme-image/mBaaS検索.png)

![mBaaS無料登録](readme-image/mBaaS無料登録.png)

---
## 今回のハンズオンセミナーについて
### セミナーの形式

.left-column[
  .center[
  150分でアプリ完成させます
  ![150分セミナー](readme-image/seminar/150分セミナー.png)
  ]
]
.right-column[
  .center[
  講義形式で説明と演習を繰り返して<br>アプリを作成します<br><br>
  ![講義形式セミナー2](readme-image/seminar/講義形式セミナー2.png)
  ]
]


---
## 今回のハンズオンセミナーについて
### 学ぶ内容

「mBaaS Shop List」アプリの作成を通して、アクティブユーザー率を上げる<br>
効率的なプッシュ通知の組み込み方を学びます

.center[
![セグメント配信](readme-image/seminar/セグメント配信.png)
]

---
## 今回のハンズオンセミナーについて
### 学ぶ内容

「mBaaS Shop List」アプリの作成を通して、アクティブユーザー率を上げる<br>
効率的なプッシュ通知の組み込み方を学びます<br>

.center[
![リッチプッシュ](readme-image/seminar/リッチプッシュ.png)
]

---
## 今回のハンズオンセミナーについて
### 学ぶ内容

「mBaaS Shop List」アプリの作成を通して、アクティブユーザー率を上げる<br>
効率的なプッシュ通知の組み込み方を学びます<br><br>

.center[
![ペイロード](readme-image/seminar/ペイロード.png)
]

---
## ニフティクラウド mobile backendとは
### サービス紹介

* スマホアプリで汎用的に実装される機能を、クラウドサービスとして提供しているサービスです
 * 通称「mBaaS」と呼びます

.center[
![mBaaS紹介](readme-image/mBaaS紹介.png)
]

---
## ニフティクラウド mobile backendとは
### iOS SDKの特徴

* SDKのインストールが必要です
 * 今回は実装済み
 * 参考：[クイックスタート](https://mbaas.nifcloud.com/doc/current/introduction/quickstart_ios.html)
* SDKの初期化処理が必要です
 * 後で処理を実装します

```swift
NCMB.initialize(applicationKey: "YOUR_NCMB_APPLICATIONKEY", clientKey: "YOUR_NCMB_CLIENTKEY")
```

---
## ニフティクラウド mobile backendとは
### iOS SDKの特徴

* サーバへリクエスト処理には、__同期処理__と__非同期処理__があります

```swift
// 例）保存の場合
/* 同期処理 */
save(nil)
/* 非同期処理 */
saveInBackgroundWithBlock(nil)
```

* 同期処理と非同期処理
 * 同期処理はその処理が完了するまで、次の処理が実行されません
 * 非同期処理はバックグラウンドで処理を実行し、次の処理を実行します

---
## ハンズオンの概要
### 作成するアプリについて

* クーポン配信アプリをイメージした「mBaaS Shop List」アプリの作成を通して、mBaaSの機能を理解していきます
* mBaaSの連携部分をコーディングし、アプリを完成させ、次の内容を実現していきます
 * 会員登録をするとお店情報を見ることができます
 * お店のお気に入り登録ができ、お気に入り登録をしたお店からプッシュ通知で届きます
 * 性別や都道府県限定のプッシュ通知ができます
 * お店からのプッシュ通知でクーポンを直接配信することができます
 * 決まった時間に通知を出すようにプッシュ通知を仕掛けることができます

---
## ハンズオンの概要
### 作成するアプリについて

.center[
![mBaaS_shop_List](readme-image/mBaaS_shop_List.png)
]

---
## ハンズオンの流れ

__<font color="#49a7e5" size="5">前半&nbsp;</font><font size="6">「mBaaS Shop List」アプリを作ろう！</font>__

.size_large[
1. ハンズオンの準備
1. 会員管理機能の作成
1. Shop情報の設定
1. お気に入り機能の作成
]

__<font color="#49a7e5" size="5">後半&nbsp;</font><font size="6">プッシュ通知を送ろう！</font>__
.size_large[
1. プッシュ通知の準備
1. プッシュ通知を送信：セグメント配信
1. プッシュ通知を送信：リッチプッシュ
1. プッシュ通知を送信：ペイロード
]

---
layout: true
class: center, middle, inverse_sub
---
#「mBaaS Shop List」<br>アプリを作ろう！

.size_large[
＜前半＞
]

---
layout: true
class: center, middle, inverse
---
# 1.ハンズオンの準備

---
layout: false
## ハンズオンの準備
### Xcodeプロジェクトをダウンロード

下記リンクをクリックして、ZIPファイルでダウンロードしてください▼<br>
.size_large[
　　　 __[SwiftAdvancePushApp](https://github.com/NIFCLOUD-mbaas/SwiftAdvancePushApp/archive/seminar_version.zip)__
]

* ディレクトリにある「__SwiftAdvancePushApp.xcworkspace__」をダブルクリックして、Xcodeを開いてください

---
## ハンズオンの準備
### プロジェクトにあらかじめ実施していること

* mBaaS iOS SDKのインストール
* mBaaSとの連携以外の処理のコーディング
 * アプリのデザインを`Main.storyboard`で作成し、処理は画面ごと`ViewController`にコーディングしています

---
## ハンズオンの準備
### mBaaSの準備

* [mBaaS](https://mbaas.nifcloud.com)にログインしてアプリを作成します

![mBaaSアプリ作成](readme-image/mBaaSアプリ作成.png)

---
## ハンズオンの準備
### APIキーの設定とSDKの初期化

* `AppDelegate.swift`を開きます
* `application(_ application: UIApplication, didFinishLaunchingWithOptions`メソッド内に処理を実装します[一部実装済み]

```swift
// 【mBaaS】 APIキーの設定とSDKの初期化
NCMB.initialize(applicationKey: "YOUR_NCMB_APPLICATIONKEY", clientKey: "YOUR_NCMB_CLIENTKEY")
```

* 初期化処理の「`YOUR_NCMB_APPLICATIONKEY`」，「`YOUR_NCMB_CLIENTKEY`」の部分をアプリ作成時に発行されたAPIキーに書き換えてください
 * APIキーは、mBaaSのダッシュボードから「アプリ設定」→「基本」にあります

---
layout: true
class: center, middle, inverse
---
# 2.会員管理機能の作成

---
layout: false
## 会員管理機能の作成
### mBaaSの設定

* 会員管理設定の「メールアドレス/パスワード認証」を許可します

![mBaaS会員設定](readme-image/mBaaS会員設定.png)

---
## 会員管理機能の作成

### 会員管理①：会員登録用メールを要求する[実装済み]

.center[
![SignUpViewController](readme-image/SignUpViewController.png)
]

---
## 会員管理機能の作成
### 会員管理①：会員登録用メールを要求する[実装済み]

* `SignUpViewController.swift`を開きます
* 会員登録処理は以下のように実装されます

```swift
// 【mBaaS：会員管理①】会員登録用メールを要求する
NCMBUser.requestAuthenticationMailInBackground(mailAddress: address.text!, callback: { result in
    switch result {
        case .success:
            // 会員登録用メールの要求失敗時の処理
        case let .failure(error):
            // 会員登録用メールの要求失敗時の処理
    }
})
```

---
## 会員管理機能の作成
### 会員管理①：会員登録用メールを要求する[実装済み]

* それぞれ処理を追記しています

```swift
// 会員登録用メールの要求失敗時の処理
print("エラーが発生しました：\(error!.code)")
self.statusLabel.text = "エラーが発生しました：\(error!.code)"
```

```swift
// 会員登録用メールの要求失敗時の処理
print("登録用メールを送信しました")
self.statusLabel.text = "登録用メールを送信しました"
// TextFieldを空にする
self.address.text = ""
```
---
## 会員管理機能の作成
### 会員管理②：メールアドレスとパスワードでログイン<br>[実装済み]

.center[
![LoginViewController](readme-image/LoginViewController.png)
]

---
## 会員管理機能の作成
### 会員管理②：メールアドレスとパスワードでログイン<br>[実装済み]

* `LoginViewController.swift`を開きます
* ログイン処理は以下のように実装されます

```swift
// 【mBaaS：会員管理②】メールアドレスとパスワードでログイン
 NCMBUser.logInInBackground(mailAddress: address.text!, password: password.text!, callback: { result in
    switch result {
        case .success:
            // ログイン成功時の処理
        case let .failure(error):
            // ログイン失敗時の処理
        }
})
```

---
## 会員管理機能の作成
### 会員管理②：メールアドレスとパスワードでログイン<br>[実装済み]

* それぞれ処理を追記しています

```swift
// ログイン失敗時の処理
print("ログインに失敗しました:\(error)")
self.statusLabel.text = "ログインに失敗しました:\(error)"
```

```swift
// ログイン成功時の処理
print("ログインに成功しました:\(user.objectId!)")
// AppDelegateにユーザー情報を保持
self.appDelegate.current_user = NCMBUser.currentUser
// statusLabelを空にする
self.statusLabel.text = ""
// 画面遷移
DispatchQueue.main.async {
    self.performSegue(withIdentifier: "login", sender: self)
}
```

---
## 会員管理機能の作成
### 動作確認(1)ログインをしてみましょう

* ここではシュミレーターでビルドし、動作確認を行います
* ログイン画面で「会員登録」をタップします
* 会員登録画面でメールアドレスを入力し「登録メールを送信」をタップします
 * ログを確認してください

.center[
![動作確認①ログイン](readme-image/動作確認①ログイン.png)
]
.footnote[
[エラーコード一覧](https://mbaas.nifcloud.com/doc/current/rest/common/error.html#REST%20API%E3%81%AE%E3%82%A8%E3%83%A9%E3%83%BC%E3%82%B3%E3%83%BC%E3%83%89%E3%81%AB%E3%81%A4%E3%81%84%E3%81%A6)
]

---
## 会員管理機能の作成
### 動作確認(1)ログインをしてみましょう

* 会員登録メールが届くので、パスワード設定します

.center[
![動作確認①パスワード登録](readme-image/動作確認①パスワード登録.png)
]

---
## 会員管理機能の作成
### 動作確認(1)ログインをしてみましょう

* 再びログイン画面に戻り「メールアドレス」と「パスワード」でログインします
 * ログを確認してください
* mBaaSのダッシュボードを確認してください
 * 会員管理にユーザーが登録されました

.center[
![動作確認①会員登録完了](readme-image/動作確認①会員登録完了.png)
]
.footnote[
[エラーコード一覧](https://mbaas.nifcloud.com/doc/current/rest/common/error.html#REST%20API%E3%81%AE%E3%82%A8%E3%83%A9%E3%83%BC%E3%82%B3%E3%83%BC%E3%83%89%E3%81%AB%E3%81%A4%E3%81%84%E3%81%A6)
]

---
## 会員管理機能の作成
### 会員管理③：ユーザー情報更新

.center[
![UserInfoRegistration](readme-image/UserInfoRegistration.png)
]

---
## 会員管理機能の作成
### 会員管理③：ユーザー情報更新


* `TopViewController.swift`を開きます
* 初回のみ表示されるユーザー情報登録画面に入力した情報をmBaaSのユーザー情報に追加する処理を実装します
* コメントの下にコードを追記していきます

```swift
// 【mBaaS：会員管理③】ユーザー情報更新

```

* かなり下の方にあります

---
## 会員管理機能の作成
### 会員管理③：ユーザー情報更新

```swift
// 【mBaaS：会員管理③】ユーザー情報更新
// ログイン中のユーザーを取得
let user:NCMBUser = NCMBUser.currentUser!
// ユーザー情報を設定
user["nickname"] = self.nickname.text
user["gender"] = self.GENDER_CONFIG[self.genderSegCon.selectedSegmentIndex]
user["prefecture"] = self.prefecture.text
user["favorite"] = [] as Array<String>
// user情報の更新
user.saveInBackground(callback: { result in
    switch result {
        case .success:
            // 更新成功時の処理
        case let .failure(error):
            // 更新失敗時の処理
    }
})
```

---
## 会員管理機能の作成
### 会員管理③：ユーザー情報更新

* それぞれ処理を追記します

```swift
// 更新失敗時の処理
print("ユーザー情報更新に失敗しました:\(error)")
self.viewLabel.text = "登録に失敗しました（更新）:\(error)"
```

```swift
// 更新成功時の処理
print("ユーザー情報更新に成功しました")
// AppDelegateに保持していたユーザー情報の更新
self.appDelegate.current_user = user as NCMBUser
// 【mBaaS：プッシュ通知③】installationにユーザー情報を紐づける
  /*****後でここに処理を記述します*****/
// 画面を閉じる
self.registerView.isHidden = true
// ニックネーム表示用ラベルの更新
let nickname = NCMBUser.currentUser!["nickname"]! as String
self.nicknameLabel.text = "\(nickname)さん、こんにちは！"
// 画面更新
self.checkShop()
```

---
layout: true
class: center, middle, inverse
---
# 3.Shop情報の設定

---
layout: false
## Shop情報の設定
### mBaaSにShop情報を用意する（データストア）

* ニフティクラウド mobile backendのダッシュボードから「データストア」を開き、「＋作成▼」ボタンをクリックし、「インポート」をクリックします
* クラス名に「__Shop__」と入力します
* ダウンロードしたサンプルプロジェクトにあるSettingフォルダ内の「__Shop.json__」を選択してアップロードします

.center[
![ShopClass](readme-image/ShopClass.png)
]

---
## Shop情報の設定
### mBaaSにShop情報を用意する（データストア）

こんな感じでインポートされます

.center[
![mBaaS_ShopData](readme-image/mBaaS_ShopData.PNG)
]

---
## Shop情報の設定
### mBaaSにShop情報を用意する（ファイルストア）

* ニフティクラウド mobile backendのダッシュボードから「ファイルストア」を開き、「↑アップロード」ボタンをクリックします
* ダウンロードしたサンプルプロジェクトにあるSettingフォルダ内の「icon」「Shop」「Sale」内にあるファイルをすべてをアップロードします

.center[
![imageUpload](readme-image/imageUpload.png)
]

---
## Shop情報の設定
### mBaaSにShop情報を用意する（ファイルストア）

* こんな感じでアップロードされます

.center[
![UploadImage](readme-image/UploadImage.png)
]

---
## Shop情報の設定
### データストア：「Shop」クラスのデータを取得

* `TopViewController.swift`を開きます
* インポートしたShopクラスのデータを取得する処理を実装します

```swift
// 【mBaaS：データストア】「Shop」クラスのデータを取得
// 「Shop」クラスのクエリを作成
query =  NCMBQuery.getQuery(className: "Shop")
// データストアを検索
query.findInBackground(callback: { result in
    switch result {
    case let .success(array):
       // 検索成功時の処理
    case let .failure(error):
        // 検索失敗時の処理
    }
})
```

---
## Shop情報の設定
### データストア：「Shop」クラスのデータを取得

* それぞれ処理を追記します

```swift
// 検索失敗時の処理
print("検索に失敗しました:\(error)")
```

```swift
// 検索成功時の処理
print("検索に成功しました")
// AppDelegateに「Shop」クラスの情報を保持
self.appDelegate.shopList = array
// テーブルの更新
DispatchQueue.main.async {
    self.shopTableView.reloadData()
}
```

---
## Shop情報の設定
### ファイルストア①：icon画像の取得

.center[
![icon](readme-image/icon.png)
]

---
## Shop情報の設定
### ファイルストア①：icon画像の取得

* `CustomCell.swift`を開きます
 * `CustomCell.swift`はテーブルのセルを作成するファイルです
* トップ画面に各ショップのアイコンをmBaaSから取得して表示する処理を実装します

```swift
// 【mBaaS：ファイルストア①】icon画像の取得
// 取得した「Shop」クラスデータからicon名を取得
let imageName = object.objectForKey("icon_image") as! String
// ファイル名を設定
let imageFile = NCMBFile.fileWithName(imageName, data: nil)
// ファイルを検索
imageFile.getDataInBackgroundWithBlock { (data: NSData!, error: NSError!) -> Void in
    if error != nil {
        // ファイル取得失敗時の処理

    } else {
        // ファイル取得成功時の処理

    }
}
let imageName = object._fields["icon_image"] as! String
let file : NCMBFile = NCMBFile(fileName: imageName)
file.fetchInBackground(callback: { result in
    switch result {
    case let .success(data):
        // ファイル取得成功時の処理
    case let .failure(error):
        // ファイル取得失敗時の処理
    }
})
```

---
## Shop情報の設定
### ファイルストア①：icon画像の取得

* それぞれ処理を追記します

```swift
// ファイル取得失敗時の処理
print("icon画像の取得に失敗しました:\(error)")
```

```swift
// ファイル取得成功時の処理
print("icon画像の取得に成功しました")
// icon画像を設定
self.iconImageView_top.image = UIImage.init(data: data!)
```
---
## Shop情報の設定
### ファイルストア②：Shop画像の取得

.center[
![Shop](readme-image/Shop.png)
]

---
## Shop情報の設定
### ファイルストア②：Shop画像の取得[実装済み]

* `ShopViewController.swift`を開きます
* Shop画面に各ショップの画像をmBaaSから取得して表示する処理も同様に実装できます

```swift
// 【mBaaS：ファイルストア②】Shop画像の取得
// 取得した「Shop」クラスデータからshop画面用の画像名を取得
let shop = appDelegate.shopList[shopIndex]
let imageName = shop._fields["shop_image"] as! String
// ファイル名を設定
let imageFile = NCMBFile(fileName:imageName)
// ファイルを検索
imageFile.fetchInBackground(callback: { result in
    switch result {
    case let .success(data):
        // ファイル取得成功時の処理
    case let .failure(error):
        // ファイル取得失敗時の処理
    }
})
```

---
## Shop情報の設定
### 動作確認(2)会員情報登録とShop情報表示

* 再びシュミレーターでビルドし、動作確認を行います
* ログイン後初回のみ、ユーザー情報登録画面が表示されます
* 入力し「登録」をタップします
 * このとき、会員情報が更新されますので、mBaaSのダッシュボードを確認してみましょう
 * ログを確認してください

.center[
![動作確認②ユーザー情報追加](readme-image/動作確認②ユーザー情報追加.png)
]
.footnote[
[エラーコード一覧](https://mbaas.nifcloud.com/doc/current/rest/common/error.html#REST%20API%E3%81%AE%E3%82%A8%E3%83%A9%E3%83%BC%E3%82%B3%E3%83%BC%E3%83%89%E3%81%AB%E3%81%A4%E3%81%84%E3%81%A6)
]

---
## Shop情報の設定
### 動作確認(2)会員情報登録とShop情報表示

* トップ画面に「icon画像」「Shop名」「カテゴリ」が表示されます
* Shopを１つ選んでタップします
 * mBaaSに登録されているimageにアクセスし、Shopページ（画像）が表示されます
* 会員ページをタップします
 * ユーザー情報が表示されます

.center[
![動作確認②](readme-image/動作確認②.png)
]
.footnote[
[エラーコード一覧](https://mbaas.nifcloud.com/doc/current/rest/common/error.html#REST%20API%E3%81%AE%E3%82%A8%E3%83%A9%E3%83%BC%E3%82%B3%E3%83%BC%E3%83%89%E3%81%AB%E3%81%A4%E3%81%84%E3%81%A6)
]

---
layout: true
class: center, middle, inverse
---
# 4.お気に入り機能の作成

---
layout: false
## お気に入り機能の作成
### お気に入り機能について

* お気に入り機能は好きなShopをお気に入りとして保存できる機能です
 * 「お気に入り」画面ではSwitchと「登録」ボタンで設定します
 * 「Shop」画面では右上のハートマークをタップすることでShop単位で設定できます(♥…ON,♡…OFF)

.center[
![favorite](readme-image/favorite.png)
]

---
## お気に入り機能の作成
### 会員管理④：ユーザー情報の更新[実装済み]

* `FavoriteViewController.swift`を開きます
* お気に入り画面からfavoriteデータの更新処理はユーザー情報の登録と同様にして実装できます

```swift
// 【mBaaS：会員管理④】ユーザー情報の更新
// ログイン中のユーザーを取得
let user = NCMBUser.currentUser
// 更新された値を設定
user!["favorite"] = appDelegate.favoriteObjectIdTemporaryArray
// ユーザー情報を更新
user!.saveInBackground(callback: { result in
    switch result {
        case .success:
            // 更新に成功した場合の処理
        case let .failure(error):
            // 更新に失敗した場合の処理
    }
})
```

---
## お気に入り機能の作成

### 会員管理⑤：ユーザー情報の更新[実装済み]

* `ShopViewController.swift`を開きます
* Shop画面からもfavoriteデータの更新処理はユーザー情報の登録と同様にして実装できます

```swift
// 【mBaaS：会員管理⑤】ユーザー情報の更新
// ログイン中のユーザーを取得
let user = NCMBUser.currentUser!
// 更新された値を設定
user["favorite"] = favoriteObjectIdArray
// ユーザー情報を更新
user.saveInBackground(callback: { result in
    switch result {
    case .success:
        // 更新に成功した場合の処理
    case let .failure(error):
        // 更新に失敗した場合の処理
    }
})
```

---
## お気に入り機能の作成
### 動作確認(3)お気に入り情報登録・更新

* 再びシュミレーターでビルドし、動作確認を行います
* ログイン後トップ画面下の「お気に入り」をタップします
* お気に入り画面からお気に入り登録をしてみましょう
* 各Shop画面からも同様に登録してみましょう
 * ログを確認してください

.center[
![動作確認③](readme-image/動作確認③.png)
]

.footnote[
[エラーコード一覧](https://mbaas.nifcloud.com/doc/current/rest/common/error.html#REST%20API%E3%81%AE%E3%82%A8%E3%83%A9%E3%83%BC%E3%82%B3%E3%83%BC%E3%83%89%E3%81%AB%E3%81%A4%E3%81%84%E3%81%A6)
]

---
layout: true
class: center, middle, inverse_sub
---
# プッシュ通知を送ろう！

.size_large[
＜後半＞
]

---
layout: true
class: center, middle, inverse
---
# 1.プッシュ通知の準備

---
layout: false
## プッシュ通知の準備
### このあとのデバッグについて

* 以下の用意が必要です
 * デバッグ用の実機
 * プッシュ通知用証明書(p12形式)
* 証明書の取得がまだの場合は下記をご参照ください
 * [【サンプル】アプリにプッシュ通知を組み込もう！](https://github.com/NIFTYCloud-mbaas/SwiftPushApp)

---
## プッシュ通知の準備
### mBaaSの設定

* プッシュ通知の許可とAPNsの証明書(p12形式)のアップロードを行います

.center[
![mBaaSプッシュ通知設定](readme-image/mBaaSプッシュ通知設定.png)
]

---
## プッシュ通知の準備
### プッシュ通知①：デバイストークンの取得

* `AppDelegate.swift`を開きます
* `application(_:didFinishLaunchingWithOptions)`メソッド内のSDKの初期化を実装した部分の直ぐ下に処理を実装します

```swift
// 【mBaaS：プッシュ通知①】デバイストークンの取得
// デバイストークンの要求
UNUserNotificationCenter.current()
    .requestAuthorization(options: [.alert, .sound, .badge]) {
        granted, error in
        print("Permission granted: \(granted)")
        guard granted else { return }
        self.getNotificationSettings()
}

// MARK: アプリが起動されるときに実行される処理を追記する場所
if let notification = launchOptions?[.remoteNotification] as? [String: AnyObject] {
    NCMBPush.handleRichPush(userInfo: notification)
}
```

---
## プッシュ通知の準備
### プッシュ通知②：デバイストークンの取得後に呼び出されるメソッド

* 続けて`AppDelegate.swift`を編集します
* `application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken`メソッド下(外)に次のメソッドを実装します

```swift
// 【mBaaS：プッシュ通知②】デバイストークンの取得後に呼び出されるメソッド
func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
    let tokenParts = deviceToken.map { data in String(format: "%02.2hhx", data) }
    let token = tokenParts.joined()
    print("Device Token: \(token)")
    
    let installation = NCMBInstallation()
    installation.setDeviceTokenFromData(data: deviceToken)
    installation.saveInBackground { (error) in
        
    }
}
```

---
## プッシュ通知の準備
### プッシュ通知②：デバイストークンの取得後に呼び出されるメソッド

* それぞれ処理を追記します

```swift
// 端末情報の登録に失敗した時の処理
print("デバイストークン取得に失敗しました:\(error)")
```

```swift
// 端末情報の登録に成功した時の処理
print("デバイストークン取得に成功しました")
```

---
layout: true
class: center, middle, inverse
---
# 2.プッシュ通知を送信<br>セグメント配信

---
layout: false
## プッシュ通知を送信：セグメント配信
### プッシュ通知③：installationにユーザー情報を紐づける

* `TopViewController.swift`を開きます
* 「【mBaaS：会員管理③】ユーザー情報更新」の更新成功時の処理内にセグメント配信のために必要なユーザー情報をinstallationに紐付けるための処理を実装します

```swift
// 【mBaaS：プッシュ通知③】installationにユーザー情報を紐づける
  /*****後でここに処理を記述します*****/

// 画面を閉じる
self.registerView.hidden = true
// ニックネーム表示用ラベルの更新
let nickname = NCMBUser.currentUser!["nickname"]! as String
self.nicknameLabel.text = "\(nickname)さん、こんにちは！"
// 画面更新
self.checkShop()
```
* 上記コメントや処理を一度削除します

```swift
// 【mBaaS：プッシュ通知③】installationにユーザー情報を紐づける

```

---
## プッシュ通知を送信：セグメント配信
### プッシュ通知③：installationにユーザー情報を紐づける

* 次のように追記します

```swift
// 【mBaaS：プッシュ通知③】installationにユーザー情報を紐づける
// 使用中端末のinstallation取得
let installation = NCMBInstallation.currentInstallation
// ユーザー情報を設定
installation["nickname"] = self.nickname.text
installation["gender"] = self.GENDER_CONFIG[self.genderSegCon.selectedSegmentIndex]
installation["prefecture"] = self.prefecture.text
installation["favorite"] = [] as Array<String>
// installation情報の更新
installation.saveInBackground(callback: { result in
    switch result {
    case .success:
        // installation更新成功時の処理
    case let .failure(error):
        // installation更新失敗時の処理
    }
})
```

---
## プッシュ通知を送信：セグメント配信
### プッシュ通知③：installationにユーザー情報を紐づける

* それぞれ処理を追記します

```swift
// installation更新失敗時の処理
print("installation更新(ユーザー登録)に失敗しました:\(error)")
```

```swift
// installation更新成功時の処理
print("installation更新(ユーザー登録)に成功しました")
// 画面を閉じる
self.registerView.hidden = true
// ニックネーム表示用ラベルの更新
let nickname = NCMBUser.currentUser!["nickname"]! as String
self.nicknameLabel.text = "\(nickname)さん、こんにちは！"
// 画面更新
self.checkShop()
```

---
## プッシュ通知を送信：セグメント配信
### プッシュ通知④：installationにユーザー情報を紐づける<br>[実装済み]

* `FavoriteViewController.swift`開きます
* 同様に、お気に入り画面でお気に入り情報が更新されるたびに、installation情報を書き換えられます

```swift
// 【mBaaS：プッシュ通知④】installationにユーザー情報を紐づける
let installation = NCMBInstallation.currentInstallation
// お気に入り情報を設定
installation["favorite"] = self.appDelegate.favoriteObjectIdTemporaryArray
// installation情報の更新
installation.saveInBackground(callback: { result in
    switch result {
    case .success:
        // installation更新成功時の処理
    case let .failure(error):
        // installation更新失敗時の処理
    }
})
```

---
## プッシュ通知を送信：セグメント配信
### プッシュ通知⑤：installationにユーザー情報を紐づける<br>[実装済み]

* `ShopViewController.swift`開きます
* 同様に、Shop画面でもお気に入り情報が更新されるたびに、installation情報を書き換えるます

```swift
// 【mBaaS：プッシュ通知⑤】installationにユーザー情報を紐づける
let installation: NCMBInstallation? = NCMBInstallation.currentInstallation
if installation != nil {
    // お気に入り情報を設定
    installation!["favorite"] = favoriteObjectIdArray
    // installation情報の更新
    installation!.saveInBackground(callback: { result in
        switch result {
        case .success:
            // installation更新成功時の処理
        case let .failure(error):
            // installation更新失敗時の処理
        }
    })
}
```
---
## プッシュ通知を送信：セグメント配信
### 動作確認の準備

* もう一度会員情報登録画面を表示するため、mBaaSの会員管理画面で「クラスの編集」をクリックします
* 「nickname」にチェックを入れて上の「削除」ボタンで削除します

.center[
![動作確認④セグメント0](readme-image/動作確認④セグメント0.png)
]

---
## プッシュ通知を送信：セグメント配信
### 動作確認の準備

* 実機でアプリをビルドします
* プッシュ通知の許可をして、ログを確認します

```text
端末側でプッシュ通知が許可されました
デバイストークン取得に成功しました
```

* デバイストークンの取得に成功したら、mBaaSダッシュボードで確認します

.center[
![動作確認④デバイストークン](readme-image/動作確認④デバイストークン.png)
]

.footnote[
[エラーコード一覧](https://mbaas.nifcloud.com/doc/current/rest/common/error.html#REST%20API%E3%81%AE%E3%82%A8%E3%83%A9%E3%83%BC%E3%82%B3%E3%83%BC%E3%83%89%E3%81%AB%E3%81%A4%E3%81%84%E3%81%A6)
]

---
## プッシュ通知を送信：セグメント配信
### 動作確認の準備

* ログインをし、再びユーザー登録をします
 * このとき、installationが更新されますのでダッシュボードを確認します
 * ログを確認してください

.center[
![動作確認④installation追加](readme-image/動作確認④installation追加.png)
]
.footnote[
[エラーコード一覧](https://mbaas.nifcloud.com/doc/current/rest/common/error.html#REST%20API%E3%81%AE%E3%82%A8%E3%83%A9%E3%83%BC%E3%82%B3%E3%83%BC%E3%83%89%E3%81%AB%E3%81%A4%E3%81%84%E3%81%A6)
]

---
## プッシュ通知を送信：セグメント配信
### 動作確認(4)セグメント配信

__shopB__をお気に入り登録しているユーザーに絞り込んでプッシュ通知を配信してみましょう！

* あらかじめshopBをお気に入りに設定しておきます(アプリ側)
* mBaaSのダッシュボードからShopクラスのデータを開き、shopBの「objectId」をコピーします

.center[
![動作確認④セグメント2](readme-image/動作確認④セグメント2.png)
]

---
## プッシュ通知を送信：セグメント配信
### 動作確認(4)セグメント配信

* プッシュ通知を作成します
* メッセージを入力します
 * 例：ShopBセール開催中！
* 「iOS端末に配信する」にチェックを入れます
* 「配信端末」を設定します

.center[
![動作確認④セグメント1](readme-image/動作確認④セグメント1.png)
]

---
## プッシュ通知を送信：セグメント配信
### 動作確認(4)セグメント配信

* 「installationクラスからの絞込み」を選択します
* 絞り込み設定をします
 * ここでコピーしたShopBのobjectIdを貼り付けます

.center[
![動作確認④セグメント3](readme-image/動作確認④セグメント3.png)
]

---
## プッシュ通知を送信：セグメント配信
### 動作確認(4)セグメント配信

* 「１端末に向けて送信されます」と表示されればOKです
* 「プッシュ通知を作成する」をクリックします
* 少し待つと配信されます→端末を確認！

.center[
![動作確認④セグメント4](readme-image/動作確認④セグメント4.png)
]

---
## プッシュ通知を送信：セグメント配信
### 動作確認(4)セグメント配信[おまけ]

.size_large[
いろいろなパターンで送ってみましょう！
* 別のショップを絞り込み
* 性別で絞込み
* ShopAをお気に入り登録かつ女性で絞込み
* ShopDをお気に入り登録かつ東京都で絞込み
* and more...
]

---
layout: true
class: center, middle, inverse
---
# 2.プッシュ通知を送信<br>リッチプッシュ

---
layout: false

## プッシュ通知を送信：リッチプッシュ
### リッチプッシュについて

* プッシュ通知登録時にURLを指定することで、開封時にWebビューを表示できる機能です
* プッシュ通知開封でアプリが起動するときに表示されます
 * アプリ起動中には表示されませんので動作確認にはアプリを閉じておく必要があります（仕様）

---
## プッシュ通知を送信：リッチプッシュ
### リッチプッシュについて

* 今回はShopのセール画像を「公開ファイル」機能を利用して配信します

.center[
![sale_image](readme-image/sale_image.png)
]


---
## プッシュ通知を送信：リッチプッシュ
### 公開ファイルとは

* 「公開ファイル」機能とは、ファイルストアに保存した画像をリンクでアクセスできるようにする機能です
* ファイルストアに登録した画像を「公開ファイル」として公開することが可能です

---
## プッシュ通知を送信：リッチプッシュ
### 公開ファイル設定

* mBaaSのダッシュボードで、公開ファイル設定「HTTPでの取得」を有効にします

.center[
![mBaaS公開ファイル設定](readme-image/mBaaS公開ファイル設定.png)
]

---
## プッシュ通知を送信：リッチプッシュ
### 公開ファイルURL確認方法

* ファイルストアで確認できます
* 今回は「ShopD_sale.png」の公開ファイルURLを使用してみます
 * URLをコピーします

.center[
![公開ファイルURL](readme-image/公開ファイルURL.png)
]

---
## プッシュ通知を送信：リッチプッシュ
### 公開ファイルURL確認方法

* ブラウザでリンクをたたいて表示されることを確認してください

.center[
![公開ファイル確認](readme-image/公開ファイル確認.png)
]

---
## プッシュ通知を送信：リッチプッシュ
### プッシュ通知⑥：リッチプッシュ通知を表示させる処理

* `AppDelegate.swift`を開きます
* `application(_ application: UIApplication, didFinishLaunchingWithOptions`メソッド内、`【プッシュ通知①】デバイストークンの取得`の下に処理を実装します

```swift
if let notification = launchOptions?[.remoteNotification] as? [String: AnyObject] {
    // 【mBaaS：プッシュ通知⑥】リッチプッシュ通知を表示させる処理
      /* ここに書きます */

    // 【mBaaS：プッシュ通知⑧】アプリが起動されたときにプッシュ通知からデータを取得する
}
```

---
## プッシュ通知を送信：リッチプッシュ
### プッシュ通知⑥：リッチプッシュ通知を表示させる処理

* 次のように追記します

```swift
// 【mBaaS：プッシュ通知⑥】リッチプッシュ通知を表示させる処理
    NCMBPush.handleRichPush(userInfo: notification)
```

---
## プッシュ通知を送信：リッチプッシュ
### 動作確認(5)リッチプッシュ

* 実機でアプリをビルドします
* 起動し、下記ログを確認したらアプリを完全に閉じます
 ```text
 端末側でプッシュ通知が許可されました
 デバイストークン取得に成功しました
 ```

---
## プッシュ通知を送信：リッチプッシュ
### 動作確認(5)リッチプッシュ

* プッシュ通知を作成します
* メッセージを入力します
* URL欄にコピーした公開ファイルURLを貼り付けます
* そのまま送信してみましょう

.center[
![動作確認⑤リッチプッシュ](readme-image/動作確認⑤リッチプッシュ.png)
]

---
## プッシュ通知を送信：リッチプッシュ
### 動作確認(5)リッチプッシュ

* しばらくするとプッシュ通知が届きます
* プッシュ通知を開くとWebView画面が現れ、公開ファイルが表示されます

.center[
![動作確認⑤リッチプッシュ2](readme-image/動作確認⑤リッチプッシュ2.png)
]

---
layout: true
class: center, middle, inverse
---
# 2.プッシュ通知を送信<br>ペイロード

---
layout: false
## プッシュ通知を送信：ペイロード
### ペイロードについて

* プッシュ通知にはJSON形式で任意のデータを含めることができ、通知を受信した時に、そのデータを受け取って処理を行うことができる機能です
* データ取得の条件
 * アプリの起動中にプッシュ通知を受信してデータを取得
 * プッシュ通知受信後、アプリを起動時にデータを取得
* 今回は、配信時間とメッセージのデータを設定し、時限式でローカルプッシュを表示させる内容を実装します
 * プッシュ通知に設定するJSON形式のデータの例
 ```text
 {"deliveryTime":"2016-09-13 17:00:00", "message":"タイムセールスタート！"}
 ```

---
## プッシュ通知を送信：ペイロード
### プッシュ通知⑦：アプリが起動中にプッシュ通知からデータを取得する

* `AppDelegate.swift`を開きます
* `application(_ application: UIApplication, didReceiveRemoteNotification`メソッド外に次のメソッドを実装します

```swift
// 【mBaaS：プッシュ通知⑦】アプリが起動中にプッシュ通知からデータを取得する
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable: Any], fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        // プッシュ通知情報の取得
        let deliveryTime = userInfo["deliveryTime"] as! String
        let message = userInfo["message"] as! String
        // 値を取得した後の処理
        if !deliveryTime.isEmpty && !message.isEmpty  {
            print("ペイロードを取得しました：deliveryTime[\(deliveryTime)],message[\(message)]")
            // ローカルプッシュ配信
            localNotificationDeliver(deliveryTime: deliveryTime, message: message)
        }
        
        if let notiData = userInfo as? [String : AnyObject] {
            NCMBPush.handleRichPush(userInfo: notiData)
        }
    }
```

---
## プッシュ通知を送信：ペイロード
### プッシュ通知⑧：アプリが起動されたときにプッシュ通知からデータを取得する

* `AppDelegate.swift`を開きます
* `application(_ application: UIApplication, didReceiveRemoteNotification`メソッド内、`【mBaaS：プッシュ通知⑥】リッチプッシュ通知を表示させる処理`の下に処理を実装します

```swift
// 【mBaaS：プッシュ通知⑧】アプリが起動されたときにプッシュ通知からデータを取得する
// プッシュ通知情報の取得
let deliveryTime = userInfo["deliveryTime"] as! String
let message = userInfo["message"] as! String
// 値を取得した後の処理
if !deliveryTime.isEmpty && !message.isEmpty  {
    print("ペイロードを取得しました：deliveryTime[\(deliveryTime)],message[\(message)]")
    // ローカルプッシュ配信
    localNotificationDeliver(deliveryTime: deliveryTime, message: message)
}
```

---
## プッシュ通知を送信：ペイロード
### 参考：ローカルプッシュ[実装済み]

```swift
// LocalNotification配信
func localNotificationDeliver (deliveryTime: String, message: String) {
    // 配信時間(String→NSDate)を設定
    let formatter = DateFormatter()
    formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
    let deliveryTime = formatter.date(from: deliveryTime)
    // ローカルプッシュを作成
    LocalNotificationManager.scheduleLocalNotificationAtData(deliveryTime: deliveryTime! as NSDate, alertBody: message, userInfo: nil)
}
```

---
## プッシュ通知を送信：ペイロード
### 動作確認(6)ペイロード（アプリ起動時）

* 実機でアプリをビルドします
* 起動し、下記ログを確認します

```
端末側でプッシュ通知が許可されました
デバイストークン取得に成功しました
```

* そのままアプリを起動した状態にします

---
## プッシュ通知を送信：ペイロード
### 動作確認(6)ペイロード（アプリ起動時）

* プッシュ通知に設定するJSON形式のデータを作成します
 * JSONデータに設定する時間は、今から__５分以上未来の時間__に変更してください
 * JSONデータに設定するメッセージは、自由に変更してください
 ```text
 {"deliveryTime":"2016-09-13 17:00:00", "message":"タイムセールスタート！"}
 ```
 * 作成したらコピーをしておいてください

---
## プッシュ通知を送信：ペイロード
### 動作確認(6)ペイロード（アプリ起動時）

* プッシュ通知を作成します
 * メッセージを入力が無い場合、サイレントプッシュとして送られます
 * 「JSON」に作成したJSONデータを貼り付けます

.center[
![動作確認⑥ペイロード1](readme-image/動作確認⑥ペイロード1.png)
]

---
## プッシュ通知を送信：ペイロード
### 動作確認(6)ペイロード（アプリ起動時）

* プッシュ通知を送信します
* プッシュ通知を受信（サイレント）すると次のログが表示されます

```text
ペイロードを取得しました：deliveryTime[2016-09-13 17:00:00],message[タイムセールスタート！]
```

* 指定時間にプッシュ通知が表示されることを確認してください

.footnote[
[エラーコード一覧](https://mbaas.nifcloud.com/doc/current/rest/common/error.html#REST%20API%E3%81%AE%E3%82%A8%E3%83%A9%E3%83%BC%E3%82%B3%E3%83%BC%E3%83%89%E3%81%AB%E3%81%A4%E3%81%84%E3%81%A6)
]
---
## プッシュ通知を送信：ペイロード
### 動作確認(6)ペイロード（非起動時）

* アプリを完全に閉じます
* 再びプッシュ通知を作成します

.center[
![動作確認⑥ペイロード2](readme-image/動作確認⑥ペイロード2.png)
]

---
## プッシュ通知を送信：ペイロード
### 動作確認(6)ペイロード（非起動時）

* アプリが起動していないので、サイレントプッシュでは気付いてもらえません
* アプリを起動してもらう内容でプッシュ通知を作成します
 * メッセージ　例）`明日PM5時よりタイムセールを行います！`
* JSON形式のデータを貼り付けます
 * JSONデータ作成　例）翌日のPM5時を設定
 ```text
 {"deliveryTime":"2016-09-13 17:00:00", "message":"タイムセールスタート！"}
 ```
 * 時間は今から５分以上未来の時間に変更してください

---
## プッシュ通知を送信：ペイロード
### 動作確認(6)ペイロード（非起動時）

* プッシュ通知を受信したら、プッシュ通知からアプリを起動します
* 起動時にデータを取得します
 * １度起動してあればアプリは閉じてもOKです
* 指定時間にプッシュ通知が表示されることを確認してください

---
layout: true
class: center, middle, inverse_sub
---
# まとめ

---
layout: false
## まとめ
### 学んだこと

* mBaaSの各機能を使用してアプリ作成方法を学んだ！
 * 会員管理機能
 * データストア
 * ファイルストア
 * プッシュ通知
* プッシュ通知の活用方法がわかった！
 * セグメント配信
 * リッチプッシュ
 * ペイロード

---
## 参考

* 開催中の[セミナー](https://ncmb.doorkeeper.jp/)のご案内
 * 随時新しいセミナーを実施していきますのでぜひチェックしてください！
* ハンズオン内容が実装された完全版プロジェクト
 * __[SwiftAdvancePushApp【完成版】](https://github.com/NIFCLOUD-mbaas/SwiftAdvancePushApp/archive/master.zip)__
* コードは[GitHub](https://github.com/NIFCLOUD-mbaas/SwiftAdvancePushApp)に公開しています
 * __master__：完成版
 * __seminar_version__：セミナー版
