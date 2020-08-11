
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
						
						<button type="button" class="btn btn-warning" data-toggle="modal"
							data-target="#editFamilyAccountModal">
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



						<c:forEach items="${familyMembers}" var="familyMember">


							<tr>
								<td>${familyMember.name}</td>
								<td>${familyMember.surname}</td>
								<td>${familyMember.email}</td>
								<td>${familyMember.role}</td>
								<td>${familyMember.enabled}</td>
								<td>
									
									<button type="button" class="btn btn-warning" 
									data-toggle="modal" data-target="#modifyUserAccountModal"
									onclick="fillModifyUserAccountForm('<c:out value="${familyMember.email}"/>', '<c:out value="${familyMember.name}"/>', '<c:out value="${familyMember.surname}"/>')"
									>
										<i class="fas fa-pen"></i>
									</button>
									
																
														
									<c:if test="${familyMember.role == 'USER' }"> 
										<button type="button" class="btn btn-danger" 
										data-toggle="modal" data-target="#deleteUserAccountModal"
										onclick="fillDeleteUserAccountForm('<c:out value="${familyMember.email}"/>', '<c:out value="${familyMember.name}"/>', '<c:out value="${familyMember.surname}"/>')"
										>
											<i class="fas fa-user-minus"></i>
										</button>
									</c:if>	
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
			
			
			
			
			
			<!-- Edit family account modal -->
			<div class="modal fade" id="editFamilyAccountModal">
				<div class="modal-dialog">
					<div class="modal-content">

						<!-- Modal Header -->
						<div class="modal-header">
							<h5 class="modal-title">Edit your Family Account</h5>
							<button type="button" class="close" data-dismiss="modal">&times;</button>
						</div>


						<sform:form id="editFamilyAccountForm" modelAttribute="newFamily"
							action="${contextRoot}/manage/familyAccount/edit/"
							name="editFamilyAccountForm" method="post">
							<!-- Modal body -->
							<div class="modal-body">
								<div class="form-group">
									<label style="font-size: 12px;">Family Account Name</label>
									<sform:input type="text" class="form-control" path="name" id="name"
										value="${family.name}" />
								</div>

								<sform:hidden path="id" />

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
			
			
			
			
			
			
			
			<!-- Delete user account -->
			<div class="modal fade" id="deleteUserAccountModal">
				<div class="modal-dialog">
					<div class="modal-content">

						<!-- Modal Header -->
						<div class="modal-header">
							<h5 class="modal-title">Delete User account</h5>
							<button type="button" class="close" data-dismiss="modal">&times;</button>
						</div>


						<sform:form id="deleteUserAccountForm" modelAttribute="delUser"
							action="${contextRoot}/manage/familyAccount/deleteUser/"
							name="deleteUserAccountForm" method="post">
							<!-- Modal body -->
							<div class="modal-body">

								Are you sure that you want to delete this user's account ?
								<div id="deleteUserAccountInfo" style="font-size: 16px; margin-top: 10px;">
								</div>
								
								<div class="form-group">
									<sform:input type="hidden" placeholder="e-mail" path="email"
										id="email" name="email" />
								</div>

								<sform:hidden path="id" />
								<sform:hidden path="name" />
								<sform:hidden path="surname" />
								<sform:hidden path="role" />
								<sform:hidden path="enabled" />
								<sform:hidden path="family_id" />
								<sform:hidden path="password" />

							</div>

							<!-- Modal footer -->
							<div class="modal-footer">
								<input type="submit" class="btn btn-danger"
										value="Delete">
								<button type="button" class="btn btn-basic"
									data-dismiss="modal">Cancel</button>
							</div>
						</sform:form>
					</div>
				</div>
			</div>
			
			
			
			
			
			
			
			<!-- Modify user account -->
			<div class="modal fade" id="modifyUserAccountModal">
				<div class="modal-dialog">
					<div class="modal-content">

						<!-- Modal Header -->
						<div class="modal-header">
							<h5 class="modal-title">Edit User's account</h5>
							<button type="button" class="close" data-dismiss="modal">&times;</button>
						</div>


						<sform:form id="modifyUserAccountForm" modelAttribute="modUser"
							action="${contextRoot}/manage/familyAccount/modifyUser/"
							name="modifyUserAccountForm" method="post">
							<!-- Modal body -->
							<div class="modal-body">

								
								<div style="font-size: 16px; margin-top: 10px;">
									Here you can edit user account:
								</div>
								
								
								<div class="form-group">
									<label style="font-size: 12px;">User's name</label>
									<sform:input type="text" path="name"
										id="name" name="name" />
								</div>
								<div class="form-group">
									<label style="font-size: 12px;">User's surname</label>
									<sform:input type="text" path="surname"
										id="surname" name="surname" />
								</div>
								
								
								<div class="form-group">
									<sform:input type="hidden" placeholder="e-mail" path="email"
										id="email" name="email" />
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
								<button type="button" class="btn btn-basic"
									data-dismiss="modal">Cancel</button>
							</div>
						</sform:form>
					</div>
				</div>
			</div>
			
			
		</div>	
			
	</div>		
			
			
			
</section>





