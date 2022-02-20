import streamlit as st
from PIL import Image
import io 
import numpy as np
import base64
from io import BytesIO
import requests
import json
import cv2
import ast
st.title("Hello!")


uploaded_file = st.file_uploader('Choose a image file')

def pil_to_base64(img, format="jpeg"):
    buffer = BytesIO()
    img.save(buffer, format)
    img_str = base64.b64encode(buffer.getvalue()).decode("ascii")

    return img_str

if uploaded_file is not None:
    image = Image.open(uploaded_file)
    img_array = np.array(image)
    st.image(
        image, caption='upload images',
        use_column_width=True
    )
    img_base64 = pil_to_base64(image, format="png")
    data = {
            'id': "1",
            'data': img_base64
        }
    
    url = 'https://inpca0.deta.dev/items/'
    #url = 'http://127.0.0.1:8000/items/'
    res = requests.post(
        url,
        data=json.dumps(data)
    )
    if res.status_code == 200:
        st.success('完了')
   # res_text = res["responses"][0]["textAnnotations"][0]["description"]
    st.write(res.text)
    list = res.text
    dic = ast.literal_eval(list)
    img_base64 = dic[0]['heart']
    heart_img =img_base64.encode()
    #バイナリデータ <- base64でエンコードされたデータ  
    img_binary = base64.b64decode(heart_img)
    png=np.frombuffer(img_binary,dtype=np.uint8)
# cv2.IMREAD_UNCHANGED
#cv2.COLOR_BGR2RGB
    #raw image <- jpg
    img = cv2.imdecode(png,cv2.IMREAD_UNCHANGED )
    im_swap = img.copy()
    im_swap[:, :, 0], im_swap[:, :, 2] = img[:, :, 2], img[:, :, 0]

    pil_img_swap = Image.fromarray(im_swap)
    st.image(
        pil_img_swap, caption='heart images',
        use_column_width=True
    )
    #st.write(img_base64)
