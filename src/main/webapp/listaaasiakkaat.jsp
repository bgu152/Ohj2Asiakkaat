<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<script src="scripts/main.js"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<link rel="stylesheet" type="text/css" href="css/main.css">
<title>Listaa asiakkaat</title>


</head>
<body>
	
<table id="listaus">
	<thead>		
		<tr>
			<th colspan = "7" class="oikealle"><span id = "uusiAsiakas">Lisää uusi asiakas</span></th>
		</tr>
		<tr>
			<th class= "oikealle">Hakusana: </th>
			<th colspan = "5"><input type="text" id = "hakusana"></th>
			<th><input type="button" value="hae" id= "hakunappi"></th>
		</tr>		
		<tr>
			
			<th>Asiakas ID</th>
			<th>Etunimi</th>
			<th>Sukunimi</th>
			<th>Puhelin</th>	
			<th colspan = "2">Sähköposti</th>	
				<th></th>					
		</tr>
	</thead>
	<tbody>
	</tbody>
</table>
	<script>
		$(document).ready(function(){
			
			haeAsiakkaat();
			
			$("#uusiAsiakas").click(function(){
				document.location="lisaaasiakas.jsp"
			})

			
			$("#hakunappi").click(function(){
				console.log($("#hakusana").val());
				haeAsiakkaat();
			});
			
		});
		
	function haeAsiakkaat(){
		$("#listaus tbody").empty();
		$.ajax({url:"asiakkaat/" + $("#hakusana").val(), type:"GET", dataType:"json", success:function(result){//Funktio palauttaa tiedot json-objektina
			console.log(result);
			$.each(result.asiakkaat, function(i, field){  
	        	var htmlStr;
	        	htmlStr+="<tr>";
	        	htmlStr+="<td>"+field.asiakas_id+"</td>";
	        	htmlStr+="<td>"+field.etunimi+"</td>";
	        	htmlStr+="<td>"+field.sukunimi+"</td>";
	        	htmlStr+="<td>"+field.puhelin+"</td>";
	        	htmlStr+="<td>"+field.sposti+"</td>"; 
	        	htmlStr+="<td><a href='muutaasiakas2.jsp?asiakas_id="+field.asiakas_id+"'>Muuta</a></td>";
	        	htmlStr+="<td><span class='poista' onclick=poista('"+field.asiakas_id+"')>Poista</span></td>";
	        	
	        	htmlStr+="</tr>";
	        	$("#listaus tbody").append(htmlStr);	        	
	        });			
	    }});
	}
	
	function poista(asiakas_id){
		if(confirm("Poista asiakas " + asiakas_id +"?")){
			$.ajax({url:"asiakkaat/"+asiakas_id, type:"DELETE", dataType:"json", success:function(result) { //result on joko {"response:1"} tai {"response:0"}
		        if(result.response==0){
		        	$("#ilmo").html("Asiakkaan poisto epäonnistui.");
		        }else if(result.response==1){
		        	$("#rivi_"+asiakas_id).css("background-color", "red"); //Värjätään poistetun asiakkaan rivi
		        	alert("Asiakkaan " + asiakas_id +" poisto onnistui.");
					haeAsiakkaat();        	
				}
		    }});
		}
	}
	</script>
</body>
</html>