Admin.add 'OBK', 'Admin', 'admin@obk.org.au', '@dm1n08k'

v1 = Volunteer.add first_name: 'Anna', last_name: 'Konda', email: 'anna.konda@hotmail.com', mobile_number: '0451 601 804',
                   dob: Date.parse('1980-01-01'), password: 'asdfasdf', gender: 'F', wwccn: '123456'
v2 = Volunteer.add first_name: 'Big', last_name: 'Python', email: 'big.python@hotmail.com', mobile_number: '0403 356 164',
                   dob: Date.parse('1987-07-07'), password: 'asdfasdf', gender: 'O', wwccn: '987654'

e1 = Event.find_or_create_by! title: 'Challah party', description: 'Let''s eat bread, people!',
                             start_date: (Time.zone.now + 10.days).change(hour: 12, min: 0),
                             end_date: (Time.zone.now + 10.days).change(hour: 14, min: 0)

e2 = Event.find_or_create_by! title: 'Cooking cookies', description: 'I''m the Cookie Monster!',
                              start_date: (Time.zone.now + 12.days).change(hour: 9, min: 0),
                              end_date: (Time.zone.now + 12.days).change(hour: 16, min: 0)

e3 = Event.find_or_create_by! title: 'Feijoada chillin', description: 'Mr. Beans is invited',
                              start_date: (Time.zone.now + 20.days).change(hour: 8, min: 0),
                              end_date: (Time.zone.now + 20.days).change(hour: 12, min: 0)

e4 = Event.find_or_create_by! title: 'Something cool', description: 'Kool Aid for everybody!',
                             start_date: (Time.zone.now + 15.days).change(hour: 8, min: 0),
                             end_date: (Time.zone.now + 20.days).change(hour: 8, min: 0)
e4.save(validate: false) if e4.new_record?

v1.events << e3

e1.volunteers << v1
e1.volunteers << v2
