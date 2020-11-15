<%@ page import="com.ase.aseutil.*" %>

<%@ include file="ase.jsp" %>

<%

try
{
	String campus = "LEECC";
	int i = 0;

	ArrayList list = QuestionDB.getCourseQuestionsInclude(campus,"Y");
	if ( list != null ){
		Question question;
		for (i=0; i<list.size(); i++) {
			question = (Question)list.get(i);
			out.println( question.getQuestion() + "<br>" );
		}
		list = null;
	}	// if
}
catch (Exception e){
	out.println( e.toString() );
};


%>