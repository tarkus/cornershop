#!/usr/bin/env python
#-*- coding: utf-8 -*-

import random
import time
from datetime import datetime
from datetime import date
from datetime import timedelta

total_users = len(open('Users.sql').readlines())
total_media = len(open('Media.sql').readlines())
total_entries = 1000

def random_user_id():
    return random.randint(1, total_users)

def random_media_id():
    return random.randint(1, total_media)


def main():
    sql = ["TRUNCATE loan_histories;"]
    now = datetime.now()
    timestamp = time.strftime("%Y-%m-%d %H:%M:%S")
    rent_effective = ""
    for i in xrange(0, total_entries):
        rent_start = now - timedelta(seconds=random.randint(2700, 86400 * 10))
        rent_estimated = (rent_start + timedelta(days=10))
        rent_effective = random.choice(['NULL', "'" + (rent_start + timedelta(seconds=random.randint(86400 * 4, 86400 * 15))).strftime('%Y-%m-%d %H:%M:%S') + "'"])
        sql.append("INSERT INTO loan_histories (`user_id`, `media_id`, `rent_start`, `rent_estimated`, `rent_effective`, `created_at`, `updated_at`) VALUES ('%s', '%s', '%s', '%s', %s, '%s', '%s');" % (random_user_id(), random_media_id(), rent_start.strftime('%Y-%m-%d %H:%M:%S'), rent_estimated.strftime('%Y-%m-%d %H:%M:%S'), rent_effective, timestamp, timestamp))

    content = "\n".join(sql)
    open("LoanHistories.sql", "w").write(content)
    return content

if __name__ == "__main__":
    main()
