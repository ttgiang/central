
			<textarea cols="80" id="<%=ckName%>" name="<%=ckName%>" rows="10"><%=ckData%></textarea>

			<script type="text/javascript">
				//<![CDATA[
					CKEDITOR.replace( '<%=ckName%>',
						{
							toolbar : [ ['Bold','Italic','Underline','Strike','Subscript','Superscript','-','RemoveFormat','-','Source' ]
												],
							enterMode : CKEDITOR.ENTER_BR,
							shiftEnterMode: CKEDITOR.ENTER_P,
						});

				//]]>
			</script>
