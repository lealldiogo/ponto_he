Date::DATE_FORMATS[:default] = '%d/%m/%Y'

# if you want to change the format of Time display then add the line below
Time::DATE_FORMATS[:default]= '%m/%d/%Y %H:%M:%S'

# if you want to change the DB date format.
# Time::DATE_FORMATS[:db]= '%m/%d/%Y %H:%M:%S'

# Time::DATE_FORMATS[:month_and_year] = '%B %Y'
# Time::DATE_FORMATS[:short_ordinal] = lambda { |time| time.strftime("%B #{time.day.ordinalize}") }
