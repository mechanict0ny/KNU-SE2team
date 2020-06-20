from selenium import webdriver
import re
import requests
from bs4 import BeautifulSoup

import firebase_admin
from firebase_admin import credentials
from firebase_admin import db


i=0
db_url='https://keynopia-3aeeb.firebaseio.com/notice/vwb9UeeeQD8xzLo7d8EI'
cred = credentials.Certificate("mykey.json")
firebase_admin.initialize_app(cred, {'databaseURL':db_url})
ref=db.reference()
base_url='http://www.knu.ac.kr/wbbs/wbbs/bbs/btin/list.action?bbs_cde=1&btin.page={}'
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
        ref=db.reference('공지사항/'+str(i))
        i=i+1
        title = link.select_one('td > a')
        date = link.select_one('td.date')
        ref.delete()
        ref.update({'제목': title.text.strip()})
        ref.update({'날짜': date.text.strip()})
        ref.update({'url': url.strip()})
        print(num.text)
        print(title.text)
        print(url)
        print(date.text)
