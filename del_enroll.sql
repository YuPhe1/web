CREATE DEFINER=`haksa`@`localhost` PROCEDURE `del_enroll`(
	in i_scode char(8),
    in i_lcode char(4)
)
BEGIN
	delete from enrollments
    where scode=i_scode and lcode=i_lcode;
    update courses set persons=persons-1
    where lcode=i_lcode;
END