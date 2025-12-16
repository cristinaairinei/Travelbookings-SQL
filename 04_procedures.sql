create or alter procedure do_proc_1
as
begin
    alter table hotels
    add description nvarchar(300);
    print 'version 1 done';
end
go

create or alter procedure undo_proc_1
as
begin
    alter table hotels
    drop column description;
    print 'undo 1 done';
end
go

create or alter procedure do_proc_2
as
begin
    alter table hotels
    add constraint df_stars default 3 for stars; --automat
    print 'version 2 done';
end
go

create or alter procedure undo_proc_2
as
begin
    alter table hotels
    drop constraint df_stars;
    print 'undo 2 done';
end
go

create or alter procedure do_proc_3
as
begin
    create table reviews (
        reviewid int identity primary key, --autoincreement
        userid int not null,
        hotelid int not null,
        rating int,
        comment nvarchar(500)
    );
    print 'version 3 done';
end
go

create or alter procedure undo_proc_3
as
begin
    drop table reviews;
    print 'undo 3 done';
end
go

create or alter procedure do_proc_4
as
begin
    alter table reviews
    add constraint fk_reviews_users foreign key(userid) references users(userid);
    print 'version 4 done';
end
go

create or alter procedure undo_proc_4
as
begin
    alter table reviews
    drop constraint fk_reviews_users;
    print 'undo 4 done';
end
go

create or alter procedure main @v int
as
begin
    declare @current int;
    select @current = versionno from version;

    if @v < 0 or @v > 4
    begin
        print 'error: versiunea nu exista.';
        return;
    end

    while @current < @v
    begin
        set @current = @current + 1;
        if @current = 1 exec do_proc_1;
        if @current = 2 exec do_proc_2;
        if @current = 3 exec do_proc_3;
        if @current = 4 exec do_proc_4;

        update version set versionno = @current;
        print 's a dus la versiunea ' + cast(@current as varchar(10));
    end

    while @current > @v
    begin
        if @current = 4 exec undo_proc_4;
        if @current = 3 exec undo_proc_3;
        if @current = 2 exec undo_proc_2;
        if @current = 1 exec undo_proc_1;
        set @current = @current - 1;

        update version set versionno = @current;
        print 's a dus la versiunea ' + cast(@current as varchar(10));
    end
end
go

exec main 1;
select * from version;

exec main 4;
select * from version;

exec main 0;
select * from version;


create or alter procedure addHotel
    @destName nvarchar(150),
    @hotelName nvarchar(200)
as
begin
    if dbo.checkName(@hotelName) = 0
    begin print 'Invalid hotel';
 return;
end;

    declare @destID int;
    select @destID = DestinationID from Destinations where Name = @destName;
    if @destID is null
    begin print 'Destination not found';
    return;
    end;

    insert into Hotels(DestinationID, Name) values(@destID, @hotelName);
    print 'Hotel was added';
end;
go


create or alter procedure addRoom
    @hotelName nvarchar(200),
    @roomType nvarchar(100),
    @price decimal(10,2)
as
begin
    if dbo.checkName(@roomType) = 0 or dbo.checkPrice(@price) = 0
    begin print 'Invalid room';
return;
end;

    declare @hotelID int;
    select @hotelID = HotelID from Hotels where Name = @hotelName;

    if @hotelID is null
    begin print 'Hotel not found';
    return;
    end;

    insert into Rooms(HotelID, RoomType, PricePerNight) values(@hotelID, @roomType, @price);
    print 'Room was added';
end;
go

