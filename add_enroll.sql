CREATE DEFINER=`haksa`@`localhost` PROCEDURE `add_enroll`(
	in i_scoed char(8),
    in i_lcode char(4),
    out o_count int
)
BEGIN
	select count(*) o_count from enrollments
    where scode = i_scode and lcode=i_lcode;
    if(o_count = 0)then
		insert into enrollments(scode, lcode)
        values(i_scode, i_lcode);
        update courses set persons=persons+1
        where lcode=i_lcode;
    end if;
END