# Introduction
I have been playing Operation: Flashpoint and its Resistance expansion back in the day, started scripting things for it and made a ton of scenarios and a larger bunch of scripts. I've played the SP campaign of ArmA. I started playing ArmA 2 and its expansions mid-2010, after which I got the taste of scripting and making scenarios again. Safe to say I've spent many nights scripting SQF in the RV engine.

Over time I've collected a bunch of notes and scripts I've used to create my scenarios. It would be selfish to keep them for myself, so here are they. I've tried to sort them on version (ArmA 2 and ArmA 3) and mod (just ACE2).

# General SQF
The following examples should work in both ArmA 2and ArmA 3.

## Everything about groups
### Create a new group
`_grp = group this`
### Moving all units of a group into a vehicle
`{_x moveincargo taxi} foreach units group this`
### Check if a group is inside a vehicle
`({_x in taxi} count units grp1) == (count units grp1)`
### Check if a group is not inside a vehicle
`{_x in taxi} count (units grp1) ==  0`
### Check to see if all playable west units are in a trigger area
`{alive _x && side _x == WEST && vehicle _x in thislist} count allunits == {alive _x && side _x == WEST} count allunits`
### Sources
[http://www.armaholic.com/forums.php?m=posts&q=17454](http://www.armaholic.com/forums.php?m=posts&q=17454)

## Start a script that is part of a mod (requires CBA)
Put in `config.cpp`:

    class CfgPatches {
        class gfs {
            units[] = {};
            weapons[] = {};
            requiredVersion = 1.00;
            requiredAddons[] = {"CBA_MAIN"};
            author[] = {"Bunkerfaust"};
            versionDesc = "Gefechtsfeldsimulator";
            version = "0.29";
        };
    };
    class Extended_PreInit_EventHandlers    {
        class gfs    {
            init = "[] execVM 'gfs\init.sqf';";
    };

## Mute in-game radio commands
`0 fadeRadio 0;  //mute in-game radio commands`

## Removing the Respawn Button
    private["_display","_btnRespawn"];

    disableSerialization;
    waitUntil {
        _display = findDisplay 49;
        !isNull _display;
    };

    _btnRespawn = _display displayCtrl 1010;
    _btnRespawn ctrlEnable false;

## BIS TownCreator with MBG Killhouses
### Houses
* Land_MBG_Killhouse_1
* Land_MBG_Killhouse_2
* Land_MBG_Killhouse_3
* Land_MBG_Killhouse_4
* Land_MBG_Warehouse
* Land_MBG_Killhouse_5
* Land_MBG_Shoothouse_1

### Walls
* Land_MBG_Cinderwall_5
* Land_MBG_Cinderwall_5_Corner
* Land_MBG_Cinderwall_Corner
* Land_MBG_Cinderwall_2p5
* Land_mbg_cinderwall_5_low
* Land_MBG_Cinderwall_5dam
* Land_MBG_Cinderwall_5_WoodDoor
* Land_MBG_Cinderwall_5_SteelDoor
* Land_MBG_Cinderwall_5_Gate
* Land_MBG_Woodplanks
* Land_MBG_Cinderwall_5_Ruins

    this setvariable ["random",50]; this setVariable ["name", "Schaapstad"];
    this setVariable ["townsize", 100]; this setvariable ["houseclassesstart",["Land_A_Mosque_big_minaret_1_EP1"]];
    this setvariable ["houseclasses",["Land_MBG_Killhouse_1", "Land_MBG_Killhouse_2", "Land_MBG_Killhouse_3", "Land_MBG_Killhouse_4", "Land_MBG_Killhouse_5", "Land_MBG_Warehouse", "Land_MBG_Warehouse", "Land_MBG_Shoothouse_1"]];

## Detect a JIP
    if (!(isNull player)) then  //non-JIP player
    {

    };

    if (!isServer && isNull player) then  //JIP player
    {

    };

## Count the building positions
    x = 0;
    while { format ["%1", house buildingPos x] != "[0,0,0]" } do {x = x + 1};
    hint format ["%2: 0 - %1", x-1, "Available positions"];

## Locations and Buildings
### Find all in the cities
    SL_fnc_urbanAreas = {
    	private ["_locations","_cityTypes","_randomLoc","_x","_i","_cities"];
    	_i = 0;
    	_cities = [];

    	_locations = configfile >> "CfgWorlds" >> worldName >> "Names";
    	_cityTypes = ["NameVillage","NameCity","NameCityCapital"];

    	for "_x" from 0 to (count _locations - 1) do {
    		_randomLoc = _locations select _x;
    		// get city info
    		_cityName = getText(_randomLoc >> "name");
    		_cityPos = getArray(_randomLoc >> "position");
    		_cityRadA = getNumber(_randomLoc >> "radiusA");
    		_cityRadB = getNumber(_randomLoc >> "radiusB");
    		_cityType = getText(_randomLoc >> "type");
    		_cityAngle = getNumber(_randomLoc >> "angle");
    		if (_cityType in _cityTypes) then {
    			_cities set [_i,[_cityName, _cityPos, _cityRadA, _cityRadB, _cityType, _cityAngle]];
    			_i = _i + 1;
    		};
    	};
    	_cities;
    };
### Find all the buildings in a give area...
    SL_fnc_findBuildings = {
    	private ["_center","_radius","_buildings"];
    	_center = _this select 0;
    	_radius = _this select 1;
    	_buildings = nearestObjects [_center, ["house"], _radius];
    	_buildings;
    };

# ACRE
## Disable Signal loss (Long range radios now cover the entire island.)
`[0] call acre_api_fnc_setLossModelScale;`
## Retransmit script
Source [http://www.tacticalgamer.com/script-bin/176053-script-acre-retransmit-script.html](http://www.tacticalgamer.com/script-bin/176053-script-acre-retransmit-script.html)
    //Retransmit on Position + Altitude

    private ["_obj","_pos"];
    _obj = _this;
    _pos = getPosATL _obj;
    [[_pos select 0, _pos select 1, (_pos select 2) + 4500], 51.850, 54.500, 20000] call acre_api_fnc_createRxmtStatic;
## Segment the radio frequencies per faction
    if (!isDedicated) then {

      if (isNull player) then {
      	waitUntil {!isNull player};
      };

    	#define FREQ_BASE 30
    	_freqs = [];
    	if (side player == WEST) then {
    		for "_i" from 0 to 99 do {
    			_freq = FREQ_BASE + (_i * 3) + 0.500;
    			_freqs = _freqs + [_freq];
    		};
    	} else {
    		for "_i" from 0 to 99 do {
    			_freq = FREQ_BASE + (_i * 3) + 1.250;
    			_freqs = _freqs + [_freq];
    		};
    	};
    	["ACRE_PRC148", _freqs] call acre_api_fnc_setDefaultChannels;
    	["ACRE_PRC117F", _freqs] call acre_api_fnc_setDefaultChannels;
    	["ACE_P159_RD99", _freqs] call acre_api_fnc_setDefaultChannels;


    	#define FREQ_BASE 2400
    	_freqs = [];
    	if (side player == WEST) then {
    		for "_i" from 0 to 99 do {
    			_freq = FREQ_BASE + _i + 0.200;
    			//_freqs = _freqs + _freq, 50;
    			_freqs = _freqs + [_freq];
    		};
    	} else {
    		for "_i" from 0 to 99 do {
    			_freq = FREQ_BASE + _i + 0.600;
    			//_freqs = _freqs + _freq, 50;
    			_freqs = _freqs + [_freq];
    		};
    	};;
    	["ACRE_PRC343", _freqs] call acre_api_fnc_setDefaultChannels;
    };

# ArmA 2
## Disable Greetings menu
`player setVariable ["BIS_noCoreConversations", true];  //disable greeting menu`
## Place and LHD virtually anywere
* Module: Functions
* GameLogic LHD1
* init.sqf:
    * `waituntil {!isnil "bis_fnc_init"}; LHD1 call BIS_EW_fnc_createLHD;`
* GameLogic
    * `this setDir 90; this setPos [ getPos this select 0, getPos this select 1, (getPos this select 2) -15.6];`

## Players start with a lowered weapon
`player switchMove "amovpercmstpslowwrfldnon_player_idlesteady03";  //lower players weapon`

## Spawn a camp by using DYNO
    if(isServer || isDedicated)then
    {
        _newComp = [(getPos this), (getDir this), "Camp1_TKM_EP1"] call (compile (preprocessFileLineNumbers "ca\modules\dyno\data\scripts\objectMapper.sqf "));
    };

# ACE2
## Start with earplugs in
    //earplugs
    #define __check configFile >> "CfgIdentities" >> "Identity" >> "name"
    _earplugs = {
    	if ( ((getText(__check) == "") || (getText(__check) != (name player))) && isMultiplayer ) then {  
               // indentity incorrect
               // don't wait
    	} else { // wait for init
                waitUntil { sleep 0.5; _earplugs = player getVariable "ace_sys_goggles_earplugs"; !isNil "_earplugs" };
    	};
           player setVariable ["ace_sys_goggles_earplugs", true, false];
           player setVariable ["ace_ear_protection", true, false];
    };
    [] spawn _earplugs;

# ArmA 3
## Custom Radio Channels
* [https://community.bistudio.com/wiki/customRadio](https://community.bistudio.com/wiki/customRadio) - Sends a msg over a custom channel
* [https://community.bistudio.com/wiki/fadeRadio](https://community.bistudio.com/wiki/fadeRadio) - Fades radio
* [https://community.bistudio.com/wiki/radioChannelAdd](https://community.bistudio.com/wiki/radioChannelAdd)
* [https://community.bistudio.com/wiki/radioChannelCreate](https://community.bistudio.com/wiki/radioChannelCreate)
* [https://community.bistudio.com/wiki/radioChannelRemove](https://community.bistudio.com/wiki/radioChannelRemove)
* [https://community.bistudio.com/wiki/radioChannelSetCallSign](https://community.bistudio.com/wiki/radioChannelSetCallSign)
* [https://community.bistudio.com/wiki/radioChannelSetLabel](https://community.bistudio.com/wiki/radioChannelSetLabel)
* [https://community.bistudio.com/wiki/radioVolume](https://community.bistudio.com/wiki/radioVolume)

## Give all to zeus
    _curator addCuratorEditableObjects [vehicles,true];
    _curator addCuratorEditableObjects [(allMissionObjects "Man"),false];
    _curator addCuratorEditableObjects [(allMissionObjects "Air"),true];
    _curator addCuratorEditableObjects [(allMissionObjects "Ammo"),false];

# ACE3
## Removing NVG grain
`ppEffectDestroy ace_nightvision_ppEffectFilmGrain;`
## Detecting if ACE3 is running
* `"ace_main" in activatedAddons`
* `isClass (configFile >> "cfgPatches" >> "ace_main")`
* `missionNamespace getVariable ["ace_common", false]`

## Have a unit never go prone or run away
`this addEventHandler ["Animchanged",{(_this select 0) setunitpos "up"}]; this allowFleeing 0; this forceSpeed 0;`

## Advanced Healing procedure
    - Keeping the patient's vitals stable is your first priority.
    - If advanced wounds are enabled make sure from time to time that they didn't reopen.


    **Step 1:** Is the patient responsive?

    - **Yes:** Ask him if he has wounds / he is in pain and act accordingly.
    - **No:** Go to step 2.


    **Step 2:** Is the patient wounded?

    - **Yes**: Treat the wounds.
    - **No:** Skip this step.


    **Step 3:** Does the patient have a pulse?

    - **Yes:** Go to step 4.
    - **No:** If you are alone provide CPR, if you have someone else get him to do CPR while you treat the patient's wounds. Skip to step 4 or 5 depending on the situation.


    **Step 4:** Did the patient lose a lot of blood?

    - **Yes:** Use IVs to restore the volume of liquid in the blood stream of the patient.
    - **No:** Skip this step.


    **Step 5:** Is the patient in pain?

    - **Yes and stable pulse:** Give him morphine.
    - **Yes and unstable heart rate:** Stabilize the heart rate before administrating morphine.
    - **No:** You're done.


    **Step 6:** is the patient awake now?

    - **Yes:** You're done.
    - **No:** Stabilize his pulse / make sure he isn't in pain or missing blood.

## Adding stuff to cargo
`["ACE_ConcertinaWireCoil ",vehicleVarName] call ace_cargo_fnc_addCargoItem`

# ALiVE
## Profile all non-profiled units
`[false, [_grp1,_grp2,_grp3,_grp4], nil ] call ALIVE_fnc_createProfilesFromUnitsRuntime;`
## Prevent a group from being profiled
`_grp1 setVariable ["ALIVE_profileIgnore", true];`
Marking Active Units
`[] call ALIVE_fnc_markUnits`
Enabling profile debug
`ALiVE_SYS_PROFILE setVariable ["debug","false", true];`
## Enabling profile debug
`[] call ALIVE_fnc_profileSystemDebug;`
## Toggle IED and OPCOM installations
`[] call ALIVE_fnc_OPCOMToggleInstallations;`
## Storing stuff in databases
* ALiVE_fnc_getHash
* ALiVE_fnc_setHash

```
    ligthert [6:56 PM]    @highhead: Do you happen to know something about the _getHash and _setHash functions?
    highhead [6:57 PM]    its a wrapper for the CBA fncs
    highhead [6:57 PM]    what do you need
    highhead [6:58 PM]    actually they set and get data to arrays that look like ["CBA_HASH",_key,_value,_defaultValue]
    highhead [6:58 PM]    HashGet allows you to return custom defaultvalues
    ligthert [7:01 PM]    The reason I am asking is because I found out that despite persistence's best efforts some vehicles and objects (and objectives) don't stay dead after loading the scenario again. I was thinking of putting all these objectives and objects in an array and have the stored in the database. Basically abusing _setHash and _getHash as a  glorified database abstraction layer to counteract this problem. :simple_smile:
    highhead [7:01 PM]    so you can basically store ANY data easily by....
    _myDataHandler = [] call ALiVE_fnc_HashCreate;
    [_myDataHandler,"age",36] call ALiVE_fnc_HashSet;
    [_myDataHandler,"size",185] call ALiVE_fnc_HashSet;
    [_myDataHandler,"eyes","blue"] call ALiVE_fnc_HashSet;
    [_myDataHandler,"gay",false] call ALiVE_fnc_HashSet;
    [_myDataHandler,"body",objNull] call ALiVE_fnc_HashSet;
    you can then get the data with:
    _age = [_myDataHandler,"age",100] call ALiVE_fnc_HashGet;
    etc....
    ligthert [7:02 PM]    but but but, in the last example you put down ​_100_​, won't this fudge the value you get from hashGet up?
    ligthert [7:02 PM]    Or is this de default value?
    highhead [7:03 PM]    if the the age data within _myDataHandler would be not existing it would return 100
    highhead [7:03 PM]    default value
    ligthert [7:05 PM]    I see. :simple_smile:
    ligthert [7:05 PM]    Are these hashes in a ​_namespace_​ of the scenario or can I steal other people's hashes? :simple_smile:
    Pause OPCOM when the last player disconnected
    In the initServer.sqf:
    ["someId", "onPlayerConnected", { if (({isPlayer _x} count playableUnits) > 0 || OPCOM_TOGGLE) then { ["ALIVE_MIL_OPCOM"] call ALiVE_fnc_unPauseModule; OPCOM_TOGGLE = false; };}] call BIS_fnc_addStackedEventHandler;
    ["someId", "onPlayerDisconnected", { if ( ({isPlayer _x} count playableUnits) == 0 ) then { ["ALIVE_MIL_OPCOM"] call ALiVE_fnc_pauseModule; OPCOM_TOGGLE = true; };}] call BIS_fnc_addStackedEventHandler;
    Putting crates into objects
    [ALiVE_SYS_LOGISTICS,"fillContainer",[_vehicle,_payload]] call ALiVE_fnc_Logistics;
    _payload is an array with class-names or objects
```

## Opening stuff from addAction
    this addAction ["Operations", {["OPEN_OPS",[]] call ALIVE_fnc_SCOMTabletOnAction}];
    this addAction ["Intel", {["OPEN_INTEL",[]] call ALIVE_fnc_SCOMTabletOnAction}];
    this addAction ["Logistics", {["OPEN",[]] call ALIVE_fnc_PRTabletOnAction}];
    this addAction ["Tasking", {[] call ALiVE_fnc_C2MenuDef}];
    this addAction ["Combat Support", {["radio"] call ALIVE_fnc_radioAction}];

## Adding custom CQB zones
    highhead [6:22 PM] Set up CQB as you would normally.
    highhead [6:23 PM] In Init.sqf put: [ALiVE_mil_CQB getVariable ["instances",[]]] call ALiVE_fnc_resetCQB;
    highhead [6:23 PM] then activate your zones with: [_pos,_radius,_CQB] spawn ALiVE_fnc_addCQBpositions.
    highhead [6:24 PM]whereas _CQB are instances of CQB modules. So the missionmaker f.e. can give it a name in editor, f.e. "CQB_regular" or "CQB_strategic" and
    highhead [6:24 PM]put it in like [_pos,_radius,[CQB_Regular]] spawn ALiVE_fnc_addCQBpositions. (edited)
    highhead [6:42 PM]  f.e. A mission maker wants to have CQB in all strategic positions over the map from the beginning of the mission. Regular CQB in a specific location should be activated by trigger.
    - Add a CQB module on setting strategic and your other favorite settings (f.e. dominantFaction, density etc.).
    - Add a CQB module on setting regular and your other favorite settings (f.e. dominantFaction, density etc.).
    - Give the regular CQB module a name, f.e. myRegularCQBmodule
    put in init.sqf
    myRegularCQBmodule call ALiVE_fnc_resetCQB;
    In your trigger activation put:
    [_pos,_radius,[myRegularCQBmodule]] spawn ALiVE_fnc_addCQBpositions.
    You can also use position thisTrigger and triggerSize variables of the trigger. Just make sure it only fires once :simple_smile:
    highhead [6:44 PM] Additionally you can use [_pos,_radius,[CQB_Regular]] spawn ALiVE_fnc_removeCQBpositions to remove active CQB areas.

# Function Libraries
* [Wolfswan](https://github.com/Wolfenswan/ws_fnc), includes a chaching module of some sorts.
