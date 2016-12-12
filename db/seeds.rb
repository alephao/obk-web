adm = Admin.add 'OBK', 'Admin', 'admin@obk.org.au', '@dm1n08k'

v1 = Volunteer.add 'Anna', 'Konda', 'anna.konda@hotmail.com', Date.parse('1980-01-01'), 'asdfasdf'
v2 = Volunteer.add 'Big', 'Python', 'big.python@hotmail.com', Date.parse('1987-07-07'), 'asdfasdf'

e1 = Event.find_or_create_by! title: 'Challah party', description: 'Let''s eat bread, people!', start: DateTime.new(2016,12,25,9), end: DateTime.new(2016,12,25,16)
e2 = Event.find_or_create_by! title: 'Cooking cookies', description: 'I''m the Cookie Monster!', start: DateTime.new(2016,12,26,9), end: DateTime.new(2016,12,26,16)
e3 = Event.find_or_create_by! title: 'Feijoada chillin', description: 'Mr. Beans is invited', start: DateTime.new(2016,12,27,9), end: DateTime.new(2016,12,27,16)
e4 = Event.find_or_create_by! title: 'Something cool', description: 'Kool Aid for everybody!', start: DateTime.new(2016,12,28,9), end: DateTime.new(2016,12,28,16)

v1.events << e3

e1.volunteers << v1
e1.volunteers << v2
