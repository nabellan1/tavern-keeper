/// @DnDAction : YoYo Games.Common.Execute_Code
/// @DnDVersion : 1
/// @DnDHash : 1AF83E54
/// @DnDArgument : "code" "//initial seatable state$(13_10)seatable = true;$(13_10)seated = false; //second check for table collision $(13_10)pointed = false;$(13_10)depth = -50;$(13_10)$(13_10)//distance to edges of rug from center$(13_10)//padding defines a smaller rectangle within the rug's rectangle$(13_10)vEdge = obj_rug.sprite_height / 2;$(13_10)wEdge = obj_rug.sprite_width / 2;$(13_10)//random point on rug$(13_10)rugX = irandom_range(obj_rug.x - wEdge, obj_rug.x + wEdge);$(13_10)rugY = irandom_range(obj_rug.y - vEdge - spawnOffset, obj_rug.y + vEdge);$(13_10)rugMove = true;$(13_10)$(13_10)//initial variables for food and drink and waiting mechanics$(13_10)waitBegan = false;$(13_10)requestBegan = false;$(13_10)serveFailed = false;$(13_10)servePassed = false;$(13_10)vExit = noone;$(13_10)hExit = noone;$(13_10)foodOrDrink = noone;$(13_10)wants = noone; //stores what the customer wanted for use after their bubble is deleted$(13_10)walkOutSet = false;$(13_10)$(13_10)//color and animation variables$(13_10)//[down, up, left, right] $(13_10)redArray = [spr_customerRDown, spr_customerRUp, spr_customerRLeft, spr_customerRRight];$(13_10)blueArray = [spr_customerBDown, spr_customerBUp, spr_customerBLeft, spr_customerBRight];$(13_10)yellowArray = [spr_customerYDown, spr_customerYUp, spr_customerYLeft, spr_customerYRight];$(13_10)colorArray = yellowArray; //default to yellow$(13_10)"
//initial seatable state
seatable = true;
seated = false; //second check for table collision 
pointed = false;
depth = -50;

//distance to edges of rug from center
//padding defines a smaller rectangle within the rug's rectangle
vEdge = obj_rug.sprite_height / 2;
wEdge = obj_rug.sprite_width / 2;
//random point on rug
rugX = irandom_range(obj_rug.x - wEdge, obj_rug.x + wEdge);
rugY = irandom_range(obj_rug.y - vEdge - spawnOffset, obj_rug.y + vEdge);
rugMove = true;

//initial variables for food and drink and waiting mechanics
waitBegan = false;
requestBegan = false;
serveFailed = false;
servePassed = false;
vExit = noone;
hExit = noone;
foodOrDrink = noone;
wants = noone; //stores what the customer wanted for use after their bubble is deleted
walkOutSet = false;

//color and animation variables
//[down, up, left, right] 
redArray = [spr_customerRDown, spr_customerRUp, spr_customerRLeft, spr_customerRRight];
blueArray = [spr_customerBDown, spr_customerBUp, spr_customerBLeft, spr_customerBRight];
yellowArray = [spr_customerYDown, spr_customerYUp, spr_customerYLeft, spr_customerYRight];
colorArray = yellowArray; //default to yellow