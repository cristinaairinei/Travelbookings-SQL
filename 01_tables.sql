--users
create table Users (
  UserID int identity primary key,
  FullName nvarchar(150) not null,
  Email nvarchar(200) not null unique,
  CreatedAt datetime2 default sysdatetime()
);


--destinations
create table Destinations (
  DestinationID int identity primary key,
  Name nvarchar(150) not null unique,
  Country nvarchar(100) not null
);



--airports
create table Airports (
  AirportID int identity primary key,
  DestinationID int not null,
  Code char(3) not null unique,
  Name nvarchar(200) not null,
  foreign key (DestinationID) references Destinations(DestinationID)
);



--airlines
create table Airlines (
  AirlineID int identity primary key,
  Name nvarchar(150) not null unique
);



--flights
create table Flights (
  FlightID int identity primary key,
  AirlineID int not null,
  FromAirportID int not null,
  ToAirportID int not null,
  FlightNumber nvarchar(20) not null unique,
  DepartTime datetime2 not null,
  ArriveTime datetime2 not null,
  Price decimal(10,2) not null,
  foreign key (AirlineID)     references Airlines(AirlineID),
  foreign key (FromAirportID) references Airports(AirportID),
  foreign key (ToAirportID)   references Airports(AirportID)
);


--hotels
create table Hotels (
  HotelID int identity primary key,
  DestinationID int not null,
  Name nvarchar(200) not null unique,
  Stars int check (Stars between 1 and 5),
  foreign key (DestinationID) references Destinations(DestinationID)
);


--rooms
create table Rooms (
  RoomID int identity primary key,
  HotelID int not null,
  RoomType nvarchar(100) not null,
  PricePerNight decimal(10,2) not null,
  foreign key (HotelID) references Hotels(HotelID)
);


--attractions
create table Attractions (
  AttractionID int identity primary key,
  DestinationID int not null,
  Name nvarchar(200) not null,
  Type nvarchar(100),
  foreign key (DestinationID) references Destinations(DestinationID)
);

--bookings
create table Bookings (
  UserID int not null,
  FlightID int not null,
  Seat nvarchar(10),
  PricePaid decimal(10,2) not null,
  primary key (UserID, FlightID),
  foreign key (UserID)  references Users(UserID),
  foreign key (FlightID) references Flights(FlightID)
);

--favs
create table Favorites (
  UserID int not null,
  AttractionID int not null,
  AddedAt datetime2 default sysdatetime(),
  primary key (UserID, AttractionID),
  foreign key (UserID)       references Users(UserID),    --n-n
  foreign key (AttractionID) references Attractions(AttractionID) on delete cascade
);

--payments
create table Payments(
    PaymentID int identity primary key,
    UserID int,
    Amount decimal(10,2),
    PaidAt datetime2 default sysdatetime(),
    foreign key (UserID) references Users(UserID) --n-1 with Users
);
go

create table Version (
    versionno int
);

insert into Version values (0);
go
