#!/usr/bin/env python
#-*- coding: utf-8 -*-

import re
import time
from BeautifulSoup import BeautifulSoup, SoupStrainer
import HTMLParser
from random import choice


h = HTMLParser.HTMLParser()

def random_language():
    return choice(['en', 'de', 'cn', 'ru'])

def random_producer():
    return choice(["Anchor Bayd", "Capitol Filmsd", "DreamWorks SKGd", "Galaxy Quest", "Catch Me If You Can", "The Ringd", "DreamWorks Animationd", "Madagascar", "Kung Fu Pandad", "20th Century Foxd", "Fantastic Voyage", "Star Wars", "X-Men", "Die Hard", "Alien", "Revenge of the Nerds", "Planet of the Apes", "Home Alone", "Unlawful Entry", "Night at the Museum", "Predator", "Speed", "Independence Day", "Avatar", "The Simpsons", "20th Century Fox Animationd", "Anastasiad", "Blue Sky Studiosd", "Fox Searchlight Picturesd", "28 Days Later", "Sideways", "The Full Monty", "One Hour Photo", "Whip It", "Little Miss Sunshine", "Black Swan", "Shamed", "Fox Atomicd", "Metro-Goldwyn-Mayer Century City, California, USAd", "Gone with the Wind", "Ben-Hur", "Flipper", "The Dirty Dozen", "2001: A Space Odyssey", "Poltergeist", "Moonstruck", "Thelma & Louise", "Hannibald", "Metro-Goldwyn-Mayer Animationd", "United Artists Entertainment, LLCd", "It's a Mad, Mad, Mad, Mad World", "A Hard Day's Night", "Help!", "Chitty Chitty Bang Bang", "Rocky", "Apocalypse Now", "The Pink Panther", "Raging Bull"]).replace("'", "\\'")

def get_movies():
    return []

def get_tv_shows():
    media = []
    html = open('sample/tv_shows.html').read()
    title = re.findall('<a href="/title/[^>]+>([^<]+)</a>', html)
    genre = re.findall('<a href="/genre/[^>]+>([^<]+)</a>', html)
    year = re.findall('<span class="year_type">\((\d+) TV Series\)</span>', html)
    artist = re.findall('Dir: <a href="/name/[^>]+">([^>]+)</a>', html)
    cast_1 = re.findall('With: (?:<a href="/name/[^>]+">([^>]+)</a>)+', html)
    cast_2 = re.findall('With: (?:<a href="/name/[^>]+">([^>]+)</a>, )+', html)

    for i in range(0, len(title) - 1):
        item = {}
        item['title'] = title[i]
        item['type'] = 'tv shows'
        item['genre'] = genre[i]
        item['year'] = year[i]
        item['cast'] = [cast_1[i]]
        item['location'] = "5 - " + str(i + 1)
        try:
            item['cast'].append(cast_2[i])
        except IndexError:
            pass

        try:
            item['artist'] = artist[i]
        except IndexError:
            item['artist'] = cast_1[i]

        media.append(item)

    return media

def get_music():
    return []

def main():
    sql = ["TRUNCATE media;"]
    media = []
    now = time.strftime('%Y-%m-%d %H:%M:%S')
    media += get_movies()
    media += get_tv_shows()
    media += get_music()

    for i in range(0, len(media)):
        item = media[i]
        sql.append("INSERT INTO media (`title`, `media_type`, `year`, `language`, `producer`, `artist`, `cast`, `location`, `availability`, `created_at`, `updated_at`) VALUES \
                ('%s', '%s', '%s', '%s', '%s', '%s', '%s', '%s', '%s', '%s', '%s');" % (item['title'].encode('utf-8'), item['type'], item['year'], random_language(), random_producer(), item['artist'], ",".join(item['cast']), item['location'], "1", now, now))

    content = "\n".join(sql)
    open("Media.sql", "w").write(content)
    return content

if __name__ == "__main__":
    main()
