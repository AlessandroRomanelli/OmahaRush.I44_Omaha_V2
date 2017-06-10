addMissionEventHandler ["Draw3D", {
    {
      if !(isPlayer _x && {alive _x} && {side _x == side player}) exitWith {};
        if (side _x == side player && {alive _x}) then {
            _dist = (player distance _x) / 15;
            _color = [0,0.3,0.6,1];
            if (group _x == group player && {alive _x}) then {
              _color = [0.2,0.9,0.2,1];
            };
            if (cursorTarget != _x) then {
                _color set [3, 1 - _dist]
            };
            drawIcon3D [
                '',
                _color,
                [
                    visiblePosition _x select 0,
                    visiblePosition _x select 1,
                    (visiblePosition _x select 2) +
                    ((_x modelToWorld (
                        _x selectionPosition 'head'
                    )) select 2) + 0.4 + _dist / 1.5
                ],
                0,
                0,
                0,
                name _x,
                2,
                0.03,
                'PuristaMedium'
            ];
        };
    } count allUnits - [player];
}];
