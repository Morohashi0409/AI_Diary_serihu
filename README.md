# Serihu"感情分析日記アプリ"
deploygateにてβ版を公開しました。
 ![QR](https://user-images.githubusercontent.com/78011541/156526826-dbfbd9b7-efa8-4503-9340-da55657bc662.png)　<br>
 https://apps.apple.com/jp/app/id1612101321<br>
 気になった方はインストールしてみてください。
 
私が作成したアプリは、AIによる感情分析して、フィードバックを返すことができる日記アプリです。

 このアプリは、ポジティブ心理学の知見に基づいて作成しており抑鬱傾向の高い人や、ストレスコーピングがうまくできていない人に向けて作成しました。<br>
 日記というものは、その日に起きた行動や、感情を文字に起こすことで、自分自身について見つめ直す機会になると考えています。<br>
 ただ、目に見えて成果がでるものではないので、なかなか続けられなかったり、あまり意義を感じられない人も多くいると思います。<br>
 また、ネガティブなことしかなかった日に、その内容を書いても逆にイライラする、といったこともあると思います。<br>
 そこで、AIによる感情分析・フィードバックが加わることで、感情が可視化されるので、より自分自身について見つめ直すことができると考えました。<br>
 
 日記に書いた内容を文字認識・感情分析し、ポジティブであれば、褒めるようなセリフを返し、逆にネガティブであれば励ますようなセリフを返す仕組みになっています。
 
# デモ画面
![mp4](https://user-images.githubusercontent.com/78011541/156307850-a75dc034-dc07-4a13-b096-5f5776dd5011.mp4)
スマホアプリなので、実際に使ってみたときの画面を添付しました。
書いた内容を読み取り-100~+100までの数値と、ハートの色で感情を可視化できていることがわかると思います。
また、その値に対応して、ハリネズミくんがフィードバックを返しています。
![日記記入画面](https://user-images.githubusercontent.com/78011541/154833456-ca97455a-4633-4014-a41a-987556f9cf63.jpg)

タイトル画面では、以前書いた日には、感情分析結果の色を背景に反映させています。
また、日記を書く前にカテゴリー化をさせて、フィードバックをもっと正確なものにしています。
![タイトル画面](https://user-images.githubusercontent.com/78011541/154833434-384fd1bf-f65f-4ecd-afef-4637fcfab714.jpg)

# 工夫した点・独自性のある点
工夫した点は二つあると考えています。<br>
一つは、AIが感情分析し、そしてフィードバックを返す点です。
日記という誰にも見られずに自由に書いてよい、といった長所は無くさずに、フィードバックをすることでメンタルヘルスにもつながることを意識しました。
また、文字認識や感情分析はGCPのライブラリを使用して、フィードバックのセリフのバリエーションを増やしていきました。<br>
二つ目は、Ipad+applepencilにも対応させた点です。
現状applepencilに対応した日記アプリというのはApp Storeに公開されていません。
デジタル入力・手書き入力そのどちらにも対応させたことが一つの工夫点だと考えています。

# 使用した言語
フロントエンド側：swift フレームワーク:Xcode

サーバーエンド側: Python フレームワーク:VSCode　API:fastapi

データベース:Deta Cloud(fastapiのスポンサー)(https://www.deta.sh/?ref=fastapi)

# 使用したライブラリ
フロントエンド側
1. FSCalendar(カレンダー機能が充実しているライブラリ・日付管理のために使用）
2. Realm(データベース管理システム・端末にデータを保存するために使用）
3. PencilKit(applePencil操作に関するライブラリ・手書きでの日記筆記のために使用）


サーバーエンド側
1. GCP(Google Cloud Platform)
 1. Google Natural Language API(与えられた文章を感情分析し、数値化して返すAPI）
 2. Google Cloud Vision API(手書きの場合に、文字認識するために使用）
2. fastapi(RESTfulAPIを開発するためのWebフレームワーク・感情分析などの処理・データベースを保存するために使用）
3. deta(fastapiと相性の良いデータベース・ユーザー情報を管理するために使用）

# 制作期間・人数
4ヶ月・個人開発です。
# 注意
ソースコードは就活時の開発物提出用に添付しました。
引用してもおそらく機能しないかと思います。
# 作成者
* 玉川大学3年諸橋裕平
* wantedly(https://www.wantedly.com/id/yuuhei_morohashi)
* メールアドレスmoromoropi@gmail.com
