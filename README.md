# fitbit-intraday
Script that uses the fitbitScraper package's get_intraday_data function to get all of the data into one chart for multiple days

intraday(Startdate, EndDate, data, file.name, email, password)

StartDate - "YYYY-MM-DD" (First Day of data you want)

EndDate - "YYY-MM-DD" (Last Day of data you want)

data - "example" (What data you wish to be returned. Options include "steps", "distance", "floors", "active-minutes", "calories-burned", "heart-rate")

file.name - "example.csv" (name of the .csv output file you want)

email - "example@example.com" (fitbit.com account email)

password - "example" (fitbit.com account password)
