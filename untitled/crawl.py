from selenium import webdriver
import re
import requests
from bs4 import BeautifulSoup

import firebase_admin
from firebase_admin import credentials
from firebase_admin import firestore

import time

cred = credentials.Certificate('test.json')
firebase_admin.initialize_app(cred)
db = firestore.client()
base_url='http://www.knu.ac.kr/wbbs/wbbs/bbs/btin/list.action?bbs_cde=1&btin.page={}'
#users_ref = db.collection(u'keywords')#.document(u'등록금').collection(u'목록')
#docs = users_ref.stream()



def func1():
    stuNums = db.collection('keywords').stream()
    for stuNum in stuNums:
        print(stuNum.id)
        users_ref = db.collection(u'keywords').document(stuNum.id).collection('키워드')
        docs = users_ref.stream()
        for doc in docs:
            i = 10
            print(doc.id)
            for n in range(9):
                request = requests.get(base_url.format(n+1))
                html = request.text
                soup = BeautifulSoup(html, 'html.parser')
                links = soup.select('tbody > tr')
                for link in links:
                    num = link.select_one('td.num')
                    if (num.text == '공지'):
                        continue
                    url = 'http://knu.ac.kr' + link.select_one('td > a')['href']
                    title = link.select_one('td > a')
                    date = link.select_one('td.date')
                    if doc.id in title.text:
                        a = users_ref.document(doc.id).collection(u'목록').document('공지 ' + str(i))
                        a.set({
                            '제목': title.text.strip(),
                            'date': date.text.strip(),
                            'url': url.strip()
                        })
                        i = i + 1
        print('--')

while True:
    func1()



    #print(u'{} => {}'.format(doc.id, doc.to_dict()))
