use extract03;

--delete from CatalogDesc_AtoI_Batch1of3;
--delete from CatalogDesc_JtoR_Batch2of3;
--delete from CatalogDesc_StoZ_Batch3of3;

--delete from MainFile_AtoI_Batch1of3;
--delete from MainFile_JtoR_Batch2of3;
--delete from MainFile_StoZ_Batch3of3;

--delete from MultipleRecs_AtoI_Batch1of3;
--delete from MultipleRecs_JtoR_Batch2of3;
--delete from MultipleRecs_StoZ_Batch3of3;

--delete from _bannercat;
--delete from _bannerdups;
--delete from _bannermaster;

--insert into _bannercat select * from CatalogDesc_AtoI_Batch1of3;
--insert into _bannercat select * from CatalogDesc_JtoR_Batch2of3;
--insert into _bannercat select * from CatalogDesc_StoZ_Batch3of3;

--insert into _bannerdups select * from MultipleRecs_AtoI_Batch1of3;
--insert into _bannerdups select * from MultipleRecs_JtoR_Batch2of3;
--insert into _bannerdups select * from MultipleRecs_StoZ_Batch3of3;

/*
insert into _bannermaster (CRSE_SUBJ, CRSE_NUMBER, EFFECTIVE_TERM, CRSE_OFFERING_STATUS, CRSE_STATUS, CRSE_LONG_TITLE, CRSE_TITLE, CONT_LOW, CONT_IND, 
CONT_HIGH, CREDIT_LOW, CREDIT_IND, CREDIT_HIGH, REPEAT_LIMIT, MAX_REPEAT_UNITS, MAJ_IND, MAJ_LSFT_CODE, CLASS_IND, TERM_ENDDATE)
select * from MainFile_AtoI_Batch1of3;

insert into _bannermaster (CRSE_SUBJ, CRSE_NUMBER, EFFECTIVE_TERM, CRSE_OFFERING_STATUS, CRSE_STATUS, CRSE_LONG_TITLE, CRSE_TITLE, CONT_LOW, CONT_IND, 
CONT_HIGH, CREDIT_LOW, CREDIT_IND, CREDIT_HIGH, REPEAT_LIMIT, MAX_REPEAT_UNITS, MAJ_IND, MAJ_LSFT_CODE, CLASS_IND, TERM_ENDDATE)
select * from MainFile_JtoR_Batch2of3;

insert into _bannermaster (CRSE_SUBJ, CRSE_NUMBER, EFFECTIVE_TERM, CRSE_OFFERING_STATUS, CRSE_STATUS, CRSE_LONG_TITLE, CRSE_TITLE, CONT_LOW, CONT_IND, 
CONT_HIGH, CREDIT_LOW, CREDIT_IND, CREDIT_HIGH, REPEAT_LIMIT, MAX_REPEAT_UNITS, MAJ_IND, MAJ_LSFT_CODE, CLASS_IND, TERM_ENDDATE)
select * from MainFile_StoZ_Batch3of3;
*/

delete from _bannermaster9407;
insert into _bannermaster9407 select * from _bannermaster;

--
-- clear previous imports (done in code)
--
-- also in R0_clear
--
delete from tblcourse where historyid like 'KRI%' and campus='MAN';
delete from tblcoursearc where historyid like 'KRI%' and campus='MAN';
delete from tblcoursecan where historyid like 'KRI%' and campus='MAN';
delete from tblcampusdata where historyid like 'KRI%' and campus='MAN';
delete from tblxref where historyid like 'KRI%' and campus='MAN';

--
-- clear working tables
--
--delete from _bannercat$
--delete from _bannerdups$
--delete from _bannermaster$

--
-- clear working tables
--
--delete from _bannercat;
--delete from _bannerdups;
--delete from _bannermaster;

--
-- find dups as min (ARC) and max (CUR)
-- there are courses with 2 sets and others with 3 sets
-- we have to pull them out and change to ARC
--
-- also in R0_clear
--
delete from _bannermaster_min;
delete from _bannermaster_min2;
delete from _bannermaster_min3;
delete from _bannermastertest;
delete from _bannermaster_2arc;
delete from _bannermaster_done;

--
-- copy to working table (all set inside R0_insert)
--
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

--
-- this data is used for the overlay
--
insert INTO _bannermaster_2arc
SELECT b.CRSE_SUBJ, b.CRSE_NUMBER, b.EFFECTIVE_TERM AS BTERM, c.effectiveterm AS CTERM, c.CourseType
FROM _bannermaster AS b INNER JOIN tblCourse AS c ON b.CRSE_SUBJ = c.CourseAlpha 
AND b.CRSE_NUMBER = c.CourseNum 
AND b.EFFECTIVE_TERM > c.effectiveterm
WHERE     (c.campus = 'MAN')
ORDER BY b.CRSE_SUBJ, b.CRSE_NUMBER, BTERM

--
-- with the older terms out of the way, we need to set _bannermaster table correctly
-- that means replacing its content with _bannermastertest where dups have been
-- removed and leaving only the highest term
--
-- **** this is not needed because we have to leave master alone to complete
-- processing of ARC courses then move them to ARC table
-- reasing is supporting table contains course/number/term that are processed
-- based on the same keys in master table.
-- we know about the dups because they've been tagged as ARC for retirement

--
-- even with the most current term, we have to delete those that have already been
-- added to CC prior to banner extract
--

--
-- table of courses already in CC (_bannermaster_done)
-- done meaning there is a matching alpha and number only
-- term is dealt with differently
--
insert into _bannermaster_done
SELECT     b.CRSE_SUBJ, b.CRSE_NUMBER, b.EFFECTIVE_TERM, b.CRSE_OFFERING_STATUS, b.CRSE_STATUS, b.CRSE_LONG_TITLE, b.CRSE_TITLE,
                      b.CONT_LOW, b.CONT_IND, b.CONT_HIGH, b.CREDIT_LOW, b.CREDIT_IND, b.CREDIT_HIGH, b.REPEAT_LIMIT, b.MAX_REPEAT_UNITS, b.MAJ_IND,
                      b.MAJ_LSFT_CODE, b.CLASS_IND, b.TERM_ENDDATE, b.HistoryID, b.repeatable, b.ContactHours, b.Credits, b.ID, b.A, b.B, b.C, b.D, b.E,
                      b.ALPHA_NUM, b.ALPHA_NUM_TERM, b.CC_TYPE
FROM         _bannermaster AS b INNER JOIN
                      tblCourse AS c ON b.CRSE_SUBJ = c.CourseAlpha AND b.CRSE_NUMBER = c.CourseNum
WHERE     (c.campus = 'MAN')

--
-- remove completed courses already in CC
--
delete from _bannermaster where historyid in (select historyid from _bannermaster_done);

--
-- at this point, _bannermaster does not contain dups or courses started in CC
--

------
------ testing area
------
select distinct crse_subj, crse_number from _bannermaster_done;

SELECT     CRSE_SUBJ, CRSE_NUMBER, MIN(EFFECTIVE_TERM) AS min_term
FROM         (SELECT     TOP (100) PERCENT b.HistoryID, b.CRSE_SUBJ, b.CRSE_NUMBER, b.EFFECTIVE_TERM, b.CRSE_TITLE, BannerTerms.TERM_DESCRIPTION
                       FROM          _bannermaster_done AS b INNER JOIN
                                              BannerTerms ON b.EFFECTIVE_TERM = BannerTerms.TERM_CODE
                       WHERE      (b.ALPHA_NUM IN
                                                  (SELECT     ALPHA_NUM
                                                    FROM          _bannermaster_done AS Tmp
                                                    GROUP BY ALPHA_NUM
                                                    HAVING      (COUNT(*) > 1)))
                       ORDER BY b.ALPHA_NUM) AS tbl
GROUP BY CRSE_SUBJ, CRSE_NUMBER
ORDER BY CRSE_SUBJ, CRSE_NUMBER;

select * from _bannermaster_done where crse_subj='DIS' and crse_number='681'
select * from _bannermastertest where crse_subj='DIS' and crse_number='681'
select * from tblcourse where coursealpha='DIS' and coursenum='681'

select * from tblcourse where campus='MAN' and historyid like 'KRI%' and coursetype='ARC'

select * from _bannermaster_done where crse_subj='EDUC' and crse_number='799'
select * from tblcourse where campus='MAN' and coursealpha = 'APDM' and coursenum='460'

select count(*) from _bannermaster

//
delete from _banner_overlay_bn;
delete from _banner_overlay_cc;
delete from _banner_overlay_combined;

insert INTO _banner_overlay_cc
SELECT     historyid as ckix, CourseAlpha, CourseNum, CourseType, Progress, effectiveterm as cterm
FROM         tblCourse
WHERE     (campus = 'MAN') AND (NOT (historyid LIKE 'KRI%'));

insert INTO _banner_overlay_bn
SELECT     historyid as bkix, CourseAlpha, CourseNum, CourseType, Progress, effectiveterm as bterm
FROM         tblCourse
WHERE     (campus = 'MAN') AND (historyid LIKE 'KRI%');

insert into _banner_overlay_combined
SELECT bkix, ckix, _banner_overlay_cc.CourseAlpha, _banner_overlay_cc.CourseNum, _banner_overlay_cc.CourseType, _banner_overlay_cc.Progress, cterm, bterm
FROM _banner_overlay_cc INNER JOIN
_banner_overlay_bn ON _banner_overlay_cc.CourseAlpha = _banner_overlay_bn.CourseAlpha AND 
_banner_overlay_cc.CourseNum = _banner_overlay_bn.CourseNum


---------------------------
clear
---------------------------
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
