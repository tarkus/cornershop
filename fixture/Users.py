#!/usr/bin/env python
#-*- coding: utf-8 -*-

from random import choice
import time

sample_file = 'sample/user'

Users = {}

def random_team():
    teams = ['KFC', 'PizzaHut', 'Mcdonalds']
    return choice(teams)

def random_position():
    positions = ['Arms warrior', 'Resto shaman', 'MMS hunter', 'Holy paladin', 'Disc priest']
    return choice(positions)

def random_phone():
    numbers = xrange(18602100000, 18602199999)
    return choice(numbers)

def random_nationality():
    zones = ["Alterac Mountains", "Alterac Valley", "Arathi Highlands", "Arathi Basin", "Ashenvale", "Aszhara (Azshara)", "Azeroth", "Azuremyst Isle", "Badlands", "The Barrens", "Blade's Edge Mountains", "The Blasted Lands", "Bloodmyst Isle", "Borean Tundra", "Burning Steppes", "Cleft of Shadow", "Crystalsong Forest", "Dalaran", "Darkshore", "Darnassus", "Deadwind Pass", "Desolace", "Dragonblight", "Dun Morogh", "Durotar", "Duskwood", "Dustwallow Marsh", "Eastern Kingdoms", "Eastern Plaguelands", "Elwynn Forest", "Eversong Woods", "The Exodar", "Eye of the Storm", "Felwood", "Feralas", "Ghostlands", "Grizzly Hills", "Hellfire Peninsula", "Hillsbrad Foothills", "The Hinterlands", "Howling Fjord", "Hrothgar's Landing", "Icecrown", "Isle of Conquest", "Isle of Quel'Danas", "Ironforge", "Kalimdor", "Lake Wintergrasp", "Loch Modan", "Moonglade", "Mulgore", "Nagrand", "Netherstorm", "Northrend", "Orgrimmar", "Outland", "Redridge Mountains", "Scarlet Enclave", "Searing Gorge", "Shadowmoon Valley", "Shattrath City", "Sholazar Basin", "Silithus", "Silvermoon City", "Silverpine Forest", "Stonetalon Mountains", "Strand of the Ancients", "The Storm Peaks", "Stormwind", "Strand of the Ancients", "Stranglethorn Vale", "Swamp of Sorrows", "Tanaris", "Teldrassil", "Terokkar Forest", "Thousand Needles", "Thunder Bluff", "Tirisfal", "Underbelly", "Undercity", "Un'Goro Crater", "Universe", "Warsong Gulch", "Western Plaguelands", "Westfall", "Wetlands", "Winterspring", "Zangarmarsh", "Zul'Drak"]
    return choice(zones).replace("'", "\\'")

def main():
    sql = ["TRUNCATE users;"]
    now = time.strftime('%Y-%m-%d %H:%M:%S')
    for line in open(sample_file).readlines():
        fullname = line.strip()
        parts = fullname.split(" ")
        if len(parts) < 2:
            continue
        surname = parts.pop()
        if surname in ['Room', 'Meeting', 'team']:
            continue
        Users[fullname] = {
            'surname': surname,
            'name': " ".join(parts),
            'team': random_team(),
            'position': random_position(),
            'nationality': random_nationality(),
            'phone': random_phone(),
        }


    for i in Users:
        User = Users[i]
        sql.append("INSERT INTO users (`name`, `surname`, `team`, `position`, `phone`, `nationality`, `rental_count`, `overdue_count`, `created_at`, `updated_at`) VALUES ('%s', '%s', '%s', '%s', '%s', '%s', 0, 0, '%s', '%s');" % (User['name'], User['surname'], User['team'], User['position'], User['phone'], User['nationality'], now, now))

    content = "\n".join(sql)
    open("Users.sql", "w").write(content)
    return content

if __name__ == "__main__":
    main()
