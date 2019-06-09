pragma solidity ^0.5.0;

contract Election {
    //Model a candidate
    struct Candidate {
      uint id;
      string name;
      uint voteCount;
    }

    //Sprema racune koji su glasali
    mapping(address => bool) public voters;
    //Sprema kandidate
    //Dohvaca kandidate
    mapping(uint => Candidate) public candidates;
    //Store Candidates Counter
    uint public candidatesCount;

    //event za vote
    event votedEvent (
      uint indexed _candidateId
      );
    //
    constructor() public {
        addCandidate("Ivan Ivic");
      addCandidate("Ivanka Ivankovic");
      addCandidate("Smiljan Smiljic");
      addCandidate("Elena Elenvic");
      addCandidate("Mirela Mirelic");
    }

    function addCandidate (string memory _name) private {
    
      candidatesCount ++;
      candidates[candidatesCount] = Candidate(candidatesCount, _name, 0);
    }

    function vote (uint _candidateId) public {
      //provjera da glasac nije glasao
      require(!voters[msg.sender]);

      //mora biti validan kandidat
      require(_candidateId > 0 && _candidateId <= candidatesCount);

      //spremi glas
      voters[msg.sender] = true;

      //Update broja glasova
      candidates[_candidateId].voteCount ++;

      //trigger event
      emit votedEvent(_candidateId);
    }

}
