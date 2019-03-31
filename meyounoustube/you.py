from requests import get
from bs4 import BeautifulSoup
import sys
import os
import re
from pytube import YouTube
from time import sleep
from random import randint

def get_data_from_query(query):
    url = 'https://www.youtube.com/results?search_query='
    response = get(url + query)
    if response.status_code != 200:
        print('no reponse')
    soup = BeautifulSoup(response.content, 'html.parser')
    watch = []
    for vid in soup.find_all('a'):
        link = vid['href']
        if link is not None:
            link_match = re.findall("^\/watch\?v=[\s\S]{11}", link)
            if len(link_match) != 0:
                watch.append(link_match[0])
    result = list(dict.fromkeys(watch))
    return(result)

def download_vids(data):
    downloading = False
    folder = os.getcwd() + '/videos'
    for d in data:
        yt = YouTube('https://www.youtube.com' + d)
        print(f'download {yt.title}')
        stream = yt.streams.first()
        try :
            stream.download(folder)
        except HTTPError as err:
            print(f"error {err}")
            continue
        sleep(randint(8,15))
    
    downloading = True
    return(downloading)

def main(query):
    data_query = get_data_from_query(query)
    videos = download_vids(data_query)
    print(videos)

if __name__ == "__main__":
    main(str(sys.argv[1]))

