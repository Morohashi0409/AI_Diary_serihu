from dataclasses import dataclass
from typing import Optional
import json
from fastapi import FastAPI
#from nbformat import write
from pydantic import BaseModel
import requests
# matplotlib.pyplotモジュール をインポートし、pltと略して使います。plt.show()のように使用できます
from io import BytesIO
import base64
# numpyライブラリ をインポートして、npと略して使います。np.arange()のように使用できます。
import numpy as np
import binascii
import io
import matplotlib.pyplot as plt
from fastapi.responses import JSONResponse
from operator import lt, le
from deta import Deta  # Import Deta
import datetime

from requests.models import stream_decode_response_unicode
# Initialize with a Project Key
deta = Deta("c0g0sd7g_Vb2R7o4AdhCZs8YAqudFHzcfxs4xihUh")

# This how to connect to or create a database.
db = deta.Base("simple_db")

def Im_analysis(image_path):#visionAPIを利用して文字認識を行う。
    API_KEY = "AIzaSyAxlXxFNjIx1-gw6-qYcexl9R4uCTrrDuI"
    api_url = 'https://vision.googleapis.com/v1/images:annotate?key={}'.format(
        API_KEY)
    image_content = image_path
    req_body = json.dumps({
        'requests': [{
            'image': {
                'content': image_content.decode('utf-8')
            },
            'features': [{
                'type': 'DOCUMENT_TEXT_DETECTION'
            }]
        }]
    })
    res = requests.post(api_url, data=req_body)
    return res.json()


def g_nlp(text):#national Language APIを利用して、文章の感情分析を行っている。
    key = 'AIzaSyAxlXxFNjIx1-gw6-qYcexl9R4uCTrrDuI'
    url = f'https://language.googleapis.com/v1/documents:analyzeSentiment?key={key}'

    header = {'Content-Type': 'application/json'}
    body = {
        "document": {
            "type": "PLAIN_TEXT",
            "language": "JA",
            "content": text
        }
    }
    res = requests.post(url, headers=header, json=body)
    result = res.json()
    return result


def heartmake(a, b, c, kekka, hosi ,id):
    # グラフ上の点を作成します。それらの点が線でつながれると、ハート曲線のようなグラフができます

    # t: 0から2πまで0.01間隔で並んだ数字の配列(ndarray)。パラメータt。
    # right_t: ハート曲線の右端の点に来る時のtの値=π/2
    # right_y: ハート曲線の右端の点に来る時のy座標の値
    # x: グラフ上の点のx座標の配列(ndarray) をパラメータtを用いて表します
    # y: グラフ上の点のy座標の配列(ndarray) をパラメータtを用いて表します。

    t = np.arange(0, 2*np.pi, 0.01)  # np.pi は円周率
    right_t = np.pi/2
    right_y = 13*np.cos(right_t)-5*np.cos(2*right_t)-2 * \
        np.cos(3*right_t)-np.cos(4*right_t)
    x = 16 * np.sin(t) ** 3
    y = 13 * np.cos(t) - 5 * np.cos(2*t) - 2 * np.cos(3*t) - np.cos(4*t)

    # ここから図を作ります
    if id == "1":
        fig = plt.figure()  # Figure(図)のインスタンスfig。何も描かれてない図。
        ax = fig.add_subplot(1, 1, 1)  # 座標軸(axes)のインスタンスax を作ります。グラフを描く前に座標軸を決めます。
        ax.set_xlim(-17, 17)  # x軸を表示する範囲を -17から17 とします
        ax.set_ylim(-20, 13)  # y軸を表示する範囲を -20から13 とします
        ax.plot(x, y, color=(a, b, c))  # 点(x,y)を順番にピンクの線でつなぎます
        ax.fill_between(x, y, y2=right_y, color=(
            a, b, c))  # 点(x,y) で囲まれた領域を赤く塗りつぶす
        suuti = int(kekka * 100)
        if hosi == 1 and suuti >= 70:
            ax.scatter(8, 8, s=3000, marker="*", color="yellow")
        ax.text(0, 0, suuti, fontsize=50, horizontalalignment="center",
                verticalalignment="center")
        #ax.text(0, -10, "push", fontsize=50, horizontalalignment="center",verticalalignment="center")
        ax.set_aspect(1)  # x,yの目盛りの比を1にします
        ax.axis("off")
        return fig
    else:
        fig = plt.figure() # Figure(図)のインスタンスfig。何も描かれてない図。
        ax = fig.add_subplot(1,1,1)  # 座標軸(axes)のインスタンスax を作ります。グラフを描く前に座標軸を決めます。
        ax.set_xlim(-17, 17) # x軸を表示する範囲を -17から17 とします
        ax.set_ylim(-20, 13) # y軸を表示する範囲を -20から13 とします
        ax.plot(x, y, color=(1,0,0)) # 点(x,y)を順番にピンクの線でつなぎます
        ax.fill_between(x, y, y2=right_y, color=(1,0,0)) # 点(x,y) で囲まれた領域を赤く塗りつぶす
        ax.text(0, 0, "push", fontsize=50, horizontalalignment="center",
            verticalalignment="center")
        ax.set_aspect(1) # x,yの目盛りの比を1にします
        ax.axis("off")
        return fig

def get_class(val, range_lst, op):#感情、文字数値によってクラス分けを行う。
    c = len(range_lst) # 最初に範囲外とみなす
    for i, v in enumerate(range_lst):
        if op(val, v): # 比較
            c = i
            break
    return c

def bunseki(u):
    mozisu, kanjo = u
    ct = get_class( mozisu, [50,80], le) # le以下,50文字以下、80文字以下、それ以上に分類
    cs = get_class( kanjo, [-0.5,0,0.5], lt) # lt未満、-0.5未満、0未満、0.5未満、それ以上で分類
    return ct, cs

def get_now():
    now = datetime.datetime.now(datetime.timezone(datetime.timedelta(hours=9))) # 日本時刻
    return now.strftime('%Y/%m/%d/%H:%M')  # yyyyMMddHHmmss形式で出力
#返す言葉達startは一言目、dicは二言目endは終わりに伝えること、Gobiはキャラクターによって変化する。
start = {
    0: "書いてくれてありがとGobi。",
    1: "お疲れ様でしたGobi。",
    2: "一日お疲れ様Gobi。",
    3: "一日お疲れ様頑張ったGobi。",
    4: "いつもありがとGobi。",
    5: "お待たせ、いつもありがとGobi。"
}

dic = {
    (0,0): "元気がないみたいGobi\nそんな日もあるGobi・・・。",
    (0,1): "明日はきっといい日になるGobi。",
    (0,2): "いい日だったみたいで嬉しいGobi！",
    (0,3): "とてもいい日だったみたいで僕も嬉しいGobi！",
    (1,0): "いつもよく頑張っているGobi\n疲れた時は寝るに限るGobi。",
    (1,1): "ちょっとネガティブみたいGobi。\nでも、あなただったら大丈夫Gobi！",
    (1,2): "いい日だったみたいGobi！\nたくさん書いてくれて嬉しいGobi！。",
    (1,3): "とてもいい日だったみたいGobi！\n幸せな気持ちが文字から伝わるGobi！。",
    (2,0): "たまには息抜きするGobi。\n不安やストレスを日記に書くことで整理されていくGobi。",
    (2,1): "長文で偉いGobi。\nどんなことがあったって私はあなたの味方Gobi。",
    (2,2): "いい日だったみたいGobi！\nとってもたくさん書いてて素晴らしいGobi。",
    (2,3): "最高の日だったみたいGobi!\n明日もいい日なるGobiよ！"}

owari = {
    0:"未定。必要であれば追加する"
}
pozi = ['ありがとう', '感謝', '好き' ,'最高']#ポジティブな単語リスト
app = FastAPI()


class Item(BaseModel):
    id: str
    name: str
    old : str
    sex : str
    date : str
    data: str
    count: str
    write: str
    kanjo: str
    taisyo: str

class D_Item(BaseModel):
    id : str
    name: str
    old: str
    sex: str
    date : str
    data: str
    count: str
    write: str
    kanjo: str
    taisyo: str


class Item_s(BaseModel):
    date : str
    count: str
    stress: str
    name: str


@app.get("/")
async def root():
    return {"message": "Hello World"}


@app.post("/items/")
async def create_item(item: Item):
    response = []
    score_list = []
    magu_list = []
    scor_list = []
    text_list = []
    new_score_list = []
    serihu_list = []
    data = item.data
    data = data.encode()
    A_result = Im_analysis(data)#文字認識を行う。
    res_text = A_result["responses"][0]["textAnnotations"][0]["description"]#結果の文章部分のみの抜き出し。
    characters = "\n"
    res_text = ''.join(x for x in res_text if x not in characters)#改行部分の削除
    kanjou_result = g_nlp(res_text)#感情分析を実施
    
    for i in range(len(kanjou_result['sentences'])):
        score_list.append(kanjou_result['sentences'][i]['sentiment'])
        scor_list.append(score_list[i]['score'])
        magu_list.append(score_list[i]['magnitude'])
        text_list.append(kanjou_result['sentences'][i]['text']['content'])
    for n in scor_list:
        if abs(n) >= 0.5:
            new_score_list.append(n)

    #図形の作成
    kekka = kekka = round(np.mean(new_score_list), 2) #-1〜1で感情を数値で表す。
    if kekka >= 0:
        figure = heartmake(1, 0, 0, kekka, 1,item.id)
    else:
        b = abs(kekka)
        figure = heartmake(0, 0, 1, b, 0,item.id)
    with io.BytesIO() as f:
        plt.savefig(f, format='jpg')#Bytes IOを利用して空ファイルに保存
        data = f.getvalue()
    base64_data = base64.b64encode(data).decode()#図形をbase64に変更


    #返信の作成。
    #語尾の設定。
    if kekka < 0:
      gobi = "ネガ"
    else:
      gobi = "ポジ"
    
    A = len(res_text)#文字数の抽出
    kotae = bunseki((A,kekka))#クラス分けを行う。(文字のクラス,感情のクラスに分かれる。)

    for p in pozi:
        result = p in res_text
        if result == True and kekka >= 0:
            comment ="{}って単語が入っているポジ！\n。ポジティブな単語はあなたも周りのみんなも笑顔にするポジ!".format(p)
            break
        else:
            comment = "これからも、陰ながら応援してるGobiよ!\n心の状態を-5から+5までで表すGobiよ！"
    h = np.random.randint(0,6)#ランダムで0から5までの整数を呼び出す。
    hazime = start[h]#startリストからランダムで呼び出す
    naka = dic[kotae]#kotaeに合わせてdicから呼び出す。

    #それぞれGobiをポジ、ネガに変換する。
    hazime = hazime.replace('Gobi', gobi)
    naka = naka.replace('Gobi', gobi)
    comment = comment.replace('Gobi', gobi)
    if "1" in item.id:
        serihu_list.append(hazime)
        serihu_list.append(naka)
        serihu_list.append(comment)
    else:
        serihu_list = "お疲れ様でした。\n心の状態を-5から+5まで下のバーで表してください。"
    serihu = hazime + "\n" + naka + "\n" + comment
    time =get_now()

    response.append({
        'kekka': kekka,
        'heart': base64_data,
        'serihu': serihu,
        })
    # you can store objects
    #名前を匿名化

    db = deta.Base(item.name)
    db.put({
        "key" : item.date + "/"+ item.count, 
        "id" : item.name,
        "submimt_time": time, 
        "age": item.old,
        "sex": item.sex,
        "kekka": kekka,
        "text": text_list,
        "text_kekka": scor_list,
        "submit_count": item.count,
        "kanjo": item.kanjo,
        "taisyo": item.taisyo,
        "serihu_List": serihu_list
        })
    return JSONResponse(response)

@app.post("/stress/")
async def create_item(item: Item_s):
    date = item.date
    count = item.count
    stress = item.stress
    deta = Deta("c0g0sd7g_Vb2R7o4AdhCZs8YAqudFHzcfxs4xihUh")
    name = item.name
    name_utf8 = name.encode("utf-8") #utf-8の文字コードのバイナリデータに変換
    name_int = int.from_bytes(name_utf8, "little") # バイナリデータをリトルエンディアンで整数化する
    name_id = str(name_int)
    db = deta.Base(name_id)

    key = date + "/" + count

    db = deta.Base(name_id)
    
    books = deta.Base("books")

    db.update({"stress": stress},key)

    return "任務完了"

@app.post("/digital/")
async def create_item(item: D_Item):
    response = []
    score_list = []
    magu_list = []
    scor_list = []
    text_list = []
    new_score_list = []
    serihu_list = []
    res_text = item.data
    characters = "\n"
    res_text = ''.join(x for x in res_text if x not in characters)#改行部分の削除
    kanjou_result = g_nlp(res_text)#感情分析を実施
    
    for i in range(len(kanjou_result['sentences'])):
        score_list.append(kanjou_result['sentences'][i]['sentiment'])
        scor_list.append(score_list[i]['score'])
        magu_list.append(score_list[i]['magnitude'])
        text_list.append(kanjou_result['sentences'][i]['text']['content'])
    for n in scor_list:
        if abs(n) >= 0.5:
           new_score_list.append(n)

    #図形の作成
    
    kekka = round(np.mean(new_score_list), 2) #-1〜1で感情を数値で表す。
    if kekka >= 0:
        figure = heartmake(1, 0, 0, kekka, 1,item.id)
    else:
        b = abs(kekka)
        figure = heartmake(0, 0, 1, b, 0,item.id)
    with io.BytesIO() as f:
        plt.savefig(f, format='jpg')#Bytes IOを利用して空ファイルに保存
        data = f.getvalue()
    base64_data = base64.b64encode(data).decode()#図形をbase64に変更


    #返信の作成。
    #語尾の設定。
    if kekka < 0:
      gobi = "ポジ"
    else:
      gobi = "ポジ"
    
    A = len(res_text)#文字数の抽出
    kotae = bunseki((A,kekka))#クラス分けを行う。(文字のクラス,感情のクラスに分かれる。)

    for p in pozi:
        result = p in res_text
        if result == True and kekka >= 0:
            comment ="{}って単語が入っているポジ！\n。ポジティブな単語はあなたも周りのみんなも笑顔にするポジ！\n心の状態を-5から+5までで表すGobiよ！".format(p)
            break
        else:
            comment = "これからも、陰ながら応援してるGobiよ!\n心の状態を-5から+5までで表すGobiよ！"
    h = np.random.randint(0,6)#ランダムで0から5までの整数を呼び出す。
    hazime = start[h]#startリストからランダムで呼び出す
    naka = dic[kotae]#kotaeに合わせてdicから呼び出す。

    #それぞれGobiをポジ、ネガに変換する。
    hazime = hazime.replace('Gobi', gobi)
    naka = naka.replace('Gobi', gobi)
    comment = comment.replace('Gobi', gobi)
    if "1" in item.id:
        serihu_list.append(hazime)
        serihu_list.append(naka)
        serihu_list.append(comment)
    
    else:
        serihu_list = "お疲れ様でした。\n心の状態を-5から+5まで下のバーで表してください。"
    time =get_now()
    serihu = hazime + "\n" + naka + "\n" + comment
    response.append({
        'kekka': kekka,
        'heart': base64_data,
        'serihu': serihu,
        })
    # you can store objects
    #名前を匿名化
    db = deta.Base(item.name)
    db.put({
        "key" : item.date + "/"+ item.count, 
        "id" : item.id,
        "submimt_time": time, 
        "age": item.old,
        "sex": item.sex,
        "kekka": kekka,
        "text": text_list,
        "text_kekka": scor_list,
        "submit_count": item.count,
        "kanjo": item.kanjo,
        "taisyo": item.taisyo,
        "serihu_List": serihu_list})
    return JSONResponse(response)