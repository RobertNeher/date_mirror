import datetime

if __name__ == "__main__":
    today_year = datetime.datetime.today().strftime("%y")
    EQULIBRIUM = datetime.datetime.strptime("21.06." + today_year, "%d.%m.%y")
    day_diff = datetime.datetime.today() - EQULIBRIUM
    mirror_day = EQULIBRIUM - datetime.timedelta(days=day_diff.days)
    print("Todays date is equal to %s" % datetime.datetime.strftime(mirror_day, "%d. %B %Y"))
