/// @DnDAction : YoYo Games.Common.Execute_Code
/// @DnDVersion : 1
/// @DnDHash : 3F523FCE
/// @DnDArgument : "code" "//RUG ENTRANCE$(13_10)//only runs until rugMove is false, then never again$(13_10)//move towards point until close enough by moveOffset$(13_10)//the and seatable clause prevents customers moving at the time of seating from moving when they are seated, !seatable customers moved to last else if$(13_10)if (rugMove and distance_to_point(rugX, rugY) > moveOffset and seatable) { $(13_10)	move_towards_point(rugX, rugY, spd); $(13_10)}$(13_10)//if other customer is at target coordinate WHEN REACHED, re-randomize coordinates$(13_10)else if (rugMove and place_meeting(x, y, obj_customer) and seatable){$(13_10)	rugX = irandom_range(obj_rug.x - wEdge, obj_rug.x + wEdge);$(13_10)	rugY = irandom_range(obj_rug.y - vEdge - spawnOffset, obj_rug.y + vEdge);$(13_10)}$(13_10)//when reaching target with no customer at location, stop movement$(13_10)//setting rugMove to false so this and other rugMove code segments are not used again$(13_10)else if (rugMove) {$(13_10)	speed = 0;$(13_10)	rugMove = false;$(13_10)	alarm[0] = room_speed * patience; //start timer for waiting on floor once customer is situated$(13_10)}$(13_10)$(13_10)//set color array for walking animations$(13_10)//possible to change color once spawned (maybe useful)$(13_10)switch (color) { $(13_10)	case "red":$(13_10)	colorArray = redArray;$(13_10)	break;$(13_10)	case "blue":$(13_10)	colorArray = blueArray;$(13_10)	break;$(13_10)	case "yellow": $(13_10)	colorArray = yellowArray;$(13_10)	break;$(13_10)}$(13_10)//WALKING DIRECTION CHANGE$(13_10)//change sprite based on movement { //not moving, still sprites$(13_10)//all cases are first direction inclusive$(13_10)//IF MOVING (SPEED > 0)$(13_10)if (speed > 0) {$(13_10)	if (direction >= 315 || direction < 45) { //RIGHT$(13_10)		sprite_index = colorArray[3]; $(13_10)	}$(13_10)	else if (direction >= 45 && direction < 135) { //UP$(13_10)		sprite_index = colorArray[1]; $(13_10)	}$(13_10)	else if (direction >= 135 && direction < 225) { //LEFT$(13_10)		sprite_index = colorArray[2]; $(13_10)	}$(13_10)	else { //DOWN$(13_10)		sprite_index = colorArray[0]; $(13_10)	}$(13_10)}$(13_10)//IF NOT MOVING (SPEED = 0)$(13_10)//uses first frame of each directional animation$(13_10)else {$(13_10)if (direction >= 315 || direction < 45) { //RIGHT$(13_10)		sprite_index = colorArray[3]; $(13_10)		image_index = 0;$(13_10)	}$(13_10)	else if (direction >= 45 && direction < 135) { //UP$(13_10)		sprite_index = colorArray[1]; $(13_10)		image_index = 0;$(13_10)	}$(13_10)	else if (direction >= 135 && direction < 225) { //LEFT$(13_10)		sprite_index = colorArray[2]; $(13_10)		image_index = 0;$(13_10)	}$(13_10)	else { //DOWN$(13_10)		sprite_index = colorArray[0]; $(13_10)		image_index = 0;$(13_10)	}$(13_10)}$(13_10)//idle turn arounds if speed is 0 and not seated chance per update$(13_10)//also chance it will randomly select the same direction$(13_10)if (speed = 0 and irandom_range(1, 200) == 1 and seatable) {$(13_10)	direction = irandom_range(0, 360);$(13_10)}$(13_10)$(13_10)//CUSTOMER SELECTION POINTER MECHANICS$(13_10)//if selected by player and no cursor exists, create one$(13_10)if ((controller.customerSelect = id) and !instance_exists(obj_customerPointer)) { $(13_10)	instance_create_layer(x, y - pointerOffset, "Instances", obj_customerPointer);$(13_10)	pointed = true; //instance flagged as pointed to $(13_10)}$(13_10)//if instance is pointed to, track customer and delete pointer when unselected$(13_10)if (pointed) { $(13_10)	obj_customerPointer.x = x;$(13_10)	obj_customerPointer.y = y - pointerOffset;$(13_10)	if (controller.customerSelect != id or !seatable) { //if deselected or no longer seatable$(13_10)		instance_destroy(obj_customerPointer);$(13_10)		pointed = false;$(13_10)	}	$(13_10)}$(13_10)$(13_10)//CUSTOMER PATIENCE WALKING OUT AND BUBBLE$(13_10)//bubble follow$(13_10)if (instance_exists(bubble)) {$(13_10)	bubble.x = x + 20;$(13_10)	bubble.y = y - 40;$(13_10)}$(13_10)$(13_10)//off screen deletion$(13_10)if (y > room_height + deleteOffset and !rugMove) { //!rugmove, only if customer has already walked in$(13_10)	instance_destroy(bubble);$(13_10)	instance_destroy();$(13_10)}$(13_10)$(13_10)//FOOD AND DRINK EVENTS$(13_10)//patience -> how long customer will wait to be seated/served before leaving$(13_10)//wait -> time between sitting and wanting food/drink$(13_10)//stay -> time between being served and leaving$(13_10)//alarms are measured in steps, alarm[0] = room_speed is 1 second$(13_10)$(13_10)//once seated, timer for requesting food/drink begins$(13_10)if (!seatable and !waitBegan) { //waitBegan initial value is false, used so alarm is only set once$(13_10)	waitBegan = true;$(13_10)	alarm[1] = room_speed * wait;$(13_10)}$(13_10)//once food/drink is requested, patience timer$(13_10)if (instance_exists(bubble) and !requestBegan) { $(13_10)	requestBegan = true;$(13_10)	alarm[2] = room_speed * patience;$(13_10)}$(13_10)//immediately activates alarm 2 if bubble is destroyed (customer is served not activated if serve was failed)$(13_10)if (!instance_exists(bubble) and requestBegan and !walkOutSet) { //walkOutSet is set true in alarm2, this if statement should not urn after alarm 2 triggers$(13_10)	alarm[2] = 1; $(13_10)}$(13_10)//walk out pathing when leaving after seated$(13_10)if (serveFailed or servePassed) {$(13_10)	//move towards exit vertical movement first$(13_10)	if (vExit != noone) { $(13_10)		if (distance_to_point(x, vExit) < moveOffset) {$(13_10)			vExit = noone;$(13_10)		}$(13_10)		else {$(13_10)			move_towards_point(x, vExit, spd)$(13_10)		}$(13_10)	}$(13_10)	//move towards exit horizontal movement$(13_10)	else if (hExit != noone) { $(13_10)		if (distance_to_point(hExit, y) < moveOffset) { $(13_10)			hExit = noone;$(13_10)		}$(13_10)		else {$(13_10)			move_towards_point(hExit, y, spd) $(13_10)		}$(13_10)	}$(13_10)	//when centered in room, move down offscreen$(13_10)	else {$(13_10)		direction = 270;$(13_10)	}$(13_10)}$(13_10)$(13_10)$(13_10)$(13_10)$(13_10)"
//RUG ENTRANCE
//only runs until rugMove is false, then never again
//move towards point until close enough by moveOffset
//the and seatable clause prevents customers moving at the time of seating from moving when they are seated, !seatable customers moved to last else if
if (rugMove and distance_to_point(rugX, rugY) > moveOffset and seatable) { 
	move_towards_point(rugX, rugY, spd); 
}
//if other customer is at target coordinate WHEN REACHED, re-randomize coordinates
else if (rugMove and place_meeting(x, y, obj_customer) and seatable){
	rugX = irandom_range(obj_rug.x - wEdge, obj_rug.x + wEdge);
	rugY = irandom_range(obj_rug.y - vEdge - spawnOffset, obj_rug.y + vEdge);
}
//when reaching target with no customer at location, stop movement
//setting rugMove to false so this and other rugMove code segments are not used again
else if (rugMove) {
	speed = 0;
	rugMove = false;
	alarm[0] = room_speed * patience; //start timer for waiting on floor once customer is situated
}

//set color array for walking animations
//possible to change color once spawned (maybe useful)
switch (color) { 
	case "red":
	colorArray = redArray;
	break;
	case "blue":
	colorArray = blueArray;
	break;
	case "yellow": 
	colorArray = yellowArray;
	break;
}
//WALKING DIRECTION CHANGE
//change sprite based on movement { //not moving, still sprites
//all cases are first direction inclusive
//IF MOVING (SPEED > 0)
if (speed > 0) {
	if (direction >= 315 || direction < 45) { //RIGHT
		sprite_index = colorArray[3]; 
	}
	else if (direction >= 45 && direction < 135) { //UP
		sprite_index = colorArray[1]; 
	}
	else if (direction >= 135 && direction < 225) { //LEFT
		sprite_index = colorArray[2]; 
	}
	else { //DOWN
		sprite_index = colorArray[0]; 
	}
}
//IF NOT MOVING (SPEED = 0)
//uses first frame of each directional animation
else {
if (direction >= 315 || direction < 45) { //RIGHT
		sprite_index = colorArray[3]; 
		image_index = 0;
	}
	else if (direction >= 45 && direction < 135) { //UP
		sprite_index = colorArray[1]; 
		image_index = 0;
	}
	else if (direction >= 135 && direction < 225) { //LEFT
		sprite_index = colorArray[2]; 
		image_index = 0;
	}
	else { //DOWN
		sprite_index = colorArray[0]; 
		image_index = 0;
	}
}
//idle turn arounds if speed is 0 and not seated chance per update
//also chance it will randomly select the same direction
if (speed = 0 and irandom_range(1, 200) == 1 and seatable) {
	direction = irandom_range(0, 360);
}

//CUSTOMER SELECTION POINTER MECHANICS
//if selected by player and no cursor exists, create one
if ((controller.customerSelect = id) and !instance_exists(obj_customerPointer)) { 
	instance_create_layer(x, y - pointerOffset, "Instances", obj_customerPointer);
	pointed = true; //instance flagged as pointed to 
}
//if instance is pointed to, track customer and delete pointer when unselected
if (pointed) { 
	obj_customerPointer.x = x;
	obj_customerPointer.y = y - pointerOffset;
	if (controller.customerSelect != id or !seatable) { //if deselected or no longer seatable
		instance_destroy(obj_customerPointer);
		pointed = false;
	}	
}

//CUSTOMER PATIENCE WALKING OUT AND BUBBLE
//bubble follow
if (instance_exists(bubble)) {
	bubble.x = x + 20;
	bubble.y = y - 40;
}

//off screen deletion
if (y > room_height + deleteOffset and !rugMove) { //!rugmove, only if customer has already walked in
	instance_destroy(bubble);
	instance_destroy();
}

//FOOD AND DRINK EVENTS
//patience -> how long customer will wait to be seated/served before leaving
//wait -> time between sitting and wanting food/drink
//stay -> time between being served and leaving
//alarms are measured in steps, alarm[0] = room_speed is 1 second

//once seated, timer for requesting food/drink begins
if (!seatable and !waitBegan) { //waitBegan initial value is false, used so alarm is only set once
	waitBegan = true;
	alarm[1] = room_speed * wait;
}
//once food/drink is requested, patience timer
if (instance_exists(bubble) and !requestBegan) { 
	requestBegan = true;
	alarm[2] = room_speed * patience;
}
//immediately activates alarm 2 if bubble is destroyed (customer is served not activated if serve was failed)
if (!instance_exists(bubble) and requestBegan and !walkOutSet) { //walkOutSet is set true in alarm2, this if statement should not urn after alarm 2 triggers
	alarm[2] = 1; 
}
//walk out pathing when leaving after seated
if (serveFailed or servePassed) {
	//move towards exit vertical movement first
	if (vExit != noone) { 
		if (distance_to_point(x, vExit) < moveOffset) {
			vExit = noone;
		}
		else {
			move_towards_point(x, vExit, spd)
		}
	}
	//move towards exit horizontal movement
	else if (hExit != noone) { 
		if (distance_to_point(hExit, y) < moveOffset) { 
			hExit = noone;
		}
		else {
			move_towards_point(hExit, y, spd) 
		}
	}
	//when centered in room, move down offscreen
	else {
		direction = 270;
	}
}