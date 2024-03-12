select * from crime_scene_report where city='SQL City' and date='20180115' and type='murder';
'Security footage shows that there were 2 witnesses. The first witness lives at the last house on "Northwestern Dr". The second witness, named Annabel, lives somewhere on "Franklin Ave".'

id	name	license_id	address_number	address_street_name	ssn
14887	Morty Schapiro	118009	4919	Northwestern Dr	111564949
16371	Annabel Miller	490173	103	Franklin Ave	318771143


select * from person where address_street_name='Northwestern Dr'

select * from interview 
left join person on (person.id = interview.person_id)
where 


Morty Schapiro:
I heard a gunshot and then saw a man run out. He had a "Get Fit Now Gym" bag. The membership number on the bag started with "48Z". Only gold members have those bags. The man got into a car with a plate that included "H42W".

Annabel Miller:
saw the murder happen, and I recognized the killer from my gym when I was working out last week on January the 9th.


select * from get_fit_now_check_in where check_in_date='20180109'

select * from get_fit_now_member 
left join get_fit_now_check_in on (get_fit_now_check_in.membership_id = get_fit_now_member.id)
where get_fit_now_member.membership_status='gold'and
	  get_fit_now_check_in.check_in_date='20180109' and
      get_fit_now_member.id like '48Z%'

membros gold:
   28819 Joe Germuska
   67318 Jeremy Bowers 

select * from person a 
left join drivers_license b on (a.license_id = b.id)
where a.id in ('28819', '67318')


select * from interview where person_id='67318'

i was hired by a woman with a lot of money. I don't know her name but I know she's around 5'5" (65") or 5'7" (67"). She has red hair and she drives a Tesla Model S. I know that she attended the SQL Symphony Concert 3 times in December 2017.



select * from drivers_license a
left join person b on (b.license_id = a.id)
left join facebook_event_checkin c on (b.id = c.person_id)
where car_make='Tesla' 
and car_model='Model S' 
and hair_color='red' 
and height>=65 
and height<=67

select b.name from drivers_license a
left join person b on (b.license_id = a.id)
left join facebook_event_checkin c on (b.id = c.person_id)
where car_make='Tesla'
and car_model='Model S' 
and hair_color='red' 
and height>=65 
and height<=67
group by event_name = 'SQL Symphony Concert' having count(event_name) >= 3
