/*
 * Author: NouberNou
 * Handle self action key up
 *
 * Argument:
 * None
 *
 * Return value:
 * true <BOOL>
 *
 * Public: No
 */
#include "script_component.hpp"

if (uiNamespace getVariable [QGVAR(cursorMenuOpened),false]) then {
    closeDialog 0;
};

if(GVAR(actionSelected)) then {
    this = GVAR(selectedTarget);

    private ["_player","_target","_actionData"];
    _player = ACE_Player;
    _target = GVAR(selectedTarget);

    // Clear the conditions caches
    ["clearConditionCaches", []] call EFUNC(common,localEvent);

    // Check the action conditions
    _actionData = GVAR(selectedAction) select 0;
    if ([_target, _player, _actionData select 6] call (_actionData select 4)) then {
        // Call the statement
        [_target, _player, _actionData select 6] call (_actionData select 3);

        // Clear the conditions caches again if the action was performed
        ["clearConditionCaches", []] call EFUNC(common,localEvent);
    };
};

if (GVAR(keyDownSelfAction)) then {
    GVAR(keyDownSelfAction) = false;
    ["interactMenuClosed", [1]] call EFUNC(common,localEvent);
};

GVAR(expanded) = false;
GVAR(lastPath) = [];
GVAR(menuDepthPath) = [];
true