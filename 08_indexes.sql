drop index if exists idx_Hotels_Name on Hotels;
go
create index idx_Hotels_Name on Hotels(Name);
go