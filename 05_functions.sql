create or alter function checkName(@v nvarchar(200))
returns bit
as
begin
    if len(@v) >= 3 return 1;
    return 0;
end;
go

create or alter function checkPrice(@p decimal(10,2))
returns bit
as
begin
    if @p > 0 return 1;
    return 0;
end;
go