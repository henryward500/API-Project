USE brown_b1;

SELECT s.state as State, sum(cp.Population) as StatePopulation2016
from CountyPopulations as cp
inner join States as s on s.StateID = cp.StateID
Group by s.state;

SELECT  s.stateID, count(u.MemberID) as UserPop
FROM Users as u
INNER JOIN States as s
on u.stateID= s.stateID
GROUP BY s.stateID;

SELECT u.MemberID, u.UserLongitude, u.UserLatitude, u.UserCity, s.State
FROM Users as u
INNER JOIN States as s on s.stateID = u.stateID;

SELECT sum(cp.Population), cp.CountyName as percentage
From CountyPopulations as cp
Inner join States as s on s.StateID = cp.StateID
