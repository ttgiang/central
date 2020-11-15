
			<textarea cols="80" id="<%=ckName03%>" name="<%=ckName03%>" rows="10"><%=ckData03%></textarea>

			<script type="text/javascript">
				//<![CDATA[
					CKEDITOR.replace( '<%=ckName03%>',
						{
							toolbar : [ ['Bold','Italic','Underline','Strike','Subscript','Superscript','-','RemoveFormat','-','Source' ]
												],
							enterMode : CKEDITOR.ENTER_BR,
							shiftEnterMode: CKEDITOR.ENTER_P,
						});

				//]]>
			</script>
