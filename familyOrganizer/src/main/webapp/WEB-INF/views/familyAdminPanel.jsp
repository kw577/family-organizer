
<%
	response.setCharacterEncoding("UTF-8");
	request.setCharacterEncoding("UTF-8");
%>

<%@taglib prefix="sform" uri="http://www.springframework.org/tags/form"%>

<section class="adminPanelView">

	<div class="container-fluid">

		<div class="row">

			<div class="adminPanelWrapper">

				<div class="adminPanelHeader">
					<div class="adminPanelHeaderItem1">${family.name}</div>
					<div class="adminPanelHeaderItem2">
						<button type="button" class="btn btn-warning"
							id="editFamilyAccountButton">
							<i class="fas fa-pen"></i>
						</button>
					</div>
				</div>


				<div class="adminTableWrapper">
					<table id="adminPanelTable">

						<tr>
							<th>Name</th>
							<th>Surname</th>
							<th>email</th>
							<th>Account type</th>
							<th>Active</th>
							<th>Actions</th>
						</tr>

						<tr>
							<td>Marek</td>
							<td>Kowalski</td>
							<td>marek@email.com</td>
							<td>Admin</td>
							<td>Enabled</td>
							<td>
								<button type="button" class="btn btn-warning">
									<i class="fas fa-pen"></i>
								</button>
								<button type="button" class="btn btn-danger">
									<i class="fas fa-user-minus"></i>
								</button>
							</td>
						</tr>

						<tr>
							<td>Magda</td>
							<td>Kowalska</td>
							<td>magda@email.com</td>
							<td>User</td>
							<td>Enabled</td>
							<td>
								<button type="button" class="btn btn-warning">
									<i class="fas fa-pen"></i>
								</button>
								<button type="button" class="btn btn-danger">
									<i class="fas fa-user-minus"></i>
								</button>
							</td>
						</tr>

						<tr>
							<td>Kamil</td>
							<td>Kowalski</td>
							<td>kamil@email.com</td>
							<td>User</td>
							<td>Enabled</td>
							<td>
								<button type="button" class="btn btn-warning">
									<i class="fas fa-pen"></i>
								</button>
								<button type="button" class="btn btn-danger">
									<i class="fas fa-user-minus"></i>
								</button>
							</td>
						</tr>





						<c:forEach items="${familyMembers}" var="familyMember">


							<tr>
								<td>${familyMember.name}</td>
								<td>${familyMember.surname}</td>
								<td>${familyMember.email}</td>
								<td>${familyMember.role}</td>
								<td>${familyMember.enabled}</td>
								<td>
									<button type="button" class="btn btn-warning">
										<i class="fas fa-pen"></i>
									</button>
									<button type="button" class="btn btn-danger">
										<i class="fas fa-user-minus"></i>
									</button>
								</td>
							</tr>

						</c:forEach>



					</table>


					<div class="adminTableFooter">
						<button type="button" class="btn btn-primary" data-toggle="modal"
							data-target="#addNewUserModal">
							New user <i class="fas fa-user-plus"></i>
						</button>

					</div>

				</div>

			</div>




			<!-- Add new user modal -->
			<div class="modal fade" id="addNewUserModal">
				<div class="modal-dialog">
					<div class="modal-content">

						<!-- Modal Header -->
						<div class="modal-header">
							<h5 class="modal-title">Add new User to your Family Account</h5>
							<button type="button" class="close" data-dismiss="modal">&times;</button>
						</div>


						<sform:form id="addNewUserForm" modelAttribute="addUser"
							action="${contextRoot}/manage/familyAccount/addUser/"
							name="addNewUserForm" method="post">
							<!-- Modal body -->
							<div class="modal-body">
								<div class="form-group">
									<label style="font-size: 12px;">New User's name</label>
									<sform:input type="text" placeholder="Name" path="name"
										id="name" />
								</div>
								<div class="form-group">
									<label style="font-size: 12px;">New User's surname</label>
									<sform:input type="text" placeholder="Surname" path="surname"
										id="surname" />
								</div>
								<div class="form-group">
									<label style="font-size: 12px;">New User's email
										address</label>
									<sform:input type="email" placeholder="e-mail" path="email"
										id="email" />
								</div>

								<sform:hidden path="id" />
								<sform:hidden path="role" />
								<sform:hidden path="enabled" />
								<sform:hidden path="family_id" />
								<sform:hidden path="password" />

							</div>

							<!-- Modal footer -->
							<div class="modal-footer">
								<input type="submit" class="btn btn-primary"
										value="Save">
								<button type="button" class="btn btn-danger"
									data-dismiss="modal">Close</button>
							</div>
						</sform:form>
					</div>
				</div>
			</div>
</section>




<!-- Change family account name - form - hidden by default -->
<div id="editFamilyAccountForm-content" style="display: none;">
	<sform:form id="editFamilyAccountForm" modelAttribute="newFamily"
		action="${contextRoot}/manage/familyAccount/edit/"
		name="editFamilyAccountForm" method="post">
		<div class="form-group">
			<label style="font-size: 12px;">Family Account Name</label>
			<sform:input type="text" class="form-control" path="name" id="name"
				value="${family.name}" />
			<sform:hidden path="id" />
		</div>
	</sform:form>
</div>



