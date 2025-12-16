drop view if exists dbo.vSimpleFlights;
go

create or alter view dbo.vSimpleFlights
as
select f.FlightNumber,a.Name as Airline, d.Name as Destination,f.Price from Flights f
join Airlines a on f.AirlineID = a.AirlineID
join Airports ap on f.FromAirportID = ap.AirportID
join Destinations d on ap.DestinationID = d.DestinationID;
go
