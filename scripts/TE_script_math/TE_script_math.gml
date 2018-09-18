/// @description Set variable from global.nspDsMap to another value

#region Temp variables

var target	= argument0;
var symbol	= argument1;
var formula	= argument2;

var get = 0;
var result	= 0;

#endregion

#region CALCULATE
if (!is_undefined(formula))
{
	result = NSP_evaluate(formula);
}
// Get variable
get = real(TE_get_variable(target));
// Do the math
switch (symbol)
{
	case "=" :
		get		= result;
		//global.nspDsMap[? target] = result;
		break;
	case "+=" :
		get		+= result;
		//global.nspDsMap[? target] += result;
		break;
	case "-=" :
		get		-= result;
		//global.nspDsMap[? target] -= result;
		break;
	case "*=" :
		get		*= result;
		//global.nspDsMap[? target] *= result;
		break;
	case "/=" :
		get		/= result;
		//global.nspDsMap[? target] /= result;
		break;
	case "MOD" :
		get		%= result;
		//global.nspDsMap[? target] %= result;
		break;
	case "ROUND" :
		get		= round(get);
		//global.nspDsMap[? target] = round(global.nspDsMap[? target]);
		break;
	case "FLOOR" :
		get		= floor(get);
		//global.nspDsMap[? target] = floor(global.nspDsMap[? target]);
		break;
	case "CEIL" :
		get		= ceil(get);
		//global.nspDsMap[? target] = ceil(global.nspDsMap[? target]);
		break;
	case "ABS"	:
		get		= abs(get);
		//global.nspDsMap[? target] = abs(result);
		break;
	case "SIN"	:
		get		= sin(get);
		//global.nspDsMap[? target] *= sin(result);
		break;
	case "COS"	:
		get		= cos(get);
		//global.nspDsMap[? target] *= cos(result);
		break;
	case "TAN"	:
		get		= tan(get);
		//global.nspDsMap[? target] *= tan(result);
		break;
}
TE_set_variable(argument0, get);

#endregion