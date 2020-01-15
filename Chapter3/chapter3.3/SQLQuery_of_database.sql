select * from ESTPObjects where Event_ID = TF1822
select * from ESTPProcess where Event_ID = TF1822
select * from ESTPStateObjects where STP_ID in ( select STP_ID from ESTPProcess where Event_ID = TF1822 )
