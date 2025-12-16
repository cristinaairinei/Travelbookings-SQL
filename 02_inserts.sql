insert into Users(FullName, Email) values
('Ana Pop','ana@mail.com'),
('Ion Ionescu','ion@mail.com'),
('Maria Dinu','maria@mail.com');

insert into Destinations(Name, Country) values
('Rome','Italy'),
('Paris','France'),
('London','United Kingdom');

insert into Airports(DestinationID, Code, Name) values
(1,'FCO','Fiumicino'),
(2,'CDG','Charles de Gaulle'),
(3,'LHR','Heathrow');

insert into Airlines(Name) values
('ITA Airways'),
('Air France'),
('British Airways');

insert into Flights(AirlineID, FromAirportID, ToAirportID, FlightNumber, DepartTime, ArriveTime, Price) values
(1,1,2,'AZ123','2025-10-20 09:00','2025-10-20 11:00',120.00),
(2,2,3,'AF456','2025-10-22 10:00','2025-10-22 11:30',150.00),
(3,3,1,'BA789','2025-10-25 15:00','2025-10-25 17:30',180.00);

insert into Hotels(DestinationID, Name, Stars) values
(1,'Hotel Roma Centro',4),
(2,'Paris Boutique',3),
(3,'London Royal Inn',5);

insert into Rooms(HotelID, RoomType, PricePerNight) values
(1,'Double',120.00),
(1,'Suite',210.00),
(2,'Single',95.00),
(3,'Deluxe',250.00);

insert into Attractions(DestinationID, Name, Type) values
(1,'Colosseum','Historic'),
(1,'Trevi Fountain','Landmark'),
(2,'Eiffel Tower','Landmark'),
(3,'British Museum','Museum');

insert into Bookings(UserID, FlightID, Seat, PricePaid) values
(1,1,'12A',130.00),
(2,2,'7C',145.00),
(3,3,'10B',175.00);

insert into Favorites(UserID, AttractionID) values
(1,1),
(1,2),
(2,3),
(3,4);

insert into Payments(UserID, Amount, PaidAt) values
(2, 50, '2025-11-20 14:30'),
(3,200.20, '2025-03-20 15:00'),
(4,130.40,'2025-10-11 14:30');
go

insert into Version values (0);
go

