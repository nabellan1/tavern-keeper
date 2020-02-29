/// @DnDAction : YoYo Games.Common.Execute_Code
/// @DnDVersion : 1
/// @DnDHash : 56DFBE53
/// @DnDArgument : "code" "//when customer collides with table, check occupation and teleport to free chair$(13_10)//not using collision event as it prevents customers from clipping into the table's bounding box$(13_10)tableCustomer = instance_position(x, y, obj_customer); $(13_10)if (tableCustomer != noone) {$(13_10)	for (var i = 0; i < array_length_1d(chairList); i++) { $(13_10)		checkChair = chairList[i]$(13_10)		if (!checkChair.occupied) {$(13_10)			//initial chair teleport$(13_10)			chairX = checkChair.x;$(13_10)			chairY = checkChair.y;$(13_10)			$(13_10)			tableCustomer.direction = checkChair.chairDirection;$(13_10)			if (checkChair.chairDirection == 0) {$(13_10)				chairY -= 20;$(13_10)			}$(13_10)			if (checkChair.chairDirection == 90) {$(13_10)				chairY -= 20;$(13_10)			}$(13_10)			if (checkChair.chairDirection == 180) {$(13_10)				chairY -= 20;$(13_10)			}$(13_10)			if (checkChair.chairDirection == 270) {$(13_10)				tableCustomer.depth = -45;$(13_10)			}$(13_10)			$(13_10)			//teleport customer to chair$(13_10)			tableCustomer.x = chairX;$(13_10)			tableCustomer.y = chairY;$(13_10)			$(13_10)			//break once empty chair found$(13_10)			break;$(13_10)		}$(13_10)	}$(13_10)}$(13_10)$(13_10)//update chairs available number realtime$(13_10)chairsAvailable = 4;$(13_10)for (var i = 0; i < array_length_1d(chairList); i++) { $(13_10)	if (chairList[i].occupied) {$(13_10)		chairsAvailable -= 1;$(13_10)	}$(13_10)}"
//when customer collides with table, check occupation and teleport to free chair
//not using collision event as it prevents customers from clipping into the table's bounding box
tableCustomer = instance_position(x, y, obj_customer); 
if (tableCustomer != noone) {
	for (var i = 0; i < array_length_1d(chairList); i++) { 
		checkChair = chairList[i]
		if (!checkChair.occupied) {
			//initial chair teleport
			chairX = checkChair.x;
			chairY = checkChair.y;
			
			tableCustomer.direction = checkChair.chairDirection;
			if (checkChair.chairDirection == 0) {
				chairY -= 20;
			}
			if (checkChair.chairDirection == 90) {
				chairY -= 20;
			}
			if (checkChair.chairDirection == 180) {
				chairY -= 20;
			}
			if (checkChair.chairDirection == 270) {
				tableCustomer.depth = -45;
			}
			
			//teleport customer to chair
			tableCustomer.x = chairX;
			tableCustomer.y = chairY;
			
			//break once empty chair found
			break;
		}
	}
}

//update chairs available number realtime
chairsAvailable = 4;
for (var i = 0; i < array_length_1d(chairList); i++) { 
	if (chairList[i].occupied) {
		chairsAvailable -= 1;
	}
}