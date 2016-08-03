name: inverse
layout: true
class: center, middle, inverse
---
# <span style="font-size: 30%">【Swift編】ニフティクラウドmobile backend レベルアップセミナー</span><br>__クーポン配信アプリ<br>を作ろう！__</span>

@natsumo

---
layout: false
## 事前準備
ニフティクラウドmobile backendのアカウント登録がお済みでない方は、<br>
[ホームページ](http://mb.cloud.nifty.com/about.htm)右上にある「無料登録」ボタンをクリックして、<br>
アカウント登録を実施してください

![mBaaS検索.png](/readme-image/mBaaS検索.png)

---

## 事前準備

![mBaaS無料登録.png](https://qiita-image-store.s3.amazonaws.com/0/112032/4bd94adc-e914-b908-8530-3ae192dfc7a7.png)

---

## ニフティクラウド mobile backendとは
__サービス紹介__

* スマホアプリで汎用的に実装される機能を、クラウドサービスとして提供しているサービスです
 * 通称「mBaaS」と呼びます

![mBaaS紹介.png](https://qiita-image-store.s3.amazonaws.com/0/112032/6ee565c4-fc81-111e-4178-d9e4fdb5c7af.png)


---

## ニフティクラウド mobile backendとは
__iOS SDKの特徴__

* SDKのインストールが必要です
 * 今回は実装済み
 * 参考：[クイックスタート](http://mb.cloud.nifty.com/doc/current/introduction/quickstart_ios.html)

---

## ニフティクラウド mobile backendとは
__iOS SDKの特徴__

* SDKの初期化処理が必要です
 * 後で処理を実装します

```swift
NCMB.setApplicationKey("YOUR_NCMB_APPLICATIONKEY", clientKey: "YOUR_NCMB_CLIENTKEY")
```

---

## ニフティクラウド mobile backendとは
__iOS SDKの特徴__

* サーバへリクエスト処理には、__同期処理__と__非同期処理__があります

```swift
// 例）保存の場合
/* 同期処理 */
save(nil)
/* 非同期処理 */
saveInBackgroundWithBlock(nil)
```

---

## ニフティクラウド mobile backendとは
__iOS SDKの特徴__

* 同期処理と非同期処理
 * 同期処理はその処理が完了するまで、次の処理が実行されません
 * 非同期処理はバックグラウンドで処理を実行し、次の処理を実行します

---

## ハンズオンセミナーの概要
__「mBaaS Shop List」アプリ__

* クーポン配信アプリをイメージした「mBaaS Shop List」アプリの作成を通して、mBaaSの機能を理解していきます
* mBaaSの連携部分をコーディングし、アプリを完成させ、次の内容を実現していきます

---

## ハンズオンセミナーの概要
__「mBaaS Shop List」アプリ__

 * 会員登録をするとお店情報を見ることができます
 * お店のお気に入り登録ができ、お気に入り登録をしたお店からプッシュ通知で届きます
 * 性別や都道府県限定のプッシュ通知ができます
 * お店からのプッシュ通知でクーポンを直接配信することができます

---

## ハンズオンセミナーの概要
__「mBaaS Shop List」アプリ__

![mBaaS_shop_List.png](https://qiita-image-store.s3.amazonaws.com/0/112032/2745e25a-b1bb-ae10-9d6d-87e87ffadec0.png)

---

## ハンズオンセミナーの具体的なの流れ
1. ハンズオンの準備
1. 会員管理機能の作成
1. Shop情報の設定
1. お気に入り登録機能の作成
1. プッシュ通知を送信①セグメント配信
1. プッシュ通知を送信②リッチプッシュ
1. プッシュ通知を送信③ペイロード

---

## ハンズオンの準備
__Xcodeプロジェクトをダウンロード__

* 下記リンクをクリックして、ZIPファイルでダウンロードしてください

　　　 __[SwiftAdvancePushApp](https://github.com/natsumo/SwiftAdvancePushApp/archive/seminar_version.zip)__

---

## ハンズオンの準備
__Xcodeプロジェクトをダウンロード__

* ディレクトリにある「__SwiftAdvancePushApp.xcworkspace__」をダブルクリックして、Xcodeを開いてください

---

## ハンズオンの準備
__プロジェクトにあらかじめ実施していること__

* mBaaS iOS SDKのインストール
* mBaaSとの連携以外の処理のコーディング
 * アプリのデザインを`Main.storyboard`で作成し、処理は画面ごと`ViewController`にコーディングしています

---

## ハンズオンの準備
__mBaaSの準備__

* [mBaaS](http://mb.cloud.nifty.com)にログインしてアプリを作成します
![mBaaSアプリ作成.png](https://qiita-image-store.s3.amazonaws.com/0/112032/b23d2eb1-c06f-fdee-ebbd-1c8c3ce95974.png)

---

## ハンズオンの準備
__APIキーの設定とSDKの初期化__

* `AppDelegate.swift`を開きます
* `applications(_:didFinishLaunchingWithOptions)`メソッド内に処理を実装します

---

## ハンズオンの準備
__APIキーの設定とSDKの初期化__

```swift:AppDelegate.Swift
// 【mBaaS】 APIキーの設定とSDKの初期化
NCMB.setApplicationKey("YOUR_NCMB_APPLICATIONKEY", clientKey: "YOUR_NCMB_CLIENTKEY")
```

---

## ハンズオンの準備
__APIキーの設定とSDKの初期化__

* 「`YOUR_NCMB_APPLICATIONKEY`」，「`YOUR_NCMB_CLIENTKEY`」の部分にはアプリ作成時に発行されたAPIキーに書き換えてください
 * APIキーは、mBaaSのダッシュボードから「アプリ設定」→「基本」にあります

---

## 会員管理機能の作成

__mBaaSの設定__

* 会員管理設定の「メールアドレス/パスワード認証」を許可します

---

## 会員管理機能の作成

__mBaaSの設定__

![mBaaS会員設定.png](https://qiita-image-store.s3.amazonaws.com/0/112032/c2466a52-6257-2222-102b-39ed78e4c770.png)


---
## 会員管理機能の作成

__会員管理①：会員登録用メールを要求する__

![SignUpViewController.png](https://qiita-image-store.s3.amazonaws.com/0/112032/46fd82eb-d19e-a329-c42f-64db9b5e706c.png)

---
## 会員管理機能の作成
__会員管理①：会員登録用メールを要求する__

* `SignUpViewController.swift`を開きます
* 会員登録処理を実装します

---
## 会員管理機能の作成
__会員管理①：会員登録用メールを要求する__

```swift:SignUpViewController.swift
// 【mBaaS：会員管理①】会員登録用メールを要求する
NCMBUser.requestAuthenticationMailInBackground(address.text) { (error: NSError!) -> Void in
    if error != nil {
        // 会員登録用メールの要求失敗時の処理
        print("エラーが発生しました：\(error!.code)")
        self.statusLabel.text = "エラーが発生しました：\(error!.code)"
    } else {
        // 会員登録用メールの要求失敗時の処理
        print("登録用メールを送信しました")
        self.statusLabel.text = "登録用メールを送信しました"
    }
}
```

---
## 会員管理機能の作成
__会員管理①：会員登録用メールを要求する__

* それぞれ処理を追記します

```swift
// 会員登録用メールの要求失敗時の処理
print("エラーが発生しました：\(error!.code)")
statusLabel.text = "エラーが発生しました：\(error!.code)"
```

---
## 会員管理機能の作成
__会員管理①：会員登録用メールを要求する__

* それぞれ処理を追記します


```swift
// 会員登録用メールの要求失敗時の処理
print("登録用メールを送信しました")
statusLabel.text = "登録用メールを送信しました"
```
---
## 会員管理機能の作成
__会員管理②：メールアドレスとパスワードでログイン__

![UserInfoRegistration.png](https://qiita-image-store.s3.amazonaws.com/0/112032/119c9f88-c05a-5458-2446-98df32fe3851.png)

---
## 会員管理機能の作成
__会員管理②：メールアドレスとパスワードでログイン__

* `LoginViewController.swift`を開きます
* ログイン処理を実装します

---
## 会員管理機能の作成
__会員管理②：メールアドレスとパスワードでログイン__

```swift:LoginViewController.swift
// 【mBaaS：会員管理②】メールアドレスとパスワードでログイン
NCMBUser.logInWithMailAddressInBackground(address.text, password: password.text) { (user: NCMBUser!, error: NSError!) -> Void in
    if error != nil {
        // ログイン失敗時の処理

    }else{
        // ログイン成功時の処理

    }
}
```

---
## 会員管理機能の作成
__会員管理②：メールアドレスとパスワードでログイン__

* それぞれ処理を追記します

```swift
// ログイン失敗時の処理
print("ログインに失敗しました:\(error.code)")
self.statusLabel.text = "ログインに失敗しました:\(error.code)"
```

---
## 会員管理機能の作成
__会員管理②：メールアドレスとパスワードでログイン__

* それぞれ処理を追記します

```swift
// ログイン成功時の処理
print("ログインに成功しました:\(user.objectId)")
// AppDelegateにユーザー情報を保持
self.appDelegate.current_user = user as NCMBUser
// TextFieldを空にする
self.cleanTextField()
// statusLabelを空にする
self.statusLabel.text = ""
// 画面遷移
self.performSegueWithIdentifier("login", sender: self)
```

---
## 会員管理機能の作成
__動作確認(1)ログインをしてみましょう__

* ログイン画面で「会員登録」をタップします
* 会員登録画面でメールアドレスを入力し、「登録メールを送信」をタップします

---
## 会員管理機能の作成
__動作確認(1)ログインをしてみましょう__

![動作確認①ログイン.png](https://qiita-image-store.s3.amazonaws.com/0/112032/50bafa23-a08b-c396-2f00-d10a507720d8.png)

---
## 会員管理機能の作成
__動作確認(1)ログインをしてみましょう__

* 会員登録メールが届くので、パスワード設定します

![動作確認①パスワード登録.png](https://qiita-image-store.s3.amazonaws.com/0/112032/61cb833b-5961-544e-6be6-e75b71a1563d.png)

---
## 会員管理機能の作成
__動作確認(1)ログインをしてみましょう__

* 再びログイン画面に戻り「メールアドレス」と「パスワード」でログインします
* ログを確認してください
 * [エラーコード一覧](http://mb.cloud.nifty.com/doc/current/rest/common/error.html#REST%20API%E3%81%AE%E3%82%A8%E3%83%A9%E3%83%BC%E3%82%B3%E3%83%BC%E3%83%89%E3%81%AB%E3%81%A4%E3%81%84%E3%81%A6)

---
## 会員管理機能の作成
__会員管理③：ユーザー情報更新__

![UserInfoRegistration.png](https://qiita-image-store.s3.amazonaws.com/0/112032/b7033b77-dfaf-f4cc-ee04-147b4a233608.png)

---
## 会員管理機能の作成
__会員管理③：ユーザー情報更新__

* `TopViewController.swift`を開きます
* 初回のみ表示されるユーザー情報登録画面に入力した情報をmBaaSのユーザー情報に追加する処理を実装します

---
## 会員管理機能の作成
__会員管理③：ユーザー情報更新__

```swift:TopViewController.swift
// 【mBaaS：会員管理③】ユーザー情報更新
// ログイン中のユーザーを取得
let user = NCMBUser.currentUser()
// ユーザー情報を設定
user.setObject(self.nickname.text, forKey: "nickname")
user.setObject(self.GENDER_CONFIG[self.genderSegCon.selectedSegmentIndex], forKey: "gender")
user.setObject(self.prefecture.text, forKey: "prefecture")
user.setObject([] as Array<String>, forKey: "favorite")
// user情報の更新
user.saveInBackgroundWithBlock({(error: NSError!) -> Void in
    if error != nil {
        // 更新失敗時の処理

    } else {
        // 更新成功時の処理

    }
})
```

---
## 会員管理機能の作成
__会員管理③：ユーザー情報更新__

* それぞれ処理を追記します

```swift
// 更新失敗時の処理
print("ユーザー情報更新に失敗しました:\(error.code)")
self.viewLabel.text = "登録に失敗しました（更新）:\(error.code)"
```

---
## 会員管理機能の作成
__会員管理③：ユーザー情報更新__

* それぞれ処理を追記します

```swift
// 更新成功時の処理
print("ユーザー情報更新に成功しました")
// AppDelegateに保持していたユーザー情報の更新
self.appDelegate.current_user = user as NCMBUser
// 【mBaaS：プッシュ通知①】installationにユーザー情報を紐づける
  /*****後でここに処理を記述します*****/

// 画面を閉じる
self.registerView.hidden = true
// ニックネーム表示用ラベルの更新
self.nicknameLabel.text = "\(self.appDelegate.current_user.objectForKey("nickname"))さん、こんにちは！"
// 画面更新
self.checkShop()
```

---
## Shop情報の設定
__mBaaSにShop情報を用意する（データストア）__

次の手順でアプリで使用するShop情報をmBaaSに設定します

---
## Shop情報の設定
__mBaaSにShop情報を用意する（データストア）__

* ニフティクラウド mobile backendのダッシュボードから「データストア」を開く
* 「＋作成▼」ボタンをクリックし、「インポート」をクリックします

---
## Shop情報の設定
__mBaaSにShop情報を用意する（データストア）__

 * クラス名に「__Shop__」と入力します
 * ダウンロードしたサンプルプロジェクトにあるSettingフォルダ内の「__Shop.json__」を選択してアップロードします

---
## Shop情報の設定
__mBaaSにShop情報を用意する（データストア）__

![ShopClass.png](https://qiita-image-store.s3.amazonaws.com/0/112032/61e9f156-568c-7397-54f5-ddda7aa86e48.png)

---
## Shop情報の設定
__mBaaSにShop情報を用意する（データストア）__

* こんな感じでインポートされます

![mBaaS_ShopData.PNG](https://qiita-image-store.s3.amazonaws.com/0/112032/17483205-b472-8496-0ec8-c9b4d24afe47.png)


---
## Shop情報の設定
__mBaaSにShop情報を用意する（ファイルストア）__

次の手順で各icon・Shop画面・リッチプッシュで使用する画像をmBaaSに設定します

* ニフティクラウド mobile backendのダッシュボードから「ファイルストア」を開く
* 「↑アップロード」ボタンをクリックします

---
## Shop情報の設定
__mBaaSにShop情報を用意する（ファイルストア）__

* ダウンロードしたサンプルプロジェクトにあるSettingフォルダ内の「icon」「Shop」「Sale」内にあるファイルをすべてをアップロードします

---
## Shop情報の設定
__mBaaSにShop情報を用意する（ファイルストア）__

![imageUpload.png](https://qiita-image-store.s3.amazonaws.com/0/112032/1dfc08a4-89a9-bcd6-d05b-cb5c3f1d5404.png)

---
## Shop情報の設定
__mBaaSにShop情報を用意する（ファイルストア）__

* こんな感じでアップロードされます

![UploadImage.png](https://qiita-image-store.s3.amazonaws.com/0/112032/9d200084-5752-e574-c8d5-1254e7db1dac.png)

---
## Shop情報の設定
__データストア：「Shop」クラスのデータを取得__

* アプリ側で先ほどmBaaSに設定したShopデータとimageデータを取得します

---
## Shop情報の設定
__データストア：「Shop」クラスのデータを取得__

* `TopViewController.swift`を開きます
* インポートしたShopクラスのデータを取得する処理を実装します

---
## Shop情報の設定
__データストア：「Shop」クラスのデータを取得__

```swift:TopViewController.swift
// 【mBaaS：データストア】「Shop」クラスのデータを取得
// 「Shop」クラスのクエリを作成
let query = NCMBQuery(className: "Shop")
// データストアを検索
query.findObjectsInBackgroundWithBlock({ (objects: [AnyObject]!, error: NSError!) -> Void in
    if error != nil {
        // 検索失敗時の処理

    } else {
        // 検索成功時の処理

    }
})
```

---
## Shop情報の設定
__データストア：「Shop」クラスのデータを取得__

* それぞれ処理を追記します

```swift
// 検索失敗時の処理
print("検索に失敗しました:\(error.code)")
```

---
## Shop情報の設定
__データストア：「Shop」クラスのデータを取得__

* それぞれ処理を追記します

```swift
// 検索成功時の処理
print("検索に成功しました")
// AppDelegateに「Shop」クラスの情報を保持
self.appDelegate.shopList = objects as! Array
// テーブルの更新
self.shopTableView.reloadData()
```

---
## Shop情報の設定
__ファイルストア①：icon画像の取得__

![icon.png](https://qiita-image-store.s3.amazonaws.com/0/112032/c29a5b47-4799-828f-e0e8-f5a0edebbe50.png)

---
## Shop情報の設定
__ファイルストア①：icon画像の取得__

* `CustomCell.swift`を開きます
 * `CustomCell.swift`はテーブルのセルを作成するファイルです
* トップ画面に各ショップのアイコンをmBaaSから取得して表示する処理を実装します

---
## Shop情報の設定
__ファイルストア①：icon画像の取得__

```swift:CustomCell.swift
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
```

---
## Shop情報の設定
__ファイルストア①：icon画像の取得__

* それぞれ処理を追記します

```swift
// ファイル取得失敗時の処理
print("icon画像の取得に失敗しました:\(error.code)")
```

---
## Shop情報の設定
__ファイルストア①：icon画像の取得__

* それぞれ処理を追記します

```swift
// ファイル取得成功時の処理
print("icon画像の取得に成功しました")
// icon画像を設定
self.iconImageView_top.image = UIImage.init(data: data)
```
---
## Shop情報の設定
__ファイルストア②：Shop画面画像の取得__

![Shop.png](https://qiita-image-store.s3.amazonaws.com/0/112032/306b1a79-fab9-0804-b644-7735f96be301.png)

---
## Shop情報の設定
__ファイルストア②：Shop画像の取得__

* `ShopViewController.swift`を開きます
* Shop画面に各ショップの画像をmBaaSから取得して表示する処理を実装します
 * 「`*****Shop画像名*****`」を「`shop_image`」に書き換えます

---
## Shop情報の設定
__ファイルストア②：Shop画像の取得__

```swift:ShopViewController.swift
// 【mBaaS：ファイルストア②】Shop画像の取得
// 取得した「Shop」クラスデータからShop画面用の画像名を取得
let imageName = appDelegate.shopList[shopIndex].objectForKey("*****Shop画像名*****") as! String
```

---
## Shop情報の設定
__ファイルストア②：Shop画像の取得__

```swift
// 【mBaaS：ファイルストア②】Shop画像の取得
// 取得した「Shop」クラスデータからshop画面用の画像名を取得
let imageName = appDelegate.shopList[shopIndex].objectForKey("shop_image") as! String
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
```

---
## Shop情報の設定
__動作確認(2)会員情報登録とShop情報表示__

* ログインをします
* ログイン後初回のみ、ユーザー情報登録画面が表示されます
* 入力し「登録」をタップします
 * このとき、会員情報が更新されますので、mBaaSのダッシュボードを確認してみましょう

---
## Shop情報の設定
__動作確認(2)会員情報登録とShop情報表示__

* ログを確認してください
 * [エラーコード一覧](http://mb.cloud.nifty.com/doc/current/rest/common/error.html#REST%20API%E3%81%AE%E3%82%A8%E3%83%A9%E3%83%BC%E3%82%B3%E3%83%BC%E3%83%89%E3%81%AB%E3%81%A4%E3%81%84%E3%81%A6)

---
## Shop情報の設定
__動作確認(2)会員情報登録とShop情報表示__

* トップ画面が表示されます
 * このとき、 画面に「icon画像」「Shop名」「カテゴリ」が表示されます
* ログを確認してください
 * [エラーコード一覧](http://mb.cloud.nifty.com/doc/current/rest/common/error.html#REST%20API%E3%81%AE%E3%82%A8%E3%83%A9%E3%83%BC%E3%82%B3%E3%83%BC%E3%83%89%E3%81%AB%E3%81%A4%E3%81%84%E3%81%A6)

---
## Shop情報の設定
__動作確認(2)会員情報登録とShop情報表示__

* Shopを１つ選んでタップします
 * mBaaSに登録されているimageにアクセスし、Shopページ（画像）が表示されます
* ログを確認してください
 * [エラーコード一覧](http://mb.cloud.nifty.com/doc/current/rest/common/error.html#REST%20API%E3%81%AE%E3%82%A8%E3%83%A9%E3%83%BC%E3%82%B3%E3%83%BC%E3%83%89%E3%81%AB%E3%81%A4%E3%81%84%E3%81%A6)

---
## Shop情報の設定
__動作確認(2)会員情報登録とShop情報表示__

* 会員ページをタップします
 * 初回登録画面で登録した内容と、ログイン用のアドレスを表示しています　
* ログを確認してください
 * [エラーコード一覧](http://mb.cloud.nifty.com/doc/current/rest/common/error.html#REST%20API%E3%81%AE%E3%82%A8%E3%83%A9%E3%83%BC%E3%82%B3%E3%83%BC%E3%83%89%E3%81%AB%E3%81%A4%E3%81%84%E3%81%A6)

---
## Shop情報の設定
__動作確認(2)会員情報登録とShop情報表示__

![動作確認②.png](https://qiita-image-store.s3.amazonaws.com/0/112032/54ba4fcc-724a-152c-2384-55972540b00e.png)

---
## お気に入り登録機能の作成

__お気に入り機能について__

* お気に入り機能は好きなShopをお気に入りとして保存できる機能です
 * 「お気に入り」画面と「Shop」画面で登録可能です

---
## お気に入り登録機能の作成

__お気に入り機能について__

* 「お気に入り」画面ではSwitchのON/OFFを設定し、「登録」ボタンで設定します
* 「Shop」画面では右上のハートマークをタップすることでShop単位で設定できます
 * 「♥」…ON　「♡」…OFF

---
## お気に入り登録機能の作成

__お気に入り機能について__

![favorite.png](https://qiita-image-store.s3.amazonaws.com/0/112032/db1062f8-8849-3854-f85d-c5f13efaceed.png)

---
## お気に入り登録機能の作成

__会員管理④：ユーザー情報の更新__

* `FavoriteViewController.swift`を開きます
* mBaaSの会員データとして保持していた「favorite」データを、お気に入り画面で設定したデータに更新する処理を実装します

---
## お気に入り登録機能の作成

__会員管理④：ユーザー情報の更新__

* 「`*****お気に入り情報*****`」を「`favorite`」に書き換えます

```swift:FavoriteViewController.swift
// 【mBaaS：会員管理④】ユーザー情報の更新
// 更新された値を設定
user.setObject(appDelegate.favoriteObjectIdTemporaryArray, forKey: "*****お気に入り情報*****")
```

---
## お気に入り登録機能の作成

__会員管理④：ユーザー情報の更新__

```swift:FavoriteViewController.swift
// 【mBaaS：会員管理④】ユーザー情報の更新
// ログイン中のユーザーを取得
let user = NCMBUser.currentUser()
// favoriteに更新された値を設定
user.setObject(appDelegate.favoriteObjectIdTemporaryArray, forKey: "favorite")
// ユーザー情報を更新
user.saveInBackgroundWithBlock { (error: NSError!) -> Void in
    if error != nil {
        // 更新に失敗した場合の処理
    } else {
        // 更新に成功した場合の処理
    }
}
```

---
## お気に入り登録機能の作成

__会員管理⑤：ユーザー情報の更新__

* `ShopViewController.swift`を開きます
* 同様にmBaaSの会員データとして保持していた「favorite」データを、Shop画面で設定したデータに更新する処理を実装します
 * 「`*****お気に入り情報*****`」を「`favorite`」に書き換えます

```swift:ShopViewController.swift
// 【mBaaS：会員管理⑤】ユーザー情報の更新
// 更新された値を設定
user.setObject(favoriteObjectIdArray, forKey: "*****お気に入り情報*****")
```

---
## お気に入り登録機能の作成
__動作確認(3)お気に入り情報登録・更新__

* ログインをするとトップ画面が表示されます
* 画面下の「お気に入り」をタップします
* お気に入り画面が表示されます
 * お気に入り登録をしてみましょう

---
## お気に入り登録機能の作成
__動作確認(3)お気に入り情報登録・更新__

* 各Shop画面も開いて同様に登録してみましょう
* ログを確認してください
 * [エラーコード一覧](http://mb.cloud.nifty.com/doc/current/rest/common/error.html#REST%20API%E3%81%AE%E3%82%A8%E3%83%A9%E3%83%BC%E3%82%B3%E3%83%BC%E3%83%89%E3%81%AB%E3%81%A4%E3%81%84%E3%81%A6)

---
## お気に入り登録機能の作成
__動作確認(3)お気に入り情報登録・更新__

![動作確認③.png](https://qiita-image-store.s3.amazonaws.com/0/112032/20208364-041e-e2f2-9693-7aa616f4127f.png)


---
## プッシュ通知を送信
__このあとのデバッグについて__

* 以下の用意が必要です
 * デバッグ用の実機
 * プッシュ通知用証明書(p12形式)

---
## プッシュ通知を送信
__このあとのデバッグについて__

* 証明書の取得がまだの場合は下記をご参照ください
 * [【サンプル】アプリにプッシュ通知を組み込もう！](https://github.com/NIFTYCloud-mbaas/SwiftPushApp)

---
## プッシュ通知を送信
__mBaaSの設定__

* プッシュ通知の許可とAPNsの証明書(p12形式)のアップロードを行います

![mBaaSプッシュ通知設定.png](https://qiita-image-store.s3.amazonaws.com/0/112032/99209ab7-9342-f965-f14b-3c2db24e6f9e.png)

---
## プッシュ通知を送信
__プッシュ通知①：デバイストークンの取得__

* `AppDelegate.swift`を開きます
* `applications(_:didFinishLaunchingWithOptions)`メソッド内のSDKの初期化を実装した部分の直ぐ下に処理を実装します

---
## プッシュ通知を送信
__プッシュ通知①：デバイストークンの取得__

```swift:AppDelegate.swift
// 【mBaaS：プッシュ通知①】デバイストークンの取得
// デバイストークンの要求
if (NSFoundationVersionNumber > NSFoundationVersionNumber_iOS_7_1){
    /** iOS8以上 **/
    //通知のタイプを設定したsettingを用意
    let type : UIUserNotificationType = [.Alert, .Badge, .Sound]
    let setting = UIUserNotificationSettings(forTypes: type, categories: nil)
    //通知のタイプを設定
    application.registerUserNotificationSettings(setting)
    //DevoceTokenを要求
    application.registerForRemoteNotifications()
}else{
    /** iOS8未満 **/
    let type : UIRemoteNotificationType = [.Alert, .Badge, .Sound]
    UIApplication.sharedApplication().registerForRemoteNotificationTypes(type)
}
```

---
## プッシュ通知を送信
__プッシュ通知②：デバイストークンの取得後に呼び出されるメソッド__

* `AppDelegate.swift`を開きます
* `applications(_:didFinishLaunchingWithOptions)`メソッド下(外)に次のメソッドを実装します

---
## プッシュ通知を送信
__プッシュ通知②：デバイストークンの取得後に呼び出されるメソッド__

```swift:AppDelegate.swift
// 【mBaaS：プッシュ通知②】デバイストークンの取得後に呼び出されるメソッド
func application(application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: NSData){
    // 端末情報を扱うNCMBInstallationのインスタンスを作成
    let installation = NCMBInstallation.currentInstallation()
    // デバイストークンの設定
    installation.setDeviceTokenFromData(deviceToken)
    // 端末情報をデータストアに登録
    installation.saveInBackgroundWithBlock { (error: NSError!) -> Void in
        if (error != nil){
            // 端末情報の登録に失敗した時の処理

        }else{
            // 端末情報の登録に成功した時の処理

        }
    }
}
```

---
## プッシュ通知を送信
__プッシュ通知②：デバイストークンの取得後に呼び出されるメソッド__

* それぞれ処理を追記します

```swift
// 端末情報の登録に失敗した時の処理
print("デバイストークン取得に失敗しました:\(error.code)")
```

---
## プッシュ通知を送信
__プッシュ通知②：デバイストークンの取得後に呼び出されるメソッド__

* それぞれ処理を追記します

```swift
// 端末情報の登録に成功した時の処理
print("デバイストークン取得に成功しました")
```

---
## プッシュ通知を送信①セグメント配信
__プッシュ通知③：installationにユーザー情報を紐づける__

* `TopViewController.swift`を開きます
* セグメント配信のために必要なユーザー情報をinstallationに紐付けるための処理を実装します

---
## プッシュ通知を送信①セグメント配信
__プッシュ通知③：installationにユーザー情報を紐づける__

* 実装箇所は「【mBaaS：会員管理③】ユーザー情報更新」の更新成功時の処理内です

```swift:TopViewController.swift
// 【mBaaS：プッシュ通知③】installationにユーザー情報を紐づける
/*****後でここに処理を記述します*****/

```

---
## プッシュ通知を送信①セグメント配信
__プッシュ通知③：installationにユーザー情報を紐づける__

```swift
// 【mBaaS：プッシュ通知③】installationにユーザー情報を紐づける
// 使用中端末のinstallation取得
let installation: NCMBInstallation? = NCMBInstallation.currentInstallation()
// ユーザー情報を設定
installation!.setObject(self.nickname.text, forKey: "nickname")
installation!.setObject(self.GENDER_CONFIG[self.genderSegCon.selectedSegmentIndex], forKey: "gender")
installation!.setObject(self.prefecture.text, forKey: "prefecture")
installation!.setObject([] as Array<String>, forKey: "favorite")
// installation情報の更新
installation!.saveInBackgroundWithBlock({ (error: NSError!) -> Void in
    if error != nil {
        // installation更新失敗時の処理

    } else {
        // installation更新成功時の処理

    }
})
```

---
## プッシュ通知を送信①セグメント配信

__プッシュ通知③：installationにユーザー情報を紐づける__

* それぞれ処理を追記します

```swift
// installation更新失敗時の処理
print("installation更新(ユーザー登録)に失敗しました:\(error.code)")
```

---
## プッシュ通知を送信①セグメント配信

__プッシュ通知③：installationにユーザー情報を紐づける__

* それぞれ処理を追記します

```swift
// installation更新成功時の処理
print("installation更新(ユーザー登録)に成功しました")
```

---
## プッシュ通知を送信①セグメント配信
__プッシュ通知④⑤：installationにユーザー情報を紐づける[実装済み]__

* 同様に、お気に入り画面・Shop画面でお気に入り情報が更新されるたびに、installation情報も書き換えます

---
## プッシュ通知を送信①セグメント配信
__プッシュ通知④：installationにユーザー情報を紐づける[実装済み]__

* `FavoriteViewController.swift`

```swift
// 【mBaaS：プッシュ通知④】installationにユーザー情報を紐づける
let installation: NCMBInstallation? = NCMBInstallation.currentInstallation()
if installation != nil {
    // お気に入り情報を設定
    installation!.setObject(self.appDelegate.favoriteObjectIdTemporaryArray, forKey: "favorite")
    // installation情報の更新
    installation!.saveInBackgroundWithBlock({ (error: NSError!) -> Void in
        if error != nil {
            // installation更新失敗時の処理
            print("installation更新(お気に入り)に失敗しました:\(error.code)")
        } else {
            // installation更新成功時の処理
            print("installation更新(お気に入り)に成功しました")
        }
    })
}
```

---
## プッシュ通知を送信①セグメント配信
__プッシュ通知⑤：installationにユーザー情報を紐づける[実装済み]__

* `ShopViewController.swift`

```swift
// 【mBaaS：プッシュ通知⑤】installationにユーザー情報を紐づける
let installation: NCMBInstallation? = NCMBInstallation.currentInstallation()
if installation != nil {
    // お気に入り情報を設定
    installation!.setObject(favoriteObjectIdArray, forKey: "favorite")
    // installation情報の更新
    installation!.saveInBackgroundWithBlock({ (error: NSError!) -> Void in
        if error != nil {
            // installation更新失敗時の処理
            print("installation更新(お気に入り)に失敗しました:\(error.code)")
        } else {
            // installation更新成功時の処理
            print("installation更新(お気に入り)に成功しました")
        }
    })
}
```
---
## プッシュ通知を送信①セグメント配信
__動作確認(4)mBaaS準備__

* もう一度会員情報登録画面を表示するため、mBaaSの会員管理画面で「クラスの編集」をクリックします
* 「nickname」にチェックを入れて上の「削除」ボタンで削除します

---
## プッシュ通知を送信①セグメント配信
__動作確認(4)mBaaS準備__

![動作確認④セグメント0.png](https://qiita-image-store.s3.amazonaws.com/0/112032/e01e4f5f-a2d0-e9ff-4dfa-94ee52669678.png)

---
## プッシュ通知を送信①セグメント配信
__動作確認(4)セグメント配信__

* 実機でアプリをビルドします
* プッシュ通知の許可をして、ログを確認します
 * [エラーコード一覧](http://mb.cloud.nifty.com/doc/current/rest/common/error.html#REST%20API%E3%81%AE%E3%82%A8%E3%83%A9%E3%83%BC%E3%82%B3%E3%83%BC%E3%83%89%E3%81%AB%E3%81%A4%E3%81%84%E3%81%A6)

```
端末側でプッシュ通知が許可されました
デバイストークン取得に成功しました
```

---
## プッシュ通知を送信①セグメント配信
__動作確認(4)セグメント配信__

* ログインをし、再びユーザー登録をします
 * このとき、installationが更新されますのでダッシュボードを確認します
* ログを確認してください
 * [エラーコード一覧](http://mb.cloud.nifty.com/doc/current/rest/common/error.html#REST%20API%E3%81%AE%E3%82%A8%E3%83%A9%E3%83%BC%E3%82%B3%E3%83%BC%E3%83%89%E3%81%AB%E3%81%A4%E3%81%84%E3%81%A6)

---
## プッシュ通知を送信①セグメント配信
__動作確認(4)セグメント配信__

* shopBをお気に入り登録しているユーザーに絞り込んでプッシュ通知を配信してみましょう
* 今回は登録ユーザーが１人(１端末)なので、あらかじめshopBをお気に入りに設定しておきます

---
## プッシュ通知を送信①セグメント配信
__動作確認(4)セグメント配信__

* mBaaSのダッシュボードからShopクラスのデータを開きます
* shopBの「objectId」をコピーします

---
## プッシュ通知を送信①セグメント配信
__動作確認(4)セグメント配信__

![動作確認④セグメント2.png](https://qiita-image-store.s3.amazonaws.com/0/112032/70eff815-e9e3-65d2-1603-bcc0628fc692.png)

---
## プッシュ通知を送信①セグメント配信
__動作確認(4)セグメント配信__

* プッシュ通知を作成します
* メッセージを入力します
 * 例：ShopBセール開催中！
* 「iOS端末に配信する」にチェックを入れます
* 「配信端末」を設定します

---
## プッシュ通知を送信①セグメント配信
__動作確認(4)セグメント配信__

![動作確認④セグメント1.png](https://qiita-image-store.s3.amazonaws.com/0/112032/d5c5884d-5a11-7dff-0bcf-98baf7635d83.png)

---
## プッシュ通知を送信①セグメント配信
__動作確認(4)セグメント配信__

* 「installationクラスからの絞込み」を選択します
* 絞り込み設定をします
 * ここでコピーしたShopBのobjectIdを貼り付けます

---
## プッシュ通知を送信①セグメント配信
__動作確認(4)セグメント配信__

![動作確認④セグメント3.png](https://qiita-image-store.s3.amazonaws.com/0/112032/b227bd42-07c0-d294-b06d-612a0c0e6265.png)

---
## プッシュ通知を送信①セグメント配信
__動作確認(4)セグメント配信__

* 「１端末に向けて送信されます」と表示されればOKです
* 「プッシュ通知を作成する」をクリックします
* 少し待つと配信されます→端末を確認！

---
## プッシュ通知を送信①セグメント配信
__動作確認(4)セグメント配信__

![動作確認④セグメント4.png](https://qiita-image-store.s3.amazonaws.com/0/112032/9cab1a38-ae31-5169-cfdb-fdef4a6f3f38.png)

---
## プッシュ通知を送信①セグメント配信
__動作確認(4)セグメント配信__

* いろいろなパターンで送ってみましょう！
 * 別のショップを絞り込み
 * 性別で絞込み
 * ShopAをお気に入り登録かつ女性で絞込み
 * ShopDをお気に入り登録かつ東京都で絞込み

---
## プッシュ通知を送信②リッチプッシュ
__リッチプッシュについて__

* プッシュ通知登録時にURLを指定することで、開封時にWebビューを表示できる機能です
* プッシュ通知開封でアプリが起動するときに表示されます
 * アプリ起動中には表示されませんので閉じる必要があります（仕様）


---
## プッシュ通知を送信②リッチプッシュ
__リッチプッシュについて__

* 今回はShopのセール画像を「公開ファイル」機能を利用して配信します

![sale_image.png](https://qiita-image-store.s3.amazonaws.com/0/112032/1487da6d-b4e4-4337-1b87-098781ea3f78.png)

---
## プッシュ通知を送信②リッチプッシュ
__公開ファイルとは__

* 「公開ファイル」機能とは、ファイルストアに保存した画像をリンクでアクセスできるようにする機能です
* ファイルストアに登録した画像を「公開ファイル」にします

---
## プッシュ通知を送信②リッチプッシュ
__公開ファイル設定__

* mBaaSのダッシュボードで、公開ファイル設定「HTTPでの取得」を有効にします

---
## プッシュ通知を送信②リッチプッシュ
__公開ファイル設定__

![公開ファイル確認.png](https://qiita-image-store.s3.amazonaws.com/0/112032/539c2789-54d6-c4a5-2842-c994b8cd8e46.png)


---
## プッシュ通知を送信②リッチプッシュ
__公開ファイル作成__

* リンクは以下のように作成できます

```
https://mb.api.cloud.nifty.com/2013-09-01/applications/*****アプリケーションID*****/publicFiles/*****ファイル名*****
```

---
## プッシュ通知を送信②リッチプッシュ
__公開ファイル作成__

* 「`*****アプリケーションID*****`」をmBaaSのアプリケーションIDに書き換えます

![アプリケーションID確認.png](https://qiita-image-store.s3.amazonaws.com/0/112032/c6409f1a-41bb-8f99-b36f-35355765b46b.png)

---
## プッシュ通知を送信②リッチプッシュ
__公開ファイル作成__

* 「`*****ファイル名*****`」はセール画像の名前を指定します

![sale_image_name.png](https://qiita-image-store.s3.amazonaws.com/0/112032/21c7f1f8-2d5d-cdf8-5b09-b71abf5e9654.png)

---
## プッシュ通知を送信②リッチプッシュ
__公開ファイル作成__

* 作成できたらブラウザでリンクをたたいて確認してください！

![公開ファイル確認.png](https://qiita-image-store.s3.amazonaws.com/0/112032/6a02b418-c8f2-ad02-f9fd-7d8eb1d45673.png)

---
## プッシュ通知を送信②リッチプッシュ
__プッシュ通知⑥：リッチプッシュ通知を表示させる処理__

* `AppDelegate.swift`を開きます
* `applications(_:didFinishLaunchingWithOptions)`メソッド内、`【プッシュ通知①】デバイストークンの取得`の下に処理を実装します

---
## プッシュ通知を送信②リッチプッシュ
__プッシュ通知⑥：リッチプッシュ通知を表示させる処理__

```swift:AppDelegate.swift
// 【mBaaS：プッシュ通知⑥】リッチプッシュ通知を表示させる処理
if let remoteNotification = launchOptions?[UIApplicationLaunchOptionsRemoteNotificationKey] as? NSDictionary {
    NCMBPush.handleRichPush(remoteNotification as [NSObject : AnyObject])
}
```

---
## プッシュ通知を送信②リッチプッシュ
__動作確認(5)リッチプッシュ__

* 実機でアプリをビルドします
* 起動し、下記ログを確認したらアプリを完全に閉じます

```
デバイストークン取得に成功しました
```
---
## プッシュ通知を送信②リッチプッシュ
__動作確認(5)リッチプッシュ__

* プッシュ通知を作成します
* URL欄に作成した公開ファイルのURLを貼り付けます
* そのまま送信してみましょう

---
## プッシュ通知を送信②リッチプッシュ
__動作確認(5)リッチプッシュ__

![動作確認⑤リッチプッシュ.png](https://qiita-image-store.s3.amazonaws.com/0/112032/430e4661-8627-a1a7-a82c-918f5dbf3aa3.png)

---
## プッシュ通知を送信③ペイロード
__ペイロードについて__

* プッシュ通知にはJSON形式で任意のデータを含めることができ、通知を受信した時に、そのデータを受け取って処理を行うことができる機能です

---
## プッシュ通知を送信③ペイロード
__ペイロードについて__

* データ取得の条件
 * アプリの起動中にプッシュ通知を受信してデータを取得
 * プッシュ通知受信後、アプリを起動時にデータを取得


---
## プッシュ通知を送信③ペイロード
__ペイロードについて__

* 今回は、配信時間とメッセージのデータを設定し、時限式でローカルプッシュを表示させる内容を実装します

---
## プッシュ通知を送信③ペイロード
__ペイロードについて__

* プッシュ通知に設定するJSON形式のデータ

```
{"deliveryTime":"2016-09-22 17:00:00", "message":"タイムセールスタート！"}
```

---
## プッシュ通知を送信③ペイロード
__プッシュ通知⑦：アプリが起動中にプッシュ通知の情報（ペイロード）からデータを取得する

* `AppDelegate.swift`を開きます
* `applications(_:didFinishLaunchingWithOptions)`メソッド外に次のメソッドを実装します

---
## プッシュ通知を送信③ペイロード
__プッシュ通知⑦：アプリが起動中にプッシュ通知の情報（ペイロード）からデータを取得する

```swift:AppDelegate.swift
// 【mBaaS：プッシュ通知⑦】アプリが起動中にプッシュ通知の情報（ペイロード）からデータを取得する
func application(application: UIApplication, didReceiveRemoteNotification userInfo: [NSObject : AnyObject]) {
    // プッシュ通知情報の取得
    let deliveryTime = userInfo["deliveryTime"] as! String
    let message = userInfo["message"] as! String
    // 値を取得した後の処理
    if !deliveryTime.isEmpty && !message.isEmpty  {
        print("ペイロードを取得しました：deliveryTime[\(deliveryTime)],message[\(message)]")
        // ローカルプッシュ配信
        localNotificationDeliver(deliveryTime, message: message)
    }
}
```

---
## プッシュ通知を送信③ペイロード
__プッシュ通知⑧：アプリが起動されたときにプッシュ通知の情報（ペイロード）からデータを取得する__

* `AppDelegate.swift`を開きます
* `applications(_:didFinishLaunchingWithOptions)`メソッド内、`【mBaaS：プッシュ通知⑥】リッチプッシュ通知を表示させる処理`の下に処理を実装します

---
## プッシュ通知を送信③ペイロード
__プッシュ通知⑧：アプリが起動されたときにプッシュ通知の情報（ペイロード）からデータを取得する__

```swift:AppDelegate.swift
// 【mBaaS：プッシュ通知⑧】アプリが起動されたときにプッシュ通知の情報（ペイロード）からデータを取得する
// プッシュ通知情報の取得
if let deliveryTime = remoteNotification.objectForKey("deliveryTime") as? String {
    if let message = remoteNotification.objectForKey("message") as? String {
        // ローカルプッシュ配信
        localNotificationDeliver(deliveryTime, message: message)
    }
}
```

---
## プッシュ通知を送信③ペイロード
__参考：ローカルプッシュ[実装済み]__

```swift
// LocalNotification配信
func localNotificationDeliver (deliveryTime: String, message: String) {
    // 配信時間(String→NSDate)
    let formatter = NSDateFormatter()
    formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
    let deliveryTime = formatter.dateFromString(deliveryTime)
    LocalNotificationManager.scheduleLocalNotificationAtData(deliveryTime!, alertBody: message, userInfo: nil)
}
```

---
## プッシュ通知を送信③ペイロード
__動作確認(6)ペイロード（起動中）__

* 実機でアプリをビルドします
* 起動し、下記ログを確認します

```
端末側でプッシュ通知が許可されました
デバイストークン取得に成功しました
```

* そのままアプリを起動した状態にします

---
## プッシュ通知を送信③ペイロード
__動作確認(6)ペイロード（起動中）__

* プッシュ通知に設定するJSON形式のデータを作成します
 * 時間は今から５分以上未来の時間に変更してください
 * メッセージは自由に変更してください

```
{"deliveryTime":"2016-09-22 17:00:00", "message":"タイムセールスタート！"}
```

---
## プッシュ通知を送信③ペイロード
__動作確認(6)ペイロード（起動中）__

* プッシュ通知を作成し、JSON形式のデータを貼り付けます
 * メッセージを入力が無い場合、サイレントプッシュとして送られます

![動作確認⑥ペイロード1.png](https://qiita-image-store.s3.amazonaws.com/0/112032/65c73662-bc6a-d2cc-0f60-fb4d7181c3a5.png)

---
## プッシュ通知を送信③ペイロード
__動作確認(6)ペイロード（起動中）__

* プッシュ通知を送信します
* プッシュ通知を受信（サイレント）すると次のログが表示されます

```
ペイロードを取得しました：deliveryTime[2016-09-22 17:00:00],message[タイムセールスタート！]
```
* エラーログが出た場合
 * [エラーコード一覧](http://mb.cloud.nifty.com/doc/current/rest/common/error.html#REST%20API%E3%81%AE%E3%82%A8%E3%83%A9%E3%83%BC%E3%82%B3%E3%83%BC%E3%83%89%E3%81%AB%E3%81%A4%E3%81%84%E3%81%A6)

---
## プッシュ通知を送信③ペイロード
__動作確認(6)ペイロード（起動中）__

* 指定時間になるとプッシュ通知が表示されることを確認してください

---
## プッシュ通知を送信③ペイロード
__動作確認(6)ペイロード（非起動時）__

* アプリを完全に閉じます
* 再びプッシュ通知を作成します

---
## プッシュ通知を送信③ペイロード
__動作確認(6)ペイロード（非起動時）__

* アプリを起動してもらう内容でプッシュ通知を作成します
* メッセージ例）`明日PM17時よりタイムセールを行います！`
* JSON形式のデータを貼り付けます
 * 時間は今から５分以上未来の時間に変更してください

![動作確認⑥ペイロード2.png](https://qiita-image-store.s3.amazonaws.com/0/112032/efc24f4a-57ed-87fd-43ce-b291580cb5d8.png)

---
## プッシュ通知を送信③ペイロード
__動作確認(6)ペイロード（非起動時）__

* プッシュ通知を受信したら、プッシュ通知からアプリを起動します
* 起動時にデータを取得します
 * １度起動してあればアプリは閉じてもOKです

---
## まとめ
__学んだこと__

* mBaaSの各機能を使用してアプリ作成方法を学んだ！
 * 会員管理機能・データストア・ファイルストア・プッシュ通知をマスター◎
* プッシュ通知の活用方法がわかった！
 * 絞り込み配信・リッチプッシュをマスター◎

---
## 参考

* 開催中の[セミナー](https://ncmb.doorkeeper.jp/)のご案内
* ハンズオン内容が実装された完全版プロジェクト
 * [SwiftAdvancePushApp【完成版】](https://github.com/natsumo/SwiftAdvancePushApp/archive/master.zip)

* コードは[GitHub](https://github.com/natsumo/SwiftAdvancePushApp)に公開しています
 * __master__：完成版
 * __seminar_version__：セミナー版(虫食い)
