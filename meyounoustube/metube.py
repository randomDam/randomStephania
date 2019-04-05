from requests import get
from bs4 import BeautifulSoup
import sys
import os
import re
from pytube import YouTube
from time import sleep
from random import randint
from skimage.filters import gaussian
from moviepy.editor import VideoFileClip, TextClip, CompositeVideoClip
import json
import string
import random
import glob

class Metube:

    def __init__(self, query):
        self.query = query

    def get_data_from_query(self):
        url = 'https://www.youtube.com/results?search_query='
        response = get(url + self.query)
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

    def download_vids(self):
        data = self.get_data_from_query()
        downloading = False
        folder = os.getcwd() + '/videos'
        for d in data:
            yt = YouTube('https://www.youtube.com' + d)
            print(f'download {yt.title}')
            stream = yt.streams.first()
            try :
                stream.download(folder)
            except(OSError):
                print("error")
                continue
            sleep(randint(8,15))
        
        downloading = True
        return(downloading)
    
    def get_words(self):
        url = 'https://api.datamuse.com/words?ml='
        response = get(url + self.query)
        if response.status_code != 200:
            print('no reponse')
        data = json.loads(response.content)
        word = data[randint(0,len(data))]
        return(word['word'])

    @staticmethod
    def blur(image):
        return gaussian(image.astype(float), sigma=15)

    @staticmethod
    def random_string(string_length=5):
        letters = string.ascii_lowercase
        return ''.join(random.choice(letters) for i in range(string_length))

    def process_vids(self):
        path = './videos/'
        files = []
        for r, d, f in os.walk(path):
            for file in f:
                if '.mp4' in file:
                    files.append(os.path.join(r, file))
        
        for f in range(len(files)):
            word = self.get_words()
            name = self.random_string()
            print(word, name)
            clip = VideoFileClip(files[f])
            txt_clip = TextClip( word, fontsize=70, color='black', font='Times-Roman')
            clip_blur = clip.fl_image( self.blur )
            result = CompositeVideoClip([clip_blur, txt_clip.set_position('center').set_duration(clip.duration)])
            result.write_videofile('./processvideos/' + name + '.mp4')
            print(f'process {name} finish')

def main(query):
    me = Metube(query)
    download = me.download_vids()
    if download is True:
        me.process_vids()
    print('all process finish')
    files = glob.glob('./videos/*')
    for f in files:
        os.remove(f)
    print('all videos removed')

if __name__ == "__main__":
    main(str(sys.argv[1]))

