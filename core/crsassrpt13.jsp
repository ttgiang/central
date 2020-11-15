<%@ include file="ase.jsp" %>

<%
	/**
	*	ASE
	*	crsassrpt3.jsp
	*	2007.09.01	select competencies given the outline
	**/
%>

<br>
	<%
		/*
			q comes in as assessid_alpha_num or x_ICS_218
			need to break it down to individual components
		*/

		String campus = website.getRequestParameter(request,"aseCampus","",true);
		String alpha = "";
		String num = "";
		String sql = "";
		String assessID = "";
		String q = website.getRequestParameter(request,"q","");

		if ( q.length() > 0 ){
			// get compid
			int n = q.indexOf("_");
			assessID = q.substring(0,n);

			// advance to point after first _
			q = q.substring(n+1);
			n = q.indexOf("_");
			alpha = q.substring(0,n);

			// remainder is num
			num = q.substring(n+1);
		}

		try{
			ArrayList list = CompDB.getCompsByAlphaNum(conn,campus,alpha,num,assessID);
			if ( list != null ){
				Comp comp;
				for (int i=0;i<list.size();i++){
					comp = (Comp)list.get(i);
					out.println(comp.getComp() + "<br>" );
				}
			}
		}
		catch (Exception e){
			out.println( e.toString() );
		}
		finally{
			asePool.freeConnection(conn);
		}
	%>
