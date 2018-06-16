srand()
Event.delete_all

today = Date.current
dates = [today, today + 2.days, today + 8.days]
titles = ['Meet with Leia', 'Dinner with Darth Vader', 'Gym session with Luke']

10.times do
  start_on = dates.sample
  end_on = start_on + rand(5).days
  Event.create(title: titles.sample, start_on: start_on, end_on: end_on)
end
