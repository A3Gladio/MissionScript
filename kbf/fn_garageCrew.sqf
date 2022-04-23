params["_player"];

//If you want to change spawn crew, change here.
//If you want to change spawn crew in random, use selectRandom.
//_bluforCrew = selectRandom ["B_crew_F", "B_Deck_Crew_F"];
_bluforCrew = "B_crew_F";
_opforCrew = "O_crew_F";
_independentCrew = "I_crew_F";
_civilianCrew = "C_man_w_worker_F";

_unitType = switch (side _player) do {
  case west; case blufor : {_bluforCrew;};
  case east; case opfor : {_opforCrew;};
  case independent; case resistance : {_independentCrew;};
  case civilian : {_civilianCrew;};
};

_unitType
