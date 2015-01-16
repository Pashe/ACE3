/*
	Name: ACE_Explosives_fnc_addClacker

	Author(s):
		Garth de Wet (LH)

	Description:
		Adds an explosive as a clacker item to the passed unit if the unit has a ACE_Clacker item.

	Parameters:
		0: OBJECT - unit
		1: OBJECT - Explosive
		2: STRING - Magazine
		3: ARRAY - Extra vars

	Returns:
		Nothing

	Example:
		[_unit, _explosive, "SatchelCharge_Remote_Mag", [ConfigFile >> "CfgACE_Triggers" >> "Command"]] call ACE_Explosives_fnc_AddClacker;
*/
#include "script_component.hpp"
private ["_unit", "_explosive", "_clacker", "_config", "_magazineClass", "_requiredItems", "_hasRequired"];
_unit = _this select 0;
_explosive = _this select 1;
_magazineClass = _this select 2;
// Config is the last item in the list of passed in items.
_config = (_this select 3) select (count (_this select 3) - 1);

_requiredItems = getArray(_config >> "requires");
_hasRequired = true;
_detonators = [_unit] call FUNC(getDetonators);
{
	if !(_x in _detonators) exitWith{
		_hasRequired = false;
	};
} count _requiredItems;

if !(_hasRequired) exitWith {};
_config = ConfigFile >> "CfgMagazines" >> _magazineClass >> "ACE_Triggers" >> configName _config;

_clacker = _unit getVariable [QGVAR(Clackers), []];
GVAR(PlacedCount) = GVAR(PlacedCount) + 1;
_clacker pushBack [_explosive, getNumber(_config >> "FuseTime"), format [localize "STR_ACE_Explosives_DetonateCode",
	GVAR(PlacedCount)], _magazineClass, configName ((_this select 3) select (count (_this select 3) - 1))];
_unit setVariable [QGVAR(Clackers), _clacker, true];
_unit sideChat format [localize "STR_ACE_Explosives_DetonateCode", GVAR(PlacedCount)];