/// @description Set variable from global.nspDsMap to another value

#region Temp variables

var target	= argument0;
var symbol	= argument1;
var formula	= argument2;

var result	= 0;

#endregion

#region CALCULATE
if (!is_undefined(formula))
{
	result = NSP_evaluate(formula);
}
// Do the math
switch (symbol)
{
	case "=" :
		global.nspDsMap[? target] = result;
		break;
	case "+=" :
		global.nspDsMap[? target] += result;
		break;
	case "-=" :
		global.nspDsMap[? target] -= result;
		break;
	case "*=" :
		global.nspDsMap[? target] *= result;
		break;
	case "/=" :
		global.nspDsMap[? target] /= result;
		break;
	case "MOD" :
		global.nspDsMap[? target] %= result;
		break;
	case "ROUND" :
		global.nspDsMap[? target] = round(global.nspDsMap[? target]);
		break;
	case "FLOOR" :
		global.nspDsMap[? target] = floor(global.nspDsMap[? target]);
		break;
	case "CEIL" :
		global.nspDsMap[? target] = ceil(global.nspDsMap[? target]);
		break;
	case "ABS"	:
		global.nspDsMap[? target] = abs(result);
		break;
	case "SIN"	:
		global.nspDsMap[? target] *= sin(result);
		break;
	case "COS"	:
		global.nspDsMap[? target] *= cos(result);
		break;
	case "TAN"	:
		global.nspDsMap[? target] *= tan(result);
		break;
}

#endregion