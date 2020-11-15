/**
 * Copyright 2007 Applied Software Engineering, LLC. All rights reserved. You
 * may not modify, use, reproduce, or distribute this software except in
 * compliance with the terms of the License made with Applied Software
 * Engineering
 *
 * @author ttgiang
 */

//
// CampusOutlines.java
//
package com.ase.aseutil;

public class CampusOutlines implements Comparable {

	/**
	* Id numeric identity
	**/
	int id = 0;

	/**
	* Category varchar
	**/
	private String category = null;

	/**
	* Coursealpha varchar
	**/
	private String coursealpha = null;

	/**
	* Coursenum varchar
	**/
	private String coursenum = null;

	/**
	* Coursetype varchar
	**/
	private String coursetype = null;

	/**
	* Coursetitle varchar
	**/
	private String coursetitle = null;

	/**
	* HAW varchar
	**/
	private String HAW = null;

	/**
	* HIL varchar
	**/
	private String HIL = null;

	/**
	* HON varchar
	**/
	private String HON = null;

	/**
	* KAP varchar
	**/
	private String KAP = null;

	/**
	* KAU varchar
	**/
	private String KAU = null;

	/**
	* LEE varchar
	**/
	private String LEE = null;

	/**
	* MAN varchar
	**/
	private String MAN = null;

	/**
	* UHMC varchar
	**/
	private String UHMC = null;

	/**
	* WIN varchar
	**/
	private String WIN = null;

	/**
	* WOA varchar
	**/
	private String WOA = null;

	/**
	* HAW_2 varchar
	**/
	private String HAW_2 = null;

	/**
	* HIL_2 varchar
	**/
	private String HIL_2 = null;

	/**
	* HON_2 varchar
	**/
	private String HON_2 = null;

	/**
	* KAP_2 varchar
	**/
	private String KAP_2 = null;

	/**
	* KAU_2 varchar
	**/
	private String KAU_2 = null;

	/**
	* LEE_2 varchar
	**/
	private String LEE_2 = null;

	/**
	* MAN_2 varchar
	**/
	private String MAN_2 = null;

	/**
	* UHMC_2 varchar
	**/
	private String UHMC_2 = null;

	/**
	* WIN_2 varchar
	**/
	private String WIN_2 = null;

	/**
	* WOA_2 varchar
	**/
	private String WOA_2 = null;

	public CampusOutlines (int id,
									String category,
									String coursealpha,
									String coursenum,
									String coursetype,
									String coursetitle,
									String HAW,
									String HIL,
									String HON,
									String KAP,
									String KAU,
									String LEE,
									String MAN,
									String UHMC,
									String WIN,
									String WOA){
		this.id = id;
		this.category = category;
		this.coursealpha = coursealpha;
		this.coursenum = coursenum;
		this.coursetype = coursetype;
		this.coursetitle = coursetitle;
		this.HAW = HAW;
		this.HIL = HIL;
		this.HON = HON;
		this.KAP = KAP;
		this.KAU = KAU;
		this.LEE = LEE;
		this.MAN = MAN;
		this.UHMC = UHMC;
		this.WIN = WIN;
		this.WOA = WOA;
		this.HAW_2 = null;
		this.HIL_2 = null;
		this.HON_2 = null;
		this.KAP_2 = null;
		this.KAU_2 = null;
		this.LEE_2 = null;
		this.MAN_2 = null;
		this.UHMC_2 = null;
		this.WIN_2 = null;
		this.WOA_2 = null;
	}

	public CampusOutlines (int id,
									String category,
									String coursealpha,
									String coursenum,
									String coursetype,
									String coursetitle,
									String HAW,
									String HIL,
									String HON,
									String KAP,
									String KAU,
									String LEE,
									String MAN,
									String UHMC,
									String WIN,
									String WOA,
									String HAW_2,
									String HIL_2,
									String HON_2,
									String KAP_2,
									String KAU_2,
									String LEE_2,
									String MAN_2,
									String UHMC_2,
									String WIN_2,
									String WOA_2){
		this.id = id;
		this.category = category;
		this.coursealpha = coursealpha;
		this.coursenum = coursenum;
		this.coursetype = coursetype;
		this.coursetitle = coursetitle;
		this.HAW = HAW;
		this.HIL = HIL;
		this.HON = HON;
		this.KAP = KAP;
		this.KAU = KAU;
		this.LEE = LEE;
		this.MAN = MAN;
		this.UHMC = UHMC;
		this.WIN = WIN;
		this.WOA = WOA;
		this.HAW_2 = HAW_2;
		this.HIL_2 = HIL_2;
		this.HON_2 = HON_2;
		this.KAP_2 = KAP_2;
		this.KAU_2 = KAU_2;
		this.LEE_2 = LEE_2;
		this.MAN_2 = MAN_2;
		this.UHMC_2 = UHMC_2;
		this.WIN_2 = WIN_2;
		this.WOA_2 = WOA_2;
	}


	/**
	** Id numeric identity
	**/
	public int getId(){ return this.id; }
	public void setId(int value){ this.id = value; }

	/**
	** Category varchar
	**/
	public String getCategory(){ return this.category; }
	public void setCategory(String value){ this.category = value; }

	/**
	** Coursealpha varchar
	**/
	public String getCoursealpha(){ return this.coursealpha; }
	public void setCoursealpha(String value){ this.coursealpha = value; }

	/**
	** Coursenum varchar
	**/
	public String getCoursenum(){ return this.coursenum; }
	public void setCoursenum(String value){ this.coursenum = value; }

	/**
	** Coursetype varchar
	**/
	public String getCoursetype(){ return this.coursetype; }
	public void setCoursetype(String value){ this.coursetype = value; }

	/**
	** Coursetitle varchar
	**/
	public String getCoursetitle(){ return this.coursetitle; }
	public void setCoursetitle(String value){ this.coursetitle = value; }

	/**
	** HAW varchar
	**/
	public String getHAW(){ return this.HAW; }
	public void setHAW(String value){ this.HAW = value; }

	/**
	** HIL varchar
	**/
	public String getHIL(){ return this.HIL; }
	public void setHIL(String value){ this.HIL = value; }

	/**
	** HON varchar
	**/
	public String getHON(){ return this.HON; }
	public void setHON(String value){ this.HON = value; }

	/**
	** KAP varchar
	**/
	public String getKAP(){ return this.KAP; }
	public void setKAP(String value){ this.KAP = value; }

	/**
	** KAU varchar
	**/
	public String getKAU(){ return this.KAU; }
	public void setKAU(String value){ this.KAU = value; }

	/**
	** LEE varchar
	**/
	public String getLEE(){ return this.LEE; }
	public void setLEE(String value){ this.LEE = value; }

	/**
	** MAN varchar
	**/
	public String getMAN(){ return this.MAN; }
	public void setMAN(String value){ this.MAN = value; }

	/**
	** UHMC varchar
	**/
	public String getUHMC(){ return this.UHMC; }
	public void setUHMC(String value){ this.UHMC = value; }

	/**
	** WIN varchar
	**/
	public String getWIN(){ return this.WIN; }
	public void setWIN(String value){ this.WIN = value; }

	/**
	** WOA varchar
	**/
	public String getWOA(){ return this.WOA; }
	public void setWOA(String value){ this.WOA = value; }

	/**
	** HAW_2 varchar
	**/
	public String getHAW_2(){ return this.HAW_2; }
	public void setHAW_2(String value){ this.HAW_2 = value; }

	/**
	** HIL_2 varchar
	**/
	public String getHIL_2(){ return this.HIL_2; }
	public void setHIL_2(String value){ this.HIL_2 = value; }

	/**
	** HON_2 varchar
	**/
	public String getHON_2(){ return this.HON_2; }
	public void setHON_2(String value){ this.HON_2 = value; }

	/**
	** KAP_2 varchar
	**/
	public String getKAP_2(){ return this.KAP_2; }
	public void setKAP_2(String value){ this.KAP_2 = value; }

	/**
	** KAU_2 varchar
	**/
	public String getKAU_2(){ return this.KAU_2; }
	public void setKAU_2(String value){ this.KAU_2 = value; }

	/**
	** LEE_2 varchar
	**/
	public String getLEE_2(){ return this.LEE_2; }
	public void setLEE_2(String value){ this.LEE_2 = value; }

	/**
	** MAN_2 varchar
	**/
	public String getMAN_2(){ return this.MAN_2; }
	public void setMAN_2(String value){ this.MAN_2 = value; }

	/**
	** UHMC_2 varchar
	**/
	public String getUHMC_2(){ return this.UHMC_2; }
	public void setUHMC_2(String value){ this.UHMC_2 = value; }

	/**
	** WIN_2 varchar
	**/
	public String getWIN_2(){ return this.WIN_2; }
	public void setWIN_2(String value){ this.WIN_2 = value; }

	/**
	** WOA_2 varchar
	**/
	public String getWOA_2(){ return this.WOA_2; }
	public void setWOA_2(String value){ this.WOA_2 = value; }

	public String toString(){
		return "Id: " + getId() +
			"Category: " + getCategory() +
			"Coursealpha: " + getCoursealpha() +
			"Coursenum: " + getCoursenum() +
			"Coursetype: " + getCoursetype() +
			"Coursetitle: " + getCoursetitle() +
			"HAW: " + getHAW() +
			"HIL: " + getHIL() +
			"HON: " + getHON() +
			"KAP: " + getKAP() +
			"KAU: " + getKAU() +
			"LEE: " + getLEE() +
			"MAN: " + getMAN() +
			"UHMC: " + getUHMC() +
			"WIN: " + getWIN() +
			"WOA: " + getWOA() +
			"HAW_2: " + getHAW_2() +
			"HIL_2: " + getHIL_2() +
			"HON_2: " + getHON_2() +
			"KAP_2: " + getKAP_2() +
			"KAU_2: " + getKAU_2() +
			"LEE_2: " + getLEE_2() +
			"MAN_2: " + getMAN_2() +
			"UHMC_2: " + getUHMC_2() +
			"WIN_2: " + getWIN_2() +
			"WOA_2: " + getWOA_2() +
			"";
	}

	public int compareTo(Object object) {
		return 0;
	}

}