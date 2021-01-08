use ccv2;

delete from _banner_overlay_bn;
delete from _banner_overlay_cc;
delete from _banner_overlay_combined;
delete from _bannercat;
delete from _bannerdups;
delete from _bannermaster;
delete from _bannermaster_2arc;
delete from _bannermaster_done;
delete from _bannermaster_min;
delete from _bannermaster_min2;
delete from _bannermaster_min3;
delete from _bannermaster9407;
delete from _bannermastertest;
delete from _bannermastertest_terms;
delete from _banner_overlay_bn;

insert into _bannercat select * from CatalogDesc;
insert into _bannerdups select * from MultipleRecs;
insert into _bannermaster (CRSE_SUBJ, CRSE_NUMBER, EFFECTIVE_TERM, CRSE_OFFERING_STATUS, CRSE_STATUS, CRSE_LONG_TITLE, CRSE_TITLE, CONT_LOW, CONT_IND, 
CONT_HIGH, CREDIT_LOW, CREDIT_IND, CREDIT_HIGH, REPEAT_LIMIT, MAX_REPEAT_UNITS, MAJ_IND, MAJ_LSFT_CODE, CLASS_IND, TERM_ENDDATE)
select * from MainFile;

delete from _bannermaster9407;

insert into _bannermaster9407 select * from _bannermaster;

--
-- clear previous imports (done in code)
--
-- also in R0_clear
--
delete from tblcourse where historyid like 'HTR%' and campus='HAW';
delete from tblcoursearc where historyid like 'HTR%' and campus='HAW';
delete from tblcoursecan where historyid like 'HTR%' and campus='HAW';
delete from tblcampusdata where historyid like 'HTR%' and campus='HAW';
delete from tblxref where historyid like 'HTR%' and campus='HAW';

--
-- copy to working table (all set inside R0_insert)
--
delete from _bannermastertest;

insert into _bannermastertest select * from _bannermaster;

--
-- connect terms with master table, group together then figure out the minimum term for identical course
-- the lower term is the one to go to ARC min2 is because there is a set of 2 identical
--
insert into _bannermaster_min2
SELECT CRSE_SUBJ, CRSE_NUMBER, MIN(EFFECTIVE_TERM) AS min_term
FROM
(
	SELECT TOP (100) PERCENT b.HistoryID, b.CRSE_SUBJ, b.CRSE_NUMBER, b.EFFECTIVE_TERM, b.CRSE_TITLE, BannerTerms.TERM_DESCRIPTION
	FROM _bannermaster AS b INNER JOIN BannerTerms ON b.EFFECTIVE_TERM = BannerTerms.TERM_CODE
	WHERE 
	(
		b.ALPHA_NUM IN 
		(
			SELECT ALPHA_NUM FROM _bannermaster AS Tmp GROUP BY ALPHA_NUM HAVING COUNT(*) > 1
		)
	)
	ORDER BY b.ALPHA_NUM
) AS tbl
GROUP BY CRSE_SUBJ, CRSE_NUMBER
ORDER BY CRSE_SUBJ, CRSE_NUMBER;

--
-- remove the lowest term from the main table to work with
--
delete from _bannermastertest
where historyid in (
	select m.historyid
	from _bannermaster_min2 m2 inner join _bannermaster m on
	m2.crse_subj = m.crse_subj and
	m2.crse_number = m.crse_number and
	m2.min_term = m.EFFECTIVE_TERM
)

--
-- create second table of duplicate terms (having 3 sets)
-- similar to _bannermaster_min2, after removing from _bannermastertest as in the above,
-- we are left now with the 2 duplicates where the minimum is of the 2 remaining
-- NOTE: WE MUST USE _bannermastertest at this point
--
insert into _bannermaster_min3
SELECT CRSE_SUBJ, CRSE_NUMBER, MIN(EFFECTIVE_TERM) AS min_term
FROM
(
	SELECT TOP (100) PERCENT b.HistoryID, b.CRSE_SUBJ, b.CRSE_NUMBER, b.EFFECTIVE_TERM, b.CRSE_TITLE, BannerTerms.TERM_DESCRIPTION
	FROM _bannermastertest AS b INNER JOIN BannerTerms ON b.EFFECTIVE_TERM = BannerTerms.TERM_CODE
	WHERE
	(
		b.ALPHA_NUM IN
		(
			SELECT ALPHA_NUM FROM _bannermastertest AS Tmp GROUP BY ALPHA_NUM HAVING COUNT(*) > 1
		)
	)
	ORDER BY b.ALPHA_NUM
) AS tbl
GROUP BY CRSE_SUBJ, CRSE_NUMBER
ORDER BY CRSE_SUBJ, CRSE_NUMBER;

--
-- remove the lowest term from the main table to work with
-- what's left in mastertest are single occurence of most recent
-- term
--
delete from _bannermastertest
where historyid in (
	select m.historyid
	from _bannermaster_min3 m3 inner join _bannermaster m on
	m3.crse_subj = m.crse_subj and
	m3.crse_number = m.crse_number and
	m3.min_term = m.EFFECTIVE_TERM
)

--
-- combine as a single table to work with min2 contains sets of 2 where min3
-- had 3 identical alpha/num but different terms
--
insert into _bannermaster_min
select *
from
(
select * from _bannermaster_min2
union
select * from _bannermaster_min3
) as mins
