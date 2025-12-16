drop trigger if exists tr_Flights_Insert;
drop trigger if exists tr_Flights_Update;
drop trigger if exists tr_Flights_Delete;
drop table if exists Logs;
go

--log table
create table Logs(
    LogID int identity primary key,
    TriggerDate datetime2,
    TriggerType nvarchar(20),
    AffectedTable nvarchar(50), --Flights
    NoAMDRows int --randuri inserate
);
go

--trigger-exec automata dupa fiecare insert
create or alter trigger tr_Flights_Insert
on Flights after insert
as
begin
    insert into Logs(TriggerDate, TriggerType, AffectedTable, NoAMDRows)
    values(sysdatetime(), 'insert', 'Flights', @@ROWCOUNT);
end;
go


create or alter trigger tr_Flights_Update
on Flights after update
as
begin
    insert into Logs(TriggerDate, TriggerType, AffectedTable, NoAMDRows)
    values(sysdatetime(), 'update', 'Flights', @@ROWCOUNT);
end;
go


create or alter trigger tr_Flights_Delete
on Flights after delete
as
begin
    insert into Logs(TriggerDate, TriggerType, AffectedTable, NoAMDRows)
    values(sysdatetime(), 'delete', 'Flights', @@ROWCOUNT);
end;
go