<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %> 
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Rule Group</title>

<SCRIPT type="text/javascript">

	var ruleSize = ${fn:length(ruleList)};

	// add input form when clicked add button
	function append_rule_input() {
		ruleSize++;
		var table = document.getElementById("ruleGroup");
		var row = table.insertRow(table.rows.length-2);
		row.insertCell(0).innerHTML = '<input name="choose" type="checkbox"/>';
		row.insertCell(1).innerHTML = '<input type="hidden" name="ruleList[' + ruleSize + '].id" value="0"/><input type="text" name="ruleList[' + ruleSize + '].applicationId"/>';
		row.insertCell(2).innerHTML = '<select name="ruleList[' + ruleSize + '].checkerName">'
										+ '    <c:forEach var="checkerName" items="${checkerNameList}">'
										+ '        <option value="${checkerName}">${checkerName}</option>'						
										+ '    </c:forEach>'
									+ '</select>';
		row.insertCell(3).innerHTML =  '<input type="text" name="ruleList[' + ruleSize + '].threshold"/>';
		row.insertCell(4).innerHTML =  '<select name="ruleList[' + ruleSize + '].empGroup">'
										+ '    <c:forEach var="groupName" items="${empGroupNameList}">'
										+ '        <option value="${groupName}">${groupName}</option>'
										+ '    </c:forEach>'
									+ '</select>';	
		row.insertCell(5).innerHTML = '<select name="ruleList[' + ruleSize+ '].smsSend">'
										+ '    <option value="true">true</option>'
										+ '    <option value="false">false</option>'
									+ '</select>';
		row.insertCell(6).innerHTML = '<select name="ruleList[' + ruleSize+ '].emailSend">'
										+ '    <option value="true">true</option>'
										+ '    <option value="false">false</option>'
									+ '</select>';
		row.insertCell(7).innerHTML = '<input type="text" name="ruleList[' + ruleSize + '].notes" value="${rule.notes}"/>'
	}
	
	//delete input form when clicked delete button
	function remove_rule_input() {
		var table = document.getElementById("ruleGroup");
		var choose = document.getElementsByName("choose");
		
		for (var i=0; i<choose.length; i++){
			if (choose[i].checked){
				if (choose.length > 1) {
			    	table.deleteRow(i + 3);
					i--;
				}
			}
		}
	}
	
	function onSubmitForm()
	{
		if(document.pressed == 'insert') {
 			document.ruleGroupForm.action ="./insertRule.pinpoint";
		} else if(document.pressed == 'update') {
			document.ruleGroupForm.action ="./updateRule.pinpoint";
		} else if(document.pressed == 'delete') {
			document.ruleGroupForm.action ="./deleteRule.pinpoint";
		}

		return true;
	}

</SCRIPT>

</head>
<body>
<!-- Screen name  -->
<center>
	<h1>Setting Alarm rule</h1>
</center>

<!-- Search application -->
<center>
	<form action="./getRule.pinpoint">
		<select name="applicationName">
			<c:forEach var="applicationName" items="${applicationNameList}">
				<option value="${applicationName}">${applicationName}</option>
			</c:forEach>
		</select>
		<button value="Search">Search</button>
	</form>
	</br>
</center>

<!-- employee list -->
<center>
	<form name="ruleGroupForm" method="post" onsubmit="return onSubmitForm();">
		<table id="ruleGroup" frame="void" border="1">
			<!-- add employee -->
			<tr bordercolor="white">
					<td align="left" colspan="8">
						<button type="button" onclick='append_rule_input()'>new</button>
						<button type="button" onclick='remove_rule_input()'>delete</button>
					</td>
			</tr>
			<tr bordercolor="white">
			</tr>
						
			<!-- employee information list -->
			<tr>
				<th>Delete</th>
				<th>Application name</th>
				<th>Rule</th>
				<th>Limits</th>
				<th>Employee groupName</th>
				<th>Sending sms</th>
				<th>Sending email</th>
				<th>ETC</th>
			</tr>
			<c:forEach var="rule" items="${ruleList}" varStatus="ruleIndex">
					<tr>
						<td><input name="choose" type="checkbox"/></td>
	 					<td><input type="hidden" name="ruleList[${ruleIndex.index}].id" value="${rule.id}"/><input type="text" name="ruleList[${ruleIndex.index}].applicationId" value="${rule.applicationId}"/></td>
						<td>
							<select name="ruleList[${ruleIndex.index}].checkerName">
								<c:forEach var="checkerName" items="${checkerNameList}">
									<c:choose>
										<c:when test="${rule.checkerName == checkerName}">
											<option value="${checkerName}" selected="selected">${checkerName}</option>
										</c:when>
										<c:when test="${rule.checkerName != checkerName}">
											<option value="${checkerName}">${checkerName}</option>
										</c:when>
									</c:choose>
								</c:forEach>
							</select>
						</td>
						<td><input type="text" name="ruleList[${ruleIndex.index}].threshold" style="text-align:right;" value="${rule.threshold}"/></td>
						<td>
							<select name="ruleList[${ruleIndex.index}].empGroup">
								<c:forEach var="groupName" items="${empGroupNameList}">
									<c:choose>
										<c:when test="${rule.empGroup == groupName}">
											<option value="${groupName}" selected="selected">${groupName}</option>
										</c:when>
										<c:when test="${rule.empGroup != groupName}">
											<option value="${groupName}">${groupName}</option>
										</c:when>
									</c:choose>
								</c:forEach>
							</select>
						</td>
						<td>
							<select name="ruleList[${ruleIndex.index}].smsSend">
								<c:choose>
									<c:when test="${rule.smsSend == true}">
										<option value="true" selected="selected">true</option>
										<option value="false">false</option>
									</c:when>
									<c:when test="${rule.empGroup == false}">
										<option value="true">true</option>
										<option value="false" selected="selected">false</option>
									</c:when>
								</c:choose>
							</select>
						</td>
						<td>
							<select name="ruleList[${ruleIndex.index}].emailSend">
								<c:choose>
									<c:when test="${rule.emailSend == true}">
										<option value="true" selected="selected">true</option>
										<option value="false">false</option>
									</c:when>
									<c:when test="${rule.emailSend == false}">
										<option value="true">true</option>
										<option value="false" selected="selected">false</option>
									</c:when>
								</c:choose>
							</select>
						</td>
						<td>
							<input type="text" name="ruleList[${ruleIndex.index}].notes" value="${rule.notes}"/>
						</td>
					</tr>
			</c:forEach>
			
			<!-- register/modify rules -->
			<tr bordercolor="white">
			</tr>
			<tr bordercolor="white">
				<td align="right" colspan="8">
					<button onclick="document.pressed=this.value" value="insert">new</button>
					<button onclick="document.pressed=this.value" value="update">save</button>
					<button onclick="document.pressed=this.value" value="delete">delete all</button>
				</td>
			</tr>
		</table>
	</form>
</center>




</body>
</html>