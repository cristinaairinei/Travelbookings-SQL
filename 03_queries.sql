select * from Rooms;
update Rooms
set PricePerNight = PricePerNight+ 10
where PricePerNight >= 200;
select * from Rooms;

select * from Rooms;
update Rooms
set PricePerNight = PricePerNight* 2
where PricePerNight between 100 and 200
  or RoomType not like '%Suite%';


select * from Rooms;
delete from Rooms
where RoomType = 'Single';
select * from Rooms;

select * from Attractions;
delete from Attractions
where
(
     AttractionID in (1, 2, 3, 4)
     and Type not like '%Landmark%'
     and DestinationID <> 2
     and DestinationID <= 3
)
or
(
    Type is null
);
select * from Attractions;


select Name as NameList from Hotels
union
select Name from Attractions;

select Name as RoomConfig from Hotels
union
select RoomType as RoomConfig from Rooms;


select DestinationID as id from Hotels
where Stars = 5
intersect
select DestinationID as id from Attractions
where Type like '%Landmark%';


select Name from Attractions
where DestinationID = 1
except
select Name from Attractions
where Type = 'Landmark';

select distinct d.Country
from Destinations d
inner join Attractions a on d.DestinationID = a.DestinationID
where a.Type = 'Landmark';


select top 2 Name, Stars
from Hotels
where HotelID>=2
order by Stars asc;

select FullName
from Users
order by FullName asc;

select Price, FlightNumber
from Flights
order by 1 desc;

--INNER JOIN
select f.FlightNumber, a.Name as Airline, c.Code as FromAirport from Flights f
inner join Airlines a on f.AirlineID = a.AirlineID
inner join Airports c on f.FromAirportID = c.AirportID;

--LEFT JOIN
select ap.Code, f.FlightNumber from Airports ap
left join Flights f on ap.AirportID = f.FromAirportID;

--RIGHT JOIN
select r.RoomType as Room , h.Name as Hotel from Rooms r
right join Hotels h on r.HotelID = h.HotelID;


--FULL JOIN
select d.Name as Destination, h.Name as Hotel from Destinations d
full join Hotels h on d.DestinationID = h.DestinationID;

select Name
from Hotels
where HotelID in (select HotelID from Rooms where PricePerNight >200);

select AirlineID
from Airlines
where AirlineID in(select AirlineID from Flights where ToAirportID>2);


select d.Name
from Destinations d
where exists (
    select * from Attractions a
    where a.DestinationID = d.DestinationID);

select a.Name, x.AvgPrice
from (
    select AirlineID, avg(Price) as AvgPrice
    from Flights
    where ToAirportID > 2
    group by AirlineID) x
join Airlines a on a.AirlineID = x.AirlineID;


select h.Name, count(r.RoomID) as TotalRooms
from Hotels h
left join Rooms r on h.HotelID = r.HotelID
group by h.Name;


select h.Name, avg(r.PricePerNight) as AvgPrice
from Hotels h
inner join Rooms r on r.HotelID = h.HotelID
group by h.Name
having avg(r.PricePerNight) > 150;


select h.Name, avg(r.PricePerNight) as AvgPrice
from Hotels h
inner join Rooms r on r.HotelID = h.HotelID
group by h.Name
having avg(r.PricePerNight) > (
    select avg(PricePerNight) from Rooms
);


select a.FlightId as Flight, b.Name as Airport , c.Name as Country from Flights a
    inner join Airports b on a.FromAirportID = b.AirportID
    inner join Destinations c on b.DestinationID = c.DestinationID
    where c. Country='france'


select a.FlightNumber as Flight , b.Name as Airline from Flights a
inner join Airlines b on a.AirlineID = b.AirlineID
where a.Price>150


select H.Name as Hotel, count(r.RoomId) as TotalRooms
from Hotels H inner join Rooms r  on H.HotelID = r.HotelID
group by H.Name

