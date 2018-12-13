use wang_j2;

SELECT s.State as State, sum(cp.Population) as StatePopulation2016
from CountyPopulations as cp
inner join States as s on s.StateID = cp.StateID
Group by s.StateID;

SELECT  s.State, count(u.MemberID) as UserPop
FROM Users as u
INNER JOIN States as s
on u.stateID= s.stateID
WHERE s.State in ('DC','MD','VA')
GROUP BY s.StateID;

SELECT u.MemberID, u.UserLongitude, u.UserLatitude, u.UserCity, s.State
FROM Users as u
INNER JOIN States as s on s.stateID = u.stateID
WHERE s.State in ('DC','MD','VA');

SELECT s.State, ROUND(SUM(cp.Population)/(SELECT SUM(cp.Population) FROM CountyPopulations AS cp)*100, 2) 
AS Percentage FROM CountyPopulations as cp
INNER JOIN States AS s ON s.StateID = cp.StateID
GROUP BY cp.StateID
ORDER BY cp.StateID;

SELECT s.State, ROUND(COUNT(u.MemberID)/(SELECT COUNT(u.MemberID) FROM Users AS u)*100, 2)
AS Percentage FROM Users AS u
INNER JOIN States AS s ON s.StateID = u.StateID
WHERE s.State in ('DC','MD','VA')
GROUP BY u.StateID
ORDER BY u.StateID;

SELECT s.State, actual.percentage AS ActualPct, api.percentage AS MeetUpPct FROM States as s
INNER JOIN (SELECT s.StateID, ROUND(SUM(cp.Population)/(SELECT SUM(cp.Population) FROM CountyPopulations AS cp)*100, 2) 
AS Percentage FROM CountyPopulations as cp
INNER JOIN States AS s ON s.StateID = cp.StateID
GROUP BY cp.StateID
ORDER BY cp.StateID)
AS actual ON s.StateID = actual.StateID
INNER JOIN (SELECT s.StateID, ROUND(COUNT(u.MemberID)/(SELECT COUNT(u.MemberID) FROM Users AS u)*100, 2)
AS Percentage FROM Users AS u
INNER JOIN States AS s ON s.StateID = u.StateID
GROUP BY u.StateID
ORDER BY u.StateID) 
AS api ON s.StateID = api.StateID
ORDER BY s.StateID;
