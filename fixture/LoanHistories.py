#!/usr/bin/env python
#-*- coding: utf-8 -*-

import random
import time
from datetime import datetime
from datetime import date
from datetime import timedelta

total_users = len(open('Users.sql').readlines()) - 1
total_media = len(open('Media.sql').readlines()) - 1
total_entries = 1000

media = {}
loan_histories = {}

def random_user_id():
    return random.randint(1, total_users)

def random_media_id():
    return random.randint(1, total_media)

def build_loan_history(media_id):
    now = datetime.now()
    max_entries = 10
    counter = 0
    rent_start = None
    while counter < max_entries:
        if rent_start is None:
            rent_start = now - timedelta(seconds=random.randint(80000 * 20, 80000 * 60))
        rent_estimated = (rent_start + timedelta(days=7))
        return_date = (rent_start + timedelta(seconds=random.randint(80000 * 4, 80000 * 12)))

        if return_date > now:
            return_date = (now - timedelta(seconds=random.randint(12313, 20000)))

        rent_effective = "'" + return_date.strftime("%Y-%m-%d %H:%M:%S") + "'"

        if media_id not in loan_histories:
            loan_histories[media_id] = []

        loan_histories[media_id].append({"start": rent_start, "estimated": rent_estimated, "effective": rent_effective, "effective_date": return_date})

        rent_start = return_date + timedelta(seconds=random.randint(32313, 70000))
        counter += 1

    rent_effective = random.choice(['NULL', rent_effective])

    if rent_effective == 'NULL':
        media[media_id] = "Not Available"
        loan_histories[media_id][-1]["effective"] = 'NULL'


def main():
    sql = ["TRUNCATE loan_histories;"]
    now = datetime.now()
    timestamp = time.strftime("%Y-%m-%d %H:%M:%S")
    rent_effective = ""
    user_rental_count = {}
    user_overdue_count = {}
    for i in xrange(0, total_media):
        media_id = i + 1
        if media_id in media and media[media_id] == 'Not Available':
            continue
        build_loan_history(media_id)

        for i in range(0, len(loan_histories[media_id])):
            entry = loan_histories[media_id][i]
            user_id = random_user_id()
            if user_id not in user_rental_count:
                user_rental_count[user_id] = 0
            user_rental_count[user_id] += 1

            if user_id not in user_overdue_count:
                user_overdue_count[user_id] = 0

            if entry["effective"] == "NULL":
                if now > entry["estimated"]:
                    user_overdue_count[user_id] += 1
                sql.append("UPDATE media SET availability = 0 WHERE id = '%d';" % media_id);
            else:
                if entry["effective_date"] > entry["estimated"]:
                    user_overdue_count[user_id] += 1

            sql.append("INSERT INTO loan_histories (`user_id`, `medium_id`, `rent_start`, `rent_estimated`, `rent_effective`, `created_at`, `updated_at`) VALUES ('%s', '%s', '%s', '%s', %s, '%s', '%s');" % (user_id, media_id, entry['start'].strftime('%Y-%m-%d %H:%M:%S'), entry['estimated'].strftime('%Y-%m-%d %H:%M:%S'), entry['effective'], timestamp, timestamp))

    for user_id in user_rental_count:
        sql.append("UPDATE users SET rental_count = '%d' WHERE id = '%d';" % (user_rental_count[user_id], user_id))

    for user_id in user_overdue_count:
        sql.append("UPDATE users SET overdue_count = '%d' WHERE id = '%d';" % (user_overdue_count[user_id], user_id))

    content = "\n".join(sql)
    print content
    open("LoanHistories.sql", "w").write(content)
    return content

if __name__ == "__main__":
    main()
