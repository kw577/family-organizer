<%
    response.setCharacterEncoding("UTF-8");
    request.setCharacterEncoding("UTF-8");
%>

<section class="adminPanelView">
							
	<div class="container-fluid">
									
		<div class="row">
										
			<div class="adminPanelWrapper">
										
				<div class="adminPanelHeader">
					<div class="adminPanelHeaderItem1">Rodzina Kowalskich</div>
					<div class="adminPanelHeaderItem2">
						<button type="button" class="btn btn-warning"><i class="fas fa-pen"></i></button>
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
								<button type="button" class="btn btn-warning"><i class="fas fa-pen"></i></button>
								<button type="button" class="btn btn-danger"><i class="fas fa-user-minus"></i></button>
							</td>
						</tr>

						<tr>
							<td>Magda</td>
							<td>Kowalska</td>
							<td>magda@email.com</td>
							<td>User</td>
							<td>Enabled</td>
							<td>
								<button type="button" class="btn btn-warning"><i class="fas fa-pen"></i></button>
								<button type="button" class="btn btn-danger"><i class="fas fa-user-minus"></i></button>
							</td>
						</tr>	

						<tr>
							<td>Kamil</td>
							<td>Kowalski</td>
							<td>kamil@email.com</td>
							<td>User</td>
							<td>Enabled</td>
							<td>
								<button type="button" class="btn btn-warning"><i class="fas fa-pen"></i></button>
								<button type="button" class="btn btn-danger"><i class="fas fa-user-minus"></i></button>
							</td>
						</tr>		
											
					</table>
																				
					<div class="adminTableFooter">
									
						<button type="button" class="btn btn-primary">New user <i class="fas fa-user-plus"></i></button>
					<div>
										
										
				</div>
																		
		</div>
													
	</div>
								
</div>	
									
</section>