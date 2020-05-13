<h1>Here is user Notes Page</h1>



			<!-- Test bazy danych  -->
				<c:forEach items="${notesList}" var="note">


				<a href="#" >
						<div class="option">${note.description}</div>
					</a>

				</c:forEach>