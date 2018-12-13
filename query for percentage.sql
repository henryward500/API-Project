use brown_b1;

SELECT s.State, ROUND(SUM(cp.Population)/(SELECT SUM(cp.Population) FROM CountyPopulations AS cp)*100, 2) 
AS Percentage FROM CountyPopulations as cp
INNER JOIN States AS s ON s.StateID = cp.StateID
GROUP BY cp.StateID
ORDER BY cp.StateID;

SELECT s.State, ROUND(COUNT(u.MemberID)/(SELECT COUNT(u.MemberID) FROM Users AS u)*100, 2)
AS Percentage FROM Users AS u
INNER JOIN States AS s ON s.StateID = u.StateID
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

