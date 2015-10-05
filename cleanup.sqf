_parameterCorrect = (_this select 3) params [["_caller",objNull],["_markerName",objNull,["STRING"]],["_radius",0,[0]]];

_hintPlayerInAreaAlive = "Im Gebiet sind noch befreundete Streitkräfte am Leben. Cleanup nicht möglich.";
_hintCleanUpStarted = "Es wird angefangen alle Einheiten im Gebiet zu löschen. Dies kann einen Moment dauern.";
_hintCleanUpSucessfull = "Es wurden alle Einheiten im Gebiet gelöscht.";

_cleanUpSleepTime = 0.1;
if(_parameterCorrect) then {
	_sidePlayer = side _caller;
	_position = getMarkerPos _markerName;
	if(_position select 0 != 0 && _position select 1 != 0) then {
		_objects = _position nearObjects ["Land",_radius];
		// ACE Wheels still present
		_numberBluforAlive = 0;
		{
			if( (side _x) == _sidePlayer) then {
				if(alive _x) then {
					_numberBluforAlive = _numberBluforAlive + 1;
				};
			};
		} foreach _objects;
		if(_numberBluforAlive == 0) then {
			hint _hintCleanUpStarted;
			{
				{
					deleteVehicle _x;
				} foreach crew _x;
				deleteVehicle _x;
				sleep _cleanUpSleepTime;
			} foreach _objects;
			hint _hintCleanUpSucessfull;
		} else {
			hint _hintPlayerInAreaAlive;
		};
	} else {
		hint format ["Script Error: Marker %1 not found %2", str _markerName];
	};
} else {
	hint "Script Error: wrong parameter expected [player,""nameOfMarker"",radiusToCleanup]";
};