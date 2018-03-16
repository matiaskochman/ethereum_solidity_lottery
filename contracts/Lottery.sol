pragma solidity ^0.4.17;

contract Lottery {
    address public manager;
    address[] public players;

    function Lottery() public {
        manager = msg.sender; //msg es una variable global que guarda
    }

    function enter() public payable {
        require(msg.value > .001 ether);

        players.push(msg.sender);
    }

    function random() private view returns (uint) {
        return uint(keccak256(block.difficulty,now,players));
    }

    function pickWinner() public onlyManager returns (uint){
        uint index = random() % players.length;
        players[index].transfer(this.balance);
        players = new address[](0); //create a dinamic array with 0 values at begining
    }
    modifier onlyManager(){
        require(msg.sender == manager);
        _;
    }
    function getPlayers() public view returns (address[]){
        return players;
    }
}
